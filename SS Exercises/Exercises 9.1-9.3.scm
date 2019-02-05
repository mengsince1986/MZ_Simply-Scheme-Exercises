; Exercises 9.1-9.3

; 9.1 What will Scheme print? Figure it out yourself before you try it on the computer.

; answer:
(lambda (x) (+ (* x 3) 4)); a procedure that takes a numeric argument and returns a value by multiplying the argument by 3 and adding it to 4

((lambda (x) (+ (* x 3) 4)) 10); 34

(every (lambda (wd) (word (last wd) (bl wd)))
       '(any time at all))
; '(yan etim ta lal)

((lambda (x) (+ x 3)) 10 15); bad argument count - received 2 but expected 1: #<procedure (? x)

; **********************************************************

; 9.2 Rewrite the following definitions so as to make the implicit lambda explicit.
(define (second stuff)
  (first (bf stuff)))

(define (make-adder num)
  (lambda (x) (+ num x)))

; answer:
(define second (lambda (stuff)
                 (first (bf stuff))))

(define make-adder (lambda (num)
                     (lambda (x) (+ num x))))

; **********************************************************

; 9.3 What does this procedure do?
(define (let-it-be sent)
  (accumulate (lambda (x y) y) sent))

; answer: procedure `let-it-be` takes a sentence as its argument and return the last word of the argument.



