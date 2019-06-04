; Exercise 19.1

; 19.1 What happens if you say the following?

(every cdr '((john lennon) (paul mccartney)
             (george harrison) (ringo starr)))

; How is this different from using `map`, and why? How about `cadr` instead of `cdr` ?

; answer:
; the result of above program is:
'(lennon maccartney harrison starr)

; while using `map` keeps the original structure of the lists and returns:
'((lennon) (mccartney) (harrison) (starr))

; because `map` uses `cons` to combine the elements of the results, whereas `every` uses `sentence'.

(every cadr '((john lennon) (paul mccartney)
             (george harrison) (ringo starr)))

; and

(map cadr '((john lennon) (paul mccartney)
             (george harrison) (ringo starr)))

; return the same result:

'(lennon maccartney harrison starr)

; because in `map`:
(cadr '(ringo starr))
; 'starr

(cons 'starr ())
; '(starr)
