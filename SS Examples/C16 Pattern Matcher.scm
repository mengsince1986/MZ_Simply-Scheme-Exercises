; Chapter 16 Example: Pattern Matcher

; ********************************************************** Implementation: When Are Two Sentences Equal?

; Our approach to implementation will be to start with something we already know howi to write: a predicate that tests whether two sentences are exactly equal. We will add capabilities one at a time until we reach our goal.

; Suppose that Scheme’s primitive equal? function worked only for words and not for sentences. We could write an equality tester for sentences, like this:

(define (sent-equal? sent1 sent2)
  (cond ((empty? sent1)
         (empty? sent2))
        ((empty? sent2) #f)
        ((equal? (first sent1) (first sent2))
         (sent-equal? (bf sent1) (bf sent2)))
        (else #f)))

; Two sentences are equal if each word in the first sentence is equal to the corresponding word in the second. They’re unequal if one sentence runs out of words before the other.

; Why are we choosing to accept Scheme’s primitive word comparison but rewrite the sentence comparison?

; In our pattern matcher, a placeholder in the pattern corresponds to a group of words in the sentence. There is no kind of placeholder that matches only part of a word. (It would be possible to implement such placeholders, but we’ve chosen not to.) Therefore, we will never need to ask whether a word is “almost equal” to another word.


; ********************************************************** When Are Two Sentences Nearly Equal?

; Pattern matching is just a more general form of this sent-equal? procedure. Let’s write a very simple pattern matcher that knows only about the “!” special character and doesn’t let us name the words that match the exclamation points in the pattern. We’ll call this one match? with a question mark because it returns just true or false.

(define (match? pattern sent)              ;; first version: ! only
  (cond ((empty? pattern)
         (empty? sent))
        ((empty? sent) #f)
        ((equal? (first pattern) '!)       ;; clause on "!" special character
         (match? (bf pattern) (bf sent)))
        ((equal? (first pattern) (first sent)) (match? (bf pattern) (bf sent)))
        (else #f)))

; This program is exactly the same as sent-equal?, except for the highlighted cond clause. We are still comparing each word of the pattern with the corresponding word of the sentence, but now an exclamation mark in the pattern matches any word in the sentence. (If first of pattern is an exclamation mark, we don’t even look at first of sent.)

; Our strategy in the next several sections will be to expand the pattern matcher by implementing the remaining special characters, then finally adding the ability to name the placeholders. For now, when we say something like “the * placeholder,” we mean the placeholder consisting of the asterisk alone. Later, after we add named placeholders, the same procedures will implement any placeholder that begins with an asterisk.


; ********************************************************** Matching with Alternatives

; The ! matching is not much harder than sent-equal?, because it’s still the case that one word of the pattern must match one word of the sentence. When we introduce the ? option, the structure of the program must be more complicated, because a question mark in the pattern might or might not be paired up with a word in the sentence. In other words, the pattern and the sentence might match without being the same length.

(define (match? pattern sent)                      ;; second version: ! and ?
  (cond ((empty? pattern)
         (empty? sent))
        ((equal? (first pattern) '?)
         (if (empty? sent)
             (match? (bf pattern) '())
             (or (match? (bf pattern) (bf sent))
                 (match? (bf pattern) sent))))
        ((empty? sent) #f)
        ((equal? (first pattern) '!)
         (match? (bf pattern) (bf sent)))
        ((equal? (first pattern) (first sent))
         (match? (bf pattern) (bf sent)))
        (else #f)))

; Note that the new cond clause comes before the check to see if sent is empty. That's because sent might be empty and a pattern of (?) would still match it. But if the sentence is empty, we know that the question mark doesn’t match a word, so we just have to make sure that the butfirst of the pattern contains nothing but question marks. (We don’t have a predicate named all-question-marks?; instead, we use match? recursively to make this test.)

; In general, a question mark in the pattern has to match either one word or zero words in the sentence. How do we decide? Our rule is that each placeholder should match as many words as possible, so we prefer to match one word if we can. But allowing the question mark to match a word might prevent the rest of the pattern from matching the rest of the sentence.

; Compare these two examples:

(match? '(? please me) '(please please me))
; #T

(match? '(? please me) '(please me))
; #T

; In the first case, the first thing in the pattern is a question mark and the first thing in the sentence is “please,” and they match. That leaves “please me” in the pattern to match “please me” in the sentence.

; In the second case, we again have a question mark as the first thing in the pattern and “please” as the first thing in the sentence. But this time, we had better not use up the “please” in the sentence, because that will only leave “me” to match “please me.” In this case the question mark has to match no words.

; To you, these examples probably look obvious. That’s because you’re a human being, and you can take in the entire pattern and the entire sentence all at once. Scheme isn’t as smart as you are; it has to compare words one pair at a time. To Scheme, the processing of both examples begins with question mark as the first word of the pattern and “please” as the first word of the sentence. The pattern matcher has to consider both cases.

; How does the procedure consider both cases? Look at the invocation of or by the match? procedure. There are two alternatives; if either turns out true, the match succeeds. One is that we try to match the question mark with the first word of the sentence just as we matched ! in our earlier example—by making a recursive call on the butfirsts of the pattern and sentence. If that returns true, then the question mark matches the first word.

; The second alternative that can make the match succeed is a recursive call to match? on the butfirst of the pattern and the entire sentence; this corresponds to matching the ? against nothing.

; Actually, sinceoris a special form, Scheme avoids the need to try the second alternative if the first one succeeds.

; Let’s trace match? so that you can see how these two cases are handled differently by the program.

(trace match?)
(match? '(? please me) '(please please me))
; (match? (? please me) (please please me))
; | (match? (please me) (please me))        ; Try matching ? with please.
; | | (match? (me) (me))
; | | | (match? () ())
; | | | #t                                  ; It works!
; | | #t
; | #t
; #t
; #T

(match? '(? please me) '(please me))
; (match? (? please me) (please me))
; | (match? (please me) (me))               ; Try matching ? with please.
; | #f                                      ; It doesn’t work.
; | (match? (please me) (please me))        ; This time, match ? with nothing.
; | | (match? (me) (me))
; | | | (match? () ())
; | | | #t
; | | #t | #t
; #t
; #T


; ********************************************************** Matching Several Words

; The next placeholder we’ll implement is *. The order in which we’re implementing these placeholders was chosen so that each new version increases the variability in the number of words a placeholder can match. The ! placeholder was very easy because it always matches exactly one word; it’s hardly different at all from a non-placeholder in the pattern. Implementing ? was more complicated because there were two alternatives to consider. But for *, we might match any number of words, up to the entire rest of the sentence.

; Our strategy will be a generalization of the ? strategy: Start with a “greedy” match, and then, if a recursive call tells us that the remaining part of the sentence can’t match the rest of the pattern, try a less greedy match.

; The difference between ? and * is that ? allows only two possible match lengths, zero and one. Therefore, these two cases can be checked with two explicit subexpressions of an or expression. In the more general case of *, any length is possible, so we can’t check every possibility separately. Instead, as in any problem of unknown size, we use recursion. First we try the longest possible match; if that fails because the rest of the pattern can’t be matched, a recursive call tries the next-longest match. If we get all the way down to an empty match for the * and still can’t match the rest of the pattern, then we return #f.

(define (match? pattern sent)               ;; third version: !, ?, and *
  (cond ((empty? pattern)
         (empty? sent))
        ((equal? (first pattern) '?)
         (if (empty? sent)
             (match? (bf pattern) '())
             (or (match? (bf pattern) (bf sent))
                 (match? (bf pattern) sent))))
        ((equal? (first pattern) '*)
         (*-longest-match (bf pattern) sent))
        ((empty? sent) #f)
        ((equal? (first pattern) '!)
         (match? (bf pattern) (bf sent)))
        ((equal? (first pattern) (first sent))
         (match? (bf pattern) (bf sent)))
        (else #f)))

(define (*-longest-match pattern-rest sent)
  (*-lm-helper pattern-rest sent '()))

(define (*-lm-helper pattern-rest sent-matched sent-unmatched)
  (cond ((match? pattern-rest sent-unmatched) #t)
        ((empty? sent-matched) #f)
        (else (*-lm-helper pattern-rest
                           (bl sent-matched)
                           (se (last sent-matched) sent-unmatched)))))

; If an asterisk is found in the pattern, match? invokes *-longest-match, which carries out this backtracking approach.

; The real work is done by *-lm-helper, which has three arguments. The first argument is the still-to-be-matched part of the pattern, following the * placeholder that we’re trying to match now. Sent-matched is the part of the sentence that we’re considering as a candidate to match the * placeholder. Sent-unmatched is the remainder of the sentence, following the words in sent-matched; it must match pattern-rest.

; Since we’re trying to find the longest possible match, *-longest-match chooses the entire sentence as the first attempt for sent-matched. Since sent-matched is using up the entire sentence, the initial value of sent-unmatched is empty. The only job of *-longest-match is to invoke *-lm-helper with these initial arguments. On each recursive invocation, *-lm-helper shortens sent-matched by one word and accordingly lengthens sent-unmatched.

; Here’s an example in which the * placeholder tries to match four words, then three words, and finally succeeds with two words:

(trace match? *-longest-match *-lm-helper)

(match? '(* days night) '(a hard days night))
; (match? (* days night) (a hard days night))
; | (*-longest-match (days night) (a hard days night))
; | | (*-lm-helper (days night) (a hard days night) ()) | | | (match? (days night) ())
; | | | #f
; | | | (*-lm-helper (days night) (a hard days) (night))
; | | | | (match? (days night) (night))
; | | | | #f
; | | | | (*-lm-helper (days night) (a hard) (days night)) | | | | | (match? (days night) (days night))
; | | | | | | (match? (night) (night))
; | | | | | | | (match? () ())
; | | | | | | | #t
; | | | | | | #t
; | | | | | #t
; | | | | #t
; | | | #t
; | | #t
; | #t
; #t
; #t


; ********************************************************** Combining the Placeholders

; We have one remaining placeholder, &, which is much like * except that it fails unless it can match at least one word. We could, therefore, write a &-longest-match that would be identical to *-longest-match except for the base case of its helper procedure. If sent-matched is empty, the result is #f even if it would be possible to match the rest of the pattern against the rest of the sentence. (All we have to do is exchange the first two clauses of the cond.)

(define (&-longest-match pattern-rest sent)
  (&-lm-helper pattern-rest sent '()))

(define (&-lm-helper pattern-rest sent-matched sent-unmatched)
  (cond ((empty? sent-matched) #f)
        ((match? pattern-rest sent-unmatched) #t)
        (else (&-lm-helper pattern-rest
                           (bl sent-matched)
                           (se (last sent-matched) sent-unmatched)))))

; When two procedures are so similar, that’s a clue that perhaps they could be combined into one. We could look at the bodies of these two procedures to find a way to combine them textually. But instead, let’s step back and think about the meanings of the placeholders.

; The reason that the procedures *-longest-match and &-longest-match are so similar is that the two placeholders have almost identical meanings. * means “match as many words as possible”; & means “match as many words as possible, but at least one.” Once we’re thinking in these terms, it’s plausible to think of ? as meaning “match as many words as possible, but at most one.” In fact, although this is a stretch, we can also describe ! similarly: “Match as many words as possible, but at least one, and at most one.”

; --------------------------------------------------------
; Placeholder    |    Minimum size    |     Maximum size
; --------------------------------------------------------
;     *          |         0          |       no limit
;     &          |         1          |       no limit
;     ?          |         0          |          1
;     !          |         1          |          1
; --------------------------------------------------------

; We’ll take advantage of this newly understood similarity to simplify the program by using a single algorithm for all placeholders.

; How do we generalize *-longest-match and &-longest-match to handle all four cases? There are two kinds of generalization involved. We’ll write a procedure longest-match that will have the same arguments as *-longest-match, plus two others, one for for the minimum size of the matched text and one for the maximum.

; We’ll specify the minimum size with a formal parameter min. (The corresponding argument will always be 0 or 1.) Longest-match will pass the value of min down to lm-helper, which will use it to reject potential matches that are too short.

; Unfortunately, we can’t use a number to specify the maximum size, because for * and & there is no maximum. Instead, longest-match has a formal parameter max-one? whose value is #t only for ? and !.

; Our earlier, special-case versions of longest-match were written for * and &, the placeholders for which max-one? will be false. For those placeholders, the new longest-match will be just like the earlier versions. Our next task is to generalize longest-match so that it can handle the #t cases.

; Think about the meaning of the sent-matched and sent-unmatched parameters in the lm-helper procedures. Sent-matched means “the longest part of the sentence that this placeholder is still allowed to match,” while sent-unmatched contains whatever portion of the sentence has already been disqualified from being matched by the placeholder.

; Consider the behavior of *-longest-match when an asterisk is at the begin- ning of a pattern that we’re trying to match against a seven-word sentence. Initially, sent-matched is the entire seven-word sentence, and sent-unmatched is empty. Then, supposing that doesn’t work, sent-matched is a six-word sentence, while sent-unmatched contains the remaining word. This continues as long as no match succeeds until, near the end of longest-match’s job, sent-matched is a one-word sentence and sent-unmatched contains six words. At this point, the longest possible match for the asterisk is a single word.

; This situation is where we want to start in the case of the ? and ! placeholders. So when we’re trying to match one of these placeholders, our initialization procedure won’t use the entire sentence as the initial value of sent-matched; rather, the initial value of sent-matched will be a one-word sentence, and sent-unmatched will contain the rest of the sentence.

(define (longest-match pattern-rest sent min max-one?)                       ;; first version
  (cond ((empty? sent)
         (and (= min 0) (match? pattern-rest sent)))                         ;; if the sentence is empty and the minimum size of the pattern is 0, just check if the rest of the pattern is matched by the empty sentence
        (max-one?
          (lm-helper pattern-rest (se (first sent)) (bf sent) min))          ;; if the sentence is not empty and the max size of the placeholder is 1, pass the pattern-rest, the first element of the sentence as sent-matched, the (bf sent) as sent-unmatched and min to lm-helper. This condition is for ? and !.
        (else (lm-helper pattern-rest sent '() min))))                       ;; if the sentence is not empty and the max size of the placeholder is not limited to 1, pass the pattern-rest, sent as sent-matched, '() as sent-unmatched and min to lm-helper. This condition is for * and &

(define (lm-helper pattern-rest sent-matched sent-unmatched min)
  (cond ((< (length sent-matched) min) #f)                                   ;; if the length of sent-matched is less than the minimum size of the placeholder, return false immediately. This condition is for & and !.
        ((match? pattern-rest sent-unmatched) #t)                            ;; if the length of sent-matched is not less than the minimum size of the placeholder, and (match? pattern-rest sent-unmatched) is true, return true immediately.
        ((empty? sent-matched) #f)                                           ;; if the length of sent-matched is not less than the minimum size of the placeholder, the sent-unmatched does not match the pattern-rest, and the sent-matched is empty, return false immediately.
        (else (lm-helper pattern-rest                                        ;; if the length of sent-matched is not less than the minimum size of the placeholder, the sent-unmatched does not match the pattern-rest, and the sent-matched is not empty, pass the pattern-rest, the (bl sent-matched) as sent-matched, (se (last sent-matched) sent-unmaatched) as sent-unmatched and min to the next recursive call.
                         (bl sent-matched)
                         (se (last sent-matched) sent-unmatched)
                         min))))

; Now we can rewrite match? to use longest-match. Match? will delegate the handling of all placeholders to a subprocedure match-special that will invoke longest-match with the correct values for min and max-one? according to the table.

(define (match? pattern sent)                                      ;; fourth version
  (cond ((empty? pattern)
         (empty? sent))                                            ;; if the pattern is empty, the result is determined by if the sentence is empty or not.
        ((special? (first pattern))
         (match-special (first pattern) (bf pattern) sent))        ;; if the first of the pattern is a special character, pass the (first pattern) as placeholder, the (bf pattern) as pattern-rest and sent to match-special.
        ((empty? sent) #f)                                         ;; if the pattern is not empty and the there is not special character in the pattern, and the the sent is empty, return #f immediately.
        ((equal? (first pattern) (first sent))
         (match? (bf pattern) (bf sent)))                          ;; if the first non-special character in the pattern is matched by the first character of sent, invoke the next recursive call.
        (else #f)))                                                ;; if the first non-special character in the pattern is not matched by the first character of sent, return #f immediately.

(define (special? wd) (member? wd '(* & ? !)))                     ;; first version

(define (match-special placeholder pattern-rest sent)              ;; first version
  (cond ((equal? placeholder '?)
         (longest-match pattern-rest sent 0 #t))
        ((equal? placeholder '!)
         (longest-match pattern-rest sent 1 #t))
        ((equal? placeholder '*)
         (longest-match pattern-rest sent 0 #f))
        ((equal? placeholder '&)
         (longest-match pattern-rest sent 1 #f))))


; ********************************************************** Naming the Matched Text

; So far we’ve worked out how to match the four kinds of placeholders and return a true or false value indicating whether a match is possible. Our program is almost finished; all we need to make it useful is the facility that will let us find out which words in the sentence matched each placeholder in the pattern.

; We don’t have to change the overall structure of the program in order to make this work. But most of the procedures in the pattern matcher will have to be given an additional argument, the database of placeholder names and values that have been matched so far. The formal parameter known-values will hold this database. Its value will be a sentence containing placeholder names followed by the corresponding words and an exclamation point to separate the entries, as in the examples earlier in the chapter. When we begin the search for a match, we use an empty sentence as the initial known-values:

(define (match pattern sent)
  (match-using-known-values pattern sent '()))

(define (match-using-known-values pattern sent known-values)
  ...)

; As match-using-known-values matches the beginning of a pattern with the be- ginning of a sentence, it invokes itself recursively with an expanded known-values containing each newly matched placeholder. For example, in evaluating

(match '(!twice !other !twice) '(cry baby cry))

; the program will call match-using-known-values four times:

;         pattern                      sent                     known-values
; ----------------------------------------------------------------------------------
;  (!twice !other !twice)          (cry baby cry)                   ()
;     (!other !twice)                (baby cry)                 (twice cry !)
;        (!twice)                       (cry)            (twice cry ! other baby !)
;           ()                           ()              (twice cry ! other baby !)

; In the first invocation, we try to match !twice against some part of the sentence. Since ! matches exactly one word, the only possibility is to match the word cry. The recursive invocation, therefore, is made with the first words of the pattern and sentence removed, but with the match between twice and cry added to the database.

; Similarly, the second invocation matches !other with baby and causes a third invocation with shortened pattern and sentence but a longer database.

; The third invocation is a little different because the pattern contains the placeholder !twice, but the name twice is already in the database. Therefore, this placeholder can’t match whatever word happens to be available; it must match the same word that it matched before. (Our program will have to check for this situation.) Luckily, the sentence does indeed contain the word cry at this position.

; The final invocation reaches the base case of the recursion, because the pattern is empty. The value that match-using-known-values returns is the database in this invocation.


; ********************************************************** The Final Version

; We’re now ready to show you the final version of the program. The program structure is much like what you’ve seen before; the main difference is the database of placeholder names and values. The program must add entries to this database and must look for database entries that were added earlier. Here are the three most important procedures and how they are changed from the earlier version to implement this capability:

; • match-using-known-values, essentially the same as what was formerly named match? except for bookkeeping details.
; • match-special, similar to the old version, except that it must recognize the case of a placeholder whose name has already been seen. In this case, the placeholder can match only the same words that it matched before.
; • longest-match and lm-helper, also similar to the old versions, except that they have the additional job of adding to the database the name and value of any placeholder that they match.

; Here are the modified procedures. Compare them to the previous versions.

(define (match pattern sent)
  (match-using-known-values pattern sent '()))                              ; procedure match invokes procedure match-using-known-values, passing the arguments of pattern and sent, and set the known-values as '()

(define (match-using-known-values pattern sent known-values)
  (cond ((empty? pattern)
         (if (empty? sent) known-values 'failed))                           ; when the pattern is empty, if the sent is empty return the known-values; if not, return 'failed'
        ((special? (first pattern))
         (let ((placeholder (first pattern)))                               ; when the first of pattern is a special character, let placeholder equal to (first placeholder)
           (match-special (first placeholder)                               ; and invoke procedure match-special, passing the arguments (first placeholder) as howmany
                          (bf placeholder)                                  ; (bf placeholder) as name
                          (bf pattern)                                      ; (bf pattern) as  pattern-rest
                          sent                                              ; sent as sent
                          known-values)))                                   ; known-values as known-values
        ((empty? sent) 'failed)                                             ; when the pattern is not empty and no placeholders, if the sent is empty return 'failed
        ((equal? (first pattern) (first sent))                              ; match and check the non-special characters one by one
         (match-using-known-values (bf pattern) (bf sent) known-values))
        (else 'failed)))                                                    ; if one pair of the non-special characters are not match with each other return 'failed

(define (match-special howmany name pattern-rest sent known-values)
  (let ((old-value (lookup name known-values)))                             ; let old-value equal to (lookup name known-values)
    (cond ((not (equal? old-value 'no-value))                               ; when old-value is not equal to 'no-value
           (if (length-ok? old-value howmany)                               ; if length-ok? returns true
               (already-known-match
                 old-value pattern-rest sent known-values)                  ; return (already-known-match old-value pattern-rest sent know-values)
               'failed))                                                    ; if length-ok? returns false, return 'failed
          ((equal? howmany '?) (longest-match name pattern-rest sent 0 #t known-values)) ; if howmany is equal to '?, invoke (longest-match name pattern-rest sent 0 #t known-vlaues)
          ((equal? howmany '!) (longest-match name pattern-rest sent 1 #t known-values)) ; if howmany is equal to '!, invoke (longest-match name pattern-rest sent 1 #t known-vlaues)
          ((equal? howmany '*) (longest-match name pattern-rest sent 0 #f known-values)) ; if howmany is equal to '*, invoke (longest-match name pattern-rest sent 0 #f known-vlaues)
          ((equal? howmany '&) (longest-match name pattern-rest sent 1 #f known-values))))) ; if howmany is equal to '&, invoke (longest-match name pattern-rest sent 1 #f known-vlaues)

(define (longest-match name pattern-rest sent min max-one? known-values)
  (cond ((empty? sent)                                                      ; when sent is empty
         (if (= min 0)
             (match-using-known-values pattern-rest                         ; if the minimal size of the placeholder is 0 (* ?)
                                       sent                                 ; invoke (match-using-known-values pattern-rest sent (add name '() known-values))
                                       (add name '() known-values))         ; invokes procedure add to compute an expanded database with the newly found match added
             'failed))                                                      ; if the minimal size of the placeholder is 1 (not 0) return 'failed immediately
        (max-one?
          (lm-helper name pattern-rest (se (first sent))                    ; when the sent is not empty and the maximum size of the placeholder is 1 (! ?) invoke procedure lm-helper with arguments name, pattern-rest, (se (first sent)) as sent-matched, (bf sent) as sent-unmatched, min, known-values
                     (bf sent) min known-values))
        (else (lm-helper name pattern-rest                                  ; when the sent is not empty and the maximum size is unlimited (* &), invoke procedure lm-helper with arguments name, pattern-rest, sent as sent-matched, '() as sent-unmatched, min and known-values
                         sent '() min known-values))))

(define (lm-helper name pattern-rest
                   sent-matched sent-unmatched min known-values)
  (if (< (length sent-matched) min) 'failed                                 ; if the length of the sent-matched less than min return 'failed immediately
      (let ((tentative-result (match-using-known-values                     ; if the length of the sent-matched is not less than min, let tentative-result equal to the results returned by procedure match-using-known-values
                                pattern-rest                                ; with arguments pattern-rest as pattern
                                sent-unmatched                              ; sent-unmatched as sent
                                (add name sent-matched known-values))))     ; (add name sent-matched knwon-values) as known-values
        (cond ((not (equal? tentative-result 'failed)) tentative-result)    ; when the tenative-result is not equal to 'failed, return tenative-result
              ((empty? sent-matched) 'failed)                               ; when the tenative-result is equal to 'failed and the sent-mathced is empty, return 'failed
              (else (lm-helper name                                         ; when the tenative-result is equal to 'failed and the sent-matched is not empty, invloke lm-helper
                               pattern-rest                                 ; with arguments name as name, pattern-rest as pattern-rest
                               (bl sent-matched)                            ; (bl sent-matched) as sent-matched
                               (se (last sent-matched) sent-unmatched)      ; (se (last sent-matched) sent-unmatched) as sent-unmatched
                               min                                          ; min
                               known-values))))))                           ; known-values

; In the invocation of match-special we found it convenient to split the placeholder into its first character, the one that tells how many words can be matched, and the butfirst, which is the name of the placeholder.

; What happens if match-special finds that the name is already in the database? In this situation, we don’t have to try multiple possibilities for the number of words to match (the usual job of longest-match); the placeholder must match exactly the words that it matched before. In this situation, three things must be true in order for the match to succeed: (1) The first words of the sent argument must match the old value stored in the database. (2) The partial pattern that remains after this placeholder must match the rest of the sent. (3) The old value must be consistent with the number of words permitted by the howmany part of the placeholder. For example, if the pattern is

; (*stuff and !stuff)

; and the database says that the placeholder *stuff was matched by three words from the sentence, then the second placeholder !stuff can’t possibly be matched because it accepts only one word. This third condition is actually checked first, by length-ok?, and if we pass that hurdle, the other two conditions are checked by already-known-match.

; The only significant change to longest-match is that it invokes add to compute an expanded database with the newly found match added, and it uses the resulting database as an argument to match-using-known-values.

; ********************************************************** Abstract Data Types

; the program makes reference to the database of known values through two procedure calls:

; (lookup name known-values)                         ; in match-special
; (add name matched known-values)                    ; in longest-match

; Only the procedures lookup and add manipulate the database of known values:

(define (lookup name known-values)                                          ; two arguments for procedure lookup: 1. name (of the place holder) 2. known-values
  (cond ((empty? known-values) 'no-value)                                   ; if the known-values is empty return 'no-value, which means the name is not recorded yet
        ((equal? (first known-values) name)                                 ; if the first of the known-values is equal to name
         (get-value (bf known-values)))                                     ; ; invoke procedure get-value with argument stuff --> (bf known-values)
        (else (lookup name (skip-value known-values)))))                    ; when the known-values is not empty and the first of the known-values is not euqal to name
                                                                            ; ; invoke recursive call lookup with arguments name and known-values --> (skip-value known-values)

(define (get-value stuff)                                                   ; one argument for procedure get-value: stuff
  (if (equal? (first stuff) '!)                                             ; if the (first stuff) is equal to '!
      '()                                                                   ; ; return '()
      (se (first stuff) (get-value (bf stuff)))))                           ; ; or else invoke recursive call and return (se (first stuff) (get-value (bf stuff)))

(define (skip-value stuff)                                                  ; one argument for procedure skip-value: stuff
  (if (equal? (first stuff) '!)                                             ; if the (first stuff) is equal to '!
      (bf stuff)                                                            ; ; return (bf stuff)
      (skip-value (bf stuff))))                                             ; ; or else invoke recursive call (skip-value (bf stuff))

(define (add name value known-values)                                       ; three arguments for procedure add: 1. name (of the place holder), 2. value (of the new) 3. known-values
  (if (empty? name)                                                         ; if the name is empty?
      known-values                                                          ; ; return known-values immediately
      (se known-values name value '!)))                                     ; ; or else return (se known-values name value '!)


; These procedures are full of small details. For example, it’s a little tricky to extract the part of a sentence from a name to the next exclamation point. It’s convenient that we could write the more important procedures, such as longest-match, without filling themwiththesedetails. Asfaraslongest-matchknows,lookupandaddcouldbe Scheme primitive procedures.

; ##########################################################################################################

; In effect we’ve created a new data type, with add as its constructor and lookup as its selector.

; Types such as these, that are invented by a programmer and aren’t part of the Scheme language itself, are called abstract data types.

; Creating an abstract data type means drawing a barrier between an idea about some kind of information we want to model in a program and the particular mechanism that we use to represent the information. In this case, the information is a collection of name-value associations, and the particular mechanism is a sentence with exclamation points and so on. The pattern matcher doesn’t think of the database as a sentence. For example, it would be silly to translate the database into Pig Latin or find its acronym.

; Just as we distinguish the primitive procedures that Scheme knows all along from the compound procedures that the Scheme programmer defines, we could use the names “primitive data type” for types such as numbers and Booleans that are built into Scheme and “compound data type” for ones that the programmer invents by defining selectors and constructors. But “compound data type” is a bit of a pun, because it also suggests a data type built out of smaller pieces, just as a compound expression is built of smaller expressions. Perhaps that’s why the name “abstract data type” has become generally accepted. It’s connected to the idea of abstraction that we introduced earlier, because in order to create an abstract data type, we must specify the selectors and constructors and give names to those patterns of computation.

; ##########################################################################################################


; ********************************************************** Complete Program Listing

(define (match pattern sent)
  (match-using-known-values pattern sent '()))

(define (match-using-known-values pattern sent known-values)
  (cond ((empty? pattern)
         (if (empty? sent) known-values ’failed))
        ((special? (first pattern))
         (let ((placeholder (first pattern)))
           (match-special (first placeholder)
                          (bf placeholder)
                          (bf pattern)
                          sent
                          known-values)))
        ((empty? sent) 'failed)
        ((equal? (first pattern) (first sent))
         (match-using-known-values (bf pattern) (bf sent) known-values))
        (else 'failed)))

(define (special? wd)
  (member? (first wd) '(* & ? !)))

(define (match-special howmany name pattern-rest sent known-values)
  (let ((old-value (lookup name known-values)))
    (cond ((not (equal? old-value 'no-value))
           (if (length-ok? old-value howmany)
               (already-known-match
                 old-value pattern-rest sent known-values)
               'failed))
          ((equal? howmany '?)
           (longest-match name pattern-rest sent 0 #t known-values))
          ((equal? howmany '!)
           (longest-match name pattern-rest sent 1 #t known-values))
          ((equal? howmany '*)
           (longest-match name pattern-rest sent 0 #f known-values))
          ((equal? howmany '&)
           (longest-match name pattern-rest sent 1 #f known-values)))))

(define (length-ok? value howmany)                ; procedure length-ok? has two arguments: 1. value--previously restored placeholder data  2. howmany--current special character
  (cond ((empty? value) (member? howmany '(? *))) ; when value is empty, if howmany is ? or * return true, otherwise, return false
        ((not (empty? (bf value))) (member? howmany '(* &))) ; when (bf value) is not empty, if howmany is * or & return true, otherwise, return false
        (else #t)))  ; when value is not empty and value has only one element, return true immediately

(define (already-known-match value pattern-rest sent known-values) ; 4 arguments: 1. value--previously restored placeholder data 2. pattern-rest 3. sent 4. known-values
  (let ((unmatched (chop-leading-substring value sent))) ; let variable umatched equal to (chop-leading-substring value sent)
    (if (not (equal? unmatched ’failed)) ; if unmatched is not 'failed
        (match-using-known-values pattern-rest unmatched known-values) ; return (match-using-known-values pattern-rest unmatched known-values)
        'failed))) ; otherwise return 'failed

(define (chop-leading-substring value sent) ; preocedure chop-leading-substring had two arguments: 1. value--previously restored placeholder data 2. sent
  (cond ((empty? value) sent)               ; when value is empty, which means the old placeholder matches empty, return sent
        ((empty? sent) 'failed)             ; when value is not empty and sent is empty, which means there is no elements to match, just return 'failed
        ((equal? (first value) (first sent)) ; when (first value) is equal to (first sent)
         (chop-leading-substring (bf value) (bf sent))) ; invoke recursive call chop-leading-substring with (bf value) and (bf sent).
        (else 'failed))) ; otherwise if (first value) and (first sent) not equal with each other, return failed immediately

(define (longest-match name pattern-rest sent min max-one? known-values)
  (cond ((empty? sent)
         (if (= min 0)
             (match-using-known-values pattern-rest
                                       sent
                                       (add name '() known-values))
             'failed))
        (max-one?
          (lm-helper name pattern-rest (se (first sent))
                     (bf sent) min known-values))
        (else (lm-helper name pattern-rest
                         sent '() min known-values))))

(define (lm-helper name pattern-rest
                   sent-matched sent-unmatched min known-values)
  (if (< (length sent-matched) min) 'failed
      (let ((tentative-result (match-using-known-values
                                pattern-rest
                                sent-unmatched
                                (add name sent-matched known-values))))
        (cond ((not (equal? tentative-result ’failed)) tentative-result)
              ((empty? sent-matched) 'failed)
              (else (lm-helper name
                               pattern-rest
                               (bl sent-matched)
                               (se (last sent-matched) sent-unmatched)
                               min
                               known-values))))))

;;; Known values database abstract data type

(define (lookup name known-values)
  (cond ((empty? known-values) 'no-value)
        ((equal? (first known-values) name)
         (get-value (bf known-values)))
        (else (lookup name (skip-value known-values)))))

(define (get-value stuff)
  (if (equal? (first stuff) '!)
      '()
      (se (first stuff) (get-value (bf stuff)))))

(define (skip-value stuff)
  (if (equal? (first stuff) '!)
      (bf stuff)
      (skip-value (bf stuff))))

(define (add name value known-values)
  (if (empty? name)
      known-values
      (se known-values name value '!)))

