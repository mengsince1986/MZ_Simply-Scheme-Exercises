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

; for example,
; the function
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


; **********************************************************

; 16.20 Modify the pattern matcher so that a placeholder of the form *15x is like *x except that it can be matched only by exactly 15 words.

(match '(*3front *back) '(your mother should know))
; (FRONT YOUR MOTHER SHOULD ! BACK KNOW !)


; **********************************************************

; 16.21 Modify the pattern matcher so that a + placeholder (with or without a name attached) matches only a number:

(match '(*front +middle *back) '(four score and 7 years ago))
; (FRONT FOUR SCORE AND ! MIDDLE 7 ! BACK YEARS AGO !)

; The + placeholder is otherwise like ! —it must match exactly one word.


; **********************************************************

; 16.22 Does your favorite text editor or word processor have a search command that allows you to search for patterns rather than only specific strings of characters? Look into this and compare your editor’s capabilities with that of our pattern matcher.
