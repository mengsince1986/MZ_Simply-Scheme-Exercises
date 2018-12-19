; Exercises 4.4-4.10

; 4.4 Each of the following procedure definitions has an error of some kind. Say what’s wrong and why, and fix it:

; answer:
(define (sphere-volume r)
  (* (/ 4 3) 3.141592654)
  (* r r r))
; error: a function can have only one return value. the body of the procedure has two expressions instead of one. the procedure only retues the value of (* r r r).
; debug:
(define (sphere-volume r)
  (* (/ 4 3)
     3.141592654
     (* r r r)))

; ---------------------------

(define (next x)
  (x + 1))
; error: (x + 1) is not a legal body, because lisp uses prefix notation.
; debug:
(define (next x)
  (+ x 1))

; ---------------------------

(define (square)
  (* x x))
; error: the formal parameter is not defined
; debug:
(define (square x)
  (* x x))

; ---------------------------

(define (triangle-area triangle)
  (* 0.5 base height))
; error: base and height are not defined parameters
; debug:
(define (triangle-area base height)
  (* 0.5 base height))

; ---------------------------

(define (sum-of-squares (square x) (square y))
  (+ (square x) (square y)))
; error: Formal parameters in the procedure are not defined by words.
; debug:
(define (sum-of-squares x y)
  (+ (square x) (square y)))

; **********************************************************

; 4.5 Write a procedure to convert a temperature from Fahrenheit to Celsius, and another to convert in the other direction. The two formulas are F = 9/5C + 32 and C = 5/9(F − 32).

; answer:
; F-->C
(define (F2C f)
  (* (/ 5 9)
     (- f 32)))
; C-->F
(define (C2F c)
  (+ (* (/ 9 5) c)
     32))

; **********************************************************

; 4.6 Define a procedure fourth that computes the fourth power of its argument. Do this two ways, first using the multiplication function, and then using square and not (directly) using multiplication.

; answer:
; Solution 1:
(define (fourth x)
  (* x x x x))
; Solution 2:
(define (fourth x)
  (square (square x)))

(define (square x)
  (* x x))

; **********************************************************

; 4.7 Write a procedure that computes the absolute value of its argument by finding the square root of the square of the argument.

; answer:
(define (abs x)
  (sqrt (* x x)))

; **********************************************************

; 4.8 “Scientific notation” is a way to represent very small or very large numbers by combining a medium-sized number with a power of 10. For example, 5 × 10⁷ represents the number 50000000, while 3.26 × 10-9 represents 0.00000000326 in scientific notation. Write a procedure scientific that takes two arguments, a number and an exponent of 10, and returns the corresponding value:

(scientific 7 3)
; 7000

(scientific 42 -5) 0.00042

; Some versions of Scheme represent fractions in a/b form, and some use scientific notation, so you might see 21/50000 or 4.2E-4 as the result of the last example instead of 0.00042, but these are the same value.

; (A harder problem for hotshots: Can you write procedures that go in the other direction? So you’d have

(sci-coefficient 7000)
;7

(sci-exponent 7000)
;3

; You might find the primitive procedures log and floor helpful.)

; answer:
(define (scientific n power)
  (* n
     (expt 10 power)))

(define (sci-coefficient n)
  (/ n
     (expt 10 (sci-exponent n))))

(define (sci-exponent n)
  (floor (log n 10)))

; **********************************************************

; 4.9 Define a procedure discount that takes two arguments: an item’s initial price and a percentage discount. It should return the new price:

(discount 10 5); 9.50
(discount 29.90 50); 14.95

; answer:
(define (discount iniPrice discount)
  (* iniPrice
     (- 1 (/ discount 100))))

; **********************************************************

; 4.10 Write a procedure to compute the tip you should leave at a restaurant. It should take the total bill as its argument and return the amount of the tip. It should tip by 15%, but it should know to round up so that the total amount of money you leave (tip plus original bill) is a whole number of dollars. (Use the ceiling procedure to round up.)

(tip 19.98); 3.02
(tip 29.23); 4.77
(tip 7.54); 1.46

;answer:
(define (tip subtotal)
  (- (ceiling (+ subtotal
                 (* 0.15 subtotal)))
     subtotal))
