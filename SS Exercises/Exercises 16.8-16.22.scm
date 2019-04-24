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

(match '(form me to you) '(from me to you))
(match '(*x *y *x) '(a b c a b))
(match '(*x *y *z) '(a b c a b))
(match '(*x hey *y bulldog *z) '(a hey b bulldog c))
(match '(*x a b c d e f) '(a b c d e f))
(match '(a b c d e f *x) '(a b c d e f))

; In general, what can you say about the characteristics that make a pattern easy or hard to match?

; answer:
(match '(form me to you) '(from me to you)) ; 4 little people are required
(match '(*x *y *x) '(a b c a b)) ; (x a b ! y c !) 3 little people are required
(match '(*x *y *z) '(a b c a b)) ; (x )
(match '(*x hey *y bulldog *z) '(a hey b bulldog c))
(match '(*x a b c d e f) '(a b c d e f))
(match '(a b c d e f *x) '(a b c d e f))



