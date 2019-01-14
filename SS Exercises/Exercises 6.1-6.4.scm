; Exercises 6.1-6.4

; 6.1 What values are printed when you type these expressions to Scheme? (Figure it out in your head before you try it on the computer.)

(cond ((= 3 4) '(this boy))
      ((< 2 5) '(nowhere man))
      (else '(two of us)))
; '(nowhere man)

(cond (empty? 3)
      (square 7)
      (else 9))
; 3

(define (third-person-singular verb)
  (cond ((equal? verb 'be) 'is)
        ((equal? (last verb) 'o) (word verb 'es))
        (else (word verb 's))))

(third-person-singular 'go)
; goes

; **********************************************************

; 6.2 What values are printed when you type these expressions to Scheme? (Figure it out in your head before you try it on the computer.)

(or #f #f #f #t) ; #t

(and #f #f #f #t) ; #f

(or (= 2 3) (= 4 3)) ; #f

(not #f); #t

(or (not (= 2 3)) (= 4 3)) ; #t

(or (and (= 2 3) (= 3 3)) (and (< 2 3) (< 3 4))) ; #t

; **********************************************************

; 6.3 Rewrite the following procedure using a cond instead of the ifs:

(define (sign number)
  (if (< number 0)
      ’negative
      (if (= number 0)
          ’zero
          ’positive)))

; answer:
(define (sign number)
  (cond ((< number 0) 'negative)
        ((= number 0) 'zero)
        (else 'positive)))

; **********************************************************

; 6.4 Rewrite the following procedure using an if instead of the cond:

(define (utensil meal)
  (cond ((equal? meal ’chinese) ’chopsticks)
        (else ’fork)))

; answer:
(define (utensil meal)
  (if (equal? meal 'chinese)
      'chopsticks
      'fork))

