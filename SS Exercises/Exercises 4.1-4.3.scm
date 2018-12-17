; Exercises 4.1-4.3

; 4.1 Consider this procedure:
(define (ho-hum x y)
  (+ x (* 2 y)))
; Show the substitution that occurs when you evaluate
(ho-hum 8 12)

; answer:
(ho-hum 8 12)
(+ 8 (* 2 12))

; *********************************************************

; 4.2 Given the following procedure:
(define (yawn x)
  (+ 3 (* x 2)))
; list all the little people that are involved in evaluating
(yawn (/ 8 2))
; (Give their names, their specialties, their arguments, who hires them, and what they do with their answers.)

; answer:
(yawn (/ 8 2))
(yawn 4)
(+ 3 (* 4 2))
; Little person a: division, 8 and 2, hired by little person yawn, handing the answers to little person yawn
; Little Person b: plus, 3 and (* 4 2), hired by little person yawn, handing the answer to little person yawn
; Little Person c: multiplication, 4 and 2, hired by little person b, handing the answer to little b

; *********************************************************


; 4.3 Here are some procedure definitions. For each one, describe the function in English, show a sample invocation, and show the result of that invocation.
(define (f x y) (- y x))

(define (identity x) x)

(define (three x) 3)

(define (seven) 7)

(define (magic n)
  (- (/ (+ (+ (* 3 n)
              13)
           (- n 1))
        4)
     3))

; answer:
(define (f x y) (- y x))
; function f accepts two numbers as its arguments and returns the value by substructing its arguments x from y
(f 2 3); 1

(define (identity x) x)
; function identity accepts any types of data as its argument and returns the value of argument x
(identity 5); 5

(define (three x) 3)
; function three accepts any types of data as its argument and returns 3 no matter what value argument x is

(define (three x) 7)
; function three accepts any types of data as its argument and returns 7 no matter what value argument x is

(define (magic n)
  (- (/ (+ (+ (* 3 n)
              13)
           (- n 1))
        4)
     3))
; function magic accepts a number as its argument and returns the value of its argument

