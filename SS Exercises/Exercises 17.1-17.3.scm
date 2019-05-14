; Exercises 17.1-17.3

; 17.1 What will Scheme print in response to each of the following expressions? Try to figure it out in your head before you try it on the computer.

; answer:

(car '(Rod Chris Colin Hugh Paul))
; 'Rod

(cadr '(Rod Chris Colin Hugh Paul))
; 'Chris

(cdr '(Rod Chris Colin Hugh Paul))
; '(Chris Colin Hugh Paul)

(car 'Rod)
; error--the argument is supposed to be a list

(cons '(Rod Argent) '(Chris White))
; '((Rod Argent) Chris White)

(append '(Rod Argent) '(Chris White))
; '(Rod Argent Chris White)

(list '(Rod Argent) '(Chris White))
; '((Rod Argent) (Chris White))

(caadr '((Rod Argent) (Chris White)
         (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
; 'Chris

(assoc 'Colin '((Rod Argent) (Chris White)
                (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
; '(Colin Blunstone)

(assoc 'Argent '((Rod Argent) (Chris White)
                 (Colin Blunstone) (Hugh Grundy) (Paul Atkinson)))
; #f

; **********************************************************

; 17.2 For each of the following examples, write a procedure of two arguments that, when applied to the sample arguments, returns the sample result. Your procedures may not include any quoted data.

(f1 '(a b c) '(d e f))
; ((B C D))

(f2 '(a b c) '(d e f))
; ((B C) E)

(f3 '(a b c) '(d e f))
; (A B C A B C)

(f4 '(a b c) '(d e f))
; ((A D) (B C E F))

; solution:

(define (f1 lst-1 lst-2)
  (list (append (cdr lst-1)
                (list (car lst-2)))))
; ---

(define (f2 lst-1 lst-2)
  (cons (cdr lst-1)
        (list (cadr lst-2))))
; ---

(define (f3 lst-1 lst-2)
  (append lst-1 lst-1))
; ---

(define (f4 lst-1 lst-2)
  (list (list (car lst-1) (car lst-2))
        (append (cdr lst-1) (cdr lst-2))))

; **********************************************************

; 17.3 Describe the value returned by this invocation of map :

(map (lambda (x) (lambda (y) (+ x y))) '(1 2 3 4))

; answer:
; The invocation of `map` above returns a list of anonymous functions
; in each of which it returns the sum of argument y and a value from (1 2 3 4)
; such as
(lambda (y) (+ 1 y))
(lambda (y) (+ 2 y))
(lambda (y) (+ 3 y))
(lambda (y) (+ 4 y))
