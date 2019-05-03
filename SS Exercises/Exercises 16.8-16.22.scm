; Exercises 16.8-16.22

; 16.8 Explain how longest-match handles an empty sentence.

; Explanation:
; In the procedure of longest-match, when sentence (sent) is empty,
; if the minimum requirement for the current place holder is 0, invoke the procedure match-using-known-values to check if the rest of the pattern can be met with an empty sentence and record the current placeholder and its value (empty) in the known values.
; if the minimum requirement for the current place holder is 1 (not 0), return failed immediately since it's impossible for an empty sentence to match a placeholder which requires at least one word.

; **********************************************************

; 16.9 Suppose the first cond clause in match-using-known-values were

((empty? pattern) known-values)

; Give an example of a pattern and sentence for which the modified program would give a different result from the original.

; solution:
; ------------------------------------------------------------
(define (match-using-known-values pattern sent known-values)
  (cond ((empty? pattern) ; when pattern is empty,
         (if (empty? sent) known-values 'failed)) ; if sent is empty, return know-values '(); if not, return failed
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
; ------------------------------------------------------------

; if the first cond clause is changed into
((empty? pattern) known-values)
; when the sent is empty, the modified match-using-known-values returns the same result '() as the original
; when the sent is not empty, the modified match-using-known-values returns the the known-values '() while the original returns 'failed

; for example, the function
(match-using-known-values '() '(not-empty sentence) '())
; returns '() in the modified procedure
; while in the original it returns 'failed.

; **********************************************************

; 16.10 What happens if the sentence argument—not the pattern—contains the word * somewhere?

; answer: the match procedure only checks the special characters (* & ? !) in the pattern argument with special? procedure, so a word * contained in the sentence argumenat is seen as a normal word.

; **********************************************************

; 16.11 For each of the following examples, how many match-using-known-values little people are required?

(match '(from me to you) '(from me to you))
; 5 little people are required.

(match '(*x *y *x) '(a b c a b))
; 15 little people are required.

(match '(*x *y *z) '(a b c a b))
; 4 little people are required.

(match '(*x hey *y bulldog *z) '(a hey b bulldog c))
; 12 little people are required.

(match '(*x a b c d e f) '(a b c d e f))
; 14 little people are required.

(match '(a b c d e f *x) '(a b c d e f))
; 8 little people are required.

; In general, what can you say about the characteristics that make a pattern easy or hard to match?

; According to the examples above, the following characteristics make a pattern hard to match:
; 1. a pattern contains both placeholders and specific words;
; 2. a pattern contains two or more identical placeholders;
; 3. a pattern contains placeholders at the beginning.

; **********************************************************

; 16.12 Show a pattern with the following two properties: (1) It has at least two placeholders. (2) When you match it against any sentence, every invocation of lookup returns no-value .

; solution:
'(*pl-h-1 *pl-h-2 *pl-h-3)
'(* ? &)

; **********************************************************

; 16.13 Show a pattern and a sentence that can be used as arguments to match so that lookup returns (the beatles) at some point during the match.

; solution:
'(*a *b *a *b) '(the beatles the beatles)

; **********************************************************

; 16.14 Our program can still match patterns with unnamed placeholders. How would it affect the operation of the program if these unnamed placeholders were added to the database? What part of the program keeps them from being added?

; answer:
; If the unnamed placehodlers are added to the database, when the operation comes to match-special, the lookup procedure may not performe correctly. For example, the lookup procedure will compare the name of a named placeholder with the first symbol in the value of an unnamed placehoder.

; The add function keeps the unnamed placeholders from being added to the database. If the name is empty (unnamed placeholders), the add function returns the known-values directly.

; **********************************************************

; 16.15 Why don’t get-value and skip-value check for an empty argument as the base case?

; answer:
; For get-value, the purpose is get the value of the current placeoholder, rather than go through the whole argument. The first occurence of '! indicates the end of the current value, so get-value checks for '! as it's base case condition.

; Likely, the purpose of skip-value is cut off the first placeholder with its value in the stuff. The first occurence of '! indicates the end of the current value, so skip-value checks for '! as it's base case condition.

; **********************************************************

; 16.16 Why didn’t we write the first cond clause in length-ok? as the following?

((and (empty? value) (member? howmany '(? *))) #t)

; answer:
; In the original length-ok?, when value is empty the reuslt is the same with
(member? howmany '(? *))
; which can be #t or #f.
; But
((and (empty? value) (member? howmany '(? *))) #t)
; can only return #t. It doesn't consider the situation when value is empty and howmany is not '? or '* (result is supposed to be #f) and will throw the situation to else which returns #t.

; **********************************************************

; 16.17 Where in the program is the initial empty database of known values established?

; answer:
; The initial empty database of known values is established in the procedure of match. match invokes match-using-known-values, pass its arguments pattern and sent, and create an empty sentence '() as known-values for match-using-known-values.

; **********************************************************

; 16.18 For the case of matching a placeholder name that’s already been matched in this pattern, we said on page 268 that three conditions must be checked. For each of the three, give a pattern and sentence that the program would incorrectly match if the condition were not checked.

; solution:

; without length-ok? to check if the length of old-value matches the current howmany, the following pattern and sentence will incorrectly match:
(match '(*plholder !plholder) '(a b a b))

; without already-known-match to invoke match-using-known-values to check if the rest pattern and rest sent match, the following pattern and sentence will incorrectly match:
(match '(*plholder !plholder) '(a a b))

; without chop-leading-substring to check if first words of the sent argument match the old value stored in the datebase, the following pattern and sentence will incorrectly match:
(match '(*plholder &plholder) '(a b c d))

; **********************************************************

; 16.19 What will the following example do?

(match '(?x is *y !x) '(! is an exclamation point !))

; Can you suggest a way to fix this problem?

; Analysis:
; The match example above will return 'failed instead of '(x ! ! y an exclamation point).

; The glitch happens when the procedure comes to
(match-special '! 'x '() '(!) '(x ! ! y an exclamation point !))

; when the procedure tries to operate
(let ((old-value (lookup x '(x ! ! y an exclamation point !)))))
; the old-value gets '() instead of '! (where the error happens).

; The error is due to look-up's sub-procedure get-value.
; When look-up compares (first known-values) ('x in this case) with the current name 'x, it returns
(get-value (bf known-values))
; which in this case is
(get-value (bf '(x ! ! y an exclamation point !)))
; get-value returns the first placeholder's value in its argument stuff with a recursive call and has
(equal? (first stuff) '!)
; as its base case, which stops accumulation the value sentence when it comes to '! -- the divider in the database-- and this is the root cause of the error. The base case works well in most cases except it encounters '! as a placeholder's value. In this situation, get-value will ignore '! and other values after it.

; Solution:

; To avoid '! as a placeholder's value from contaminating the procedure, the '! divider in the database structure can be changed into a series of complicated characters made up with special symbols, for example,

'!---!

;;; Updated known values database abstract data type

(define (lookup name known-values)
  (cond ((empty? known-values) 'no-value)
        ((equal? (first known-values) name)
         (get-value (bf known-values)))
        (else (lookup name (skip-value known-values)))))

(define (get-value stuff)
  (if (equal? (first stuff) '!---!)
      '()
      (se (first stuff) (get-value (bf stuff)))))

(define (skip-value stuff)
  (if (equal? (first stuff) '!---!)
      (bf stuff)
      (skip-value (bf stuff))))

(define (add name value known-values)
  (if (empty? name)
      known-values
     (se known-values name value '!---!)))

; although it can't 100% prevent procedure match from being contaminated by the placeholder's matching value, since it can always cause similar errors by making didver part of the placeholder's value.


; **********************************************************

; 16.20 Modify the pattern matcher so that a placeholder of the form *15x is like *x except that it can be matched only by exactly 15 words.

(match '(*3front *back) '(your mother should know))
; (FRONT YOUR MOTHER SHOULD ! BACK KNOW !)

; Solution:

; modified matcher with strict *+num+placeholder

; ********************************************************************************************** accept patten and sentence

(define (match pattern sent)
  (match-using-known-values pattern sent '()))

; ********************************************************************************************** general matching

; <-----> match-using-known-values
; <-----> accept pattern, sentence and known-values as arguments

; <-----> list five general categorises for matching:
; <-----> 1. pattern is empty
; <-----> 2. first pattern is strict special *
; <-----> 2. first pattern is special placeholder (* & ? !)
; <-----> 3. sentence is empty
; <-----> 4. one by one non-special word matching
; <-----> 5. else

; <-----> invoke:
; <-----> strict? (if pattern is not empty)
; <-----> match-strict (if first pattern is strict)
; <-----> special? (if first pattern is not strict)
; <-----> match-special (if first pattern is special)
; <-----> match-using-known-values (if check non-special word)

(define (match-using-known-values pattern sent known-values)
  (cond ((empty? pattern)
         (if (empty? sent) known-values 'failed))
        ((strict? (first pattern))
         (let ((placeholder (bf (first pattern))))
           (match-strict (get-num placeholder)
                         (but-num placeholder)
                         (bf pattern)
                         sent
                         known-values)))
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

; <-----> strict?
(define (strict? wd)
  (and (> (count wd) 2)
       (equal? '* (first wd))
       (number? (first (bf wd)))))

; <-----> get-num
(define (get-num wd)
  (cond ((empty? wd) "")
        ((number? (first wd))
         (word (first wd) (get-num (bf wd))))
        (else (get-num (bf wd)))))

; <-----> but-num
(define (but-num wd)
  (cond ((empty? wd) "")
        ((not (number? (first wd)))
         (word (first wd) (but-num (bf wd))))
        (else (but-num (bf wd)))))

; <-----> special?
; <-----> accept wd as argument
(define (special? wd)
  (member? (first wd) '(* & ? !)))

; ********************************************************************************************** strict pattern matching

; <-----> match-strict

(define (match-strict strict-howmany name pattern-rest sent known-values)
 (let ((old-value (lookup name known-values)))
   (if (not (equal? old-value 'no-value))
       (if (= (count old-value) strict-howmany)
           (already-known-match
             old-value pattern-rest sent known-values)
           'failed)
       (ms-helper strict-howmany name pattern-rest '() sent known-values))))

; <-----> ms-helper
(define (ms-helper strict-howmany name pattern-rest sent-matched sent known-values)
  (cond ((= strict-howmany 0) (match-using-known-values pattern-rest
                                                        sent
                                                        (add name sent-matched known-values)))
        ((empty? sent) 'failed)
        (else (ms-helper (- strict-howmany 1)
                         name
                         pattern-rest
                         (se sent-matched (first sent))
                         (bf sent)
                         known-values))))

; ********************************************************************************************** special pattern matching

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


; <-----> length-ok?

(define (length-ok? value howmany)
  (cond ((empty? value) (member? howmany '(? *)))
        ((not (empty? (bf value))) (member? howmany '(* &)))
        (else #t)))

; <-----> already-known-match

(define (already-known-match value pattern-rest sent known-values)
  (let ((unmatched (chop-leading-substring value sent)))
    (if (not (equal? unmatched 'failed))
        (match-using-known-values pattern-rest unmatched known-values)
        'failed)))

; <-----> chop-leading-substring

(define (chop-leading-substring value sent)
  (cond ((empty? value) sent)
        ((empty? sent) 'failed)
        ((equal? (first value) (first sent))
         (chop-leading-substring (bf value) (bf sent)))
        (else 'failed)))

; <-----> longest-match

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

; <-----> lm-helper

(define (lm-helper name pattern-rest
                   sent-matched sent-unmatched min known-values)
  (if (< (length sent-matched) min)
      'failed
      (let ((tentative-result (match-using-known-values
                                pattern-rest
                                sent-unmatched
                                (add name sent-matched known-values))))
        (cond ((not (equal? tentative-result 'failed)) tentative-result)
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
  (if (equal? (first stuff) '!---!)
      '()
      (se (first stuff) (get-value (bf stuff)))))

(define (skip-value stuff)
  (if (equal? (first stuff) '!---!)
      (bf stuff)
      (skip-value (bf stuff))))

(define (add name value known-values)
  (if (empty? name)
      known-values
     (se known-values name value '!---!)))


; **********************************************************

; 16.21 Modify the pattern matcher so that a + placeholder (with or without a name attached) matches only a number:

(match '(*front +middle *back) '(four score and 7 years ago))
; (FRONT FOUR SCORE AND ! MIDDLE 7 ! BACK YEARS AGO !)

; The + placeholder is otherwise like ! —it must match exactly one word.


; **********************************************************

; 16.22 Does your favorite text editor or word processor have a search command that allows you to search for patterns rather than only specific strings of characters? Look into this and compare your editor’s capabilities with that of our pattern matcher.
