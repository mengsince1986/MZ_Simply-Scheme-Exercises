; Exercises 3.1-3.9


; 3.1 Translate the arithmetic expressions (3+4)×5 and 3+(4×5) into Scheme expressions, and into plumbing diagrams.

; Solution:
(* (+ 3 4) 5)
(+ 3 (* 4 5))

; *********************************************************

;3.2 How many little people does Alonzo hire in evaluating each of the following expressions:

(+ 3 (* 4 5) (- 10 4)) ; three people and 4 subexpressions

(+ (* (- (/ 8 2) 1) 5) 2) ; four people and 3 subexpressions

(* (+ (- 3 (/ 4 2))
      (sin (* 3 2))
      (- 8 (sqrt 5)))
   (- (/ 2 3)
      4)) ; ten people and 3 subexpressions

; *********************************************************

; 3.3 Each of the expressions in the previous exercise is compound. How many subex- pressions (not including subexpressions of subexpressions) does each one have?

; For example,
(* (- 1 (+ 3 4)) 8)
; has three subexpressions; you wouldn’t count (+ 3 4).

; *********************************************************

; 3.4 Five little people are hired in evaluating the following expression:

(+ (* 3 (- 4 7))
   (- 8 (- 3 5)))

; Give each little person a name and list her specialty, the argument values she receives, her return value, and the name of the little person to whom she tells her result.

; answer:
; little a: minus, 4 and 7, return -3, to little b
; little c: minus, 3 and 5, return -2, to little d

; little b: multiply, 3 and -3, return -9, to little e
; little d: minus, 8 and -2, return 10, to little e

; little e: plus, -9 and 10, return 1

; *********************************************************

; 3.5 Evaluate each of the following expressions using the result replacement technique:

(sqrt (+ 6 (* 5 2)))
(sqrt (+6 10))
(sqrt 16)
4

(+ (+ (+ 1 2) 3) 4)
(+ (+ 3 3) 4)
(+ 6 4)
10

; *********************************************************

; 3.6 Draw a plumbing diagram for each of the following expressions:

(+ 3 4 5 6 7)
(+ (+ 3 4) (+ 5 6 7))
(+ (+ 3 (+ 4 5) 6) 7)

; *********************************************************

; 3.7 What value is returned by (/ 1 3) in your version of Scheme?
; (Some Schemes return a decimal fraction like 0.33333, while others have exact fractional values like 1/3 built in.)

; answer: 1/3

; *********************************************************

; 3.8 Which of the functions that you explored in Chapter 2 will accept variable numbers of arguments?

; answer:
#|
+
-
max
first
last
sentence
word
|#

; *********************************************************

#| 3.9 The expression (+ 8 2) has the value 10. It is a compound expression made up of three atoms. For this problem, write five other Scheme expressions whose values are also the number ten:

• An atom
• Another compound expression made up of three atoms
• A compound expression made up of four atoms
• A compound expression made up of an atom and two compound subexpressions
• Any other kind of expression |#

; answer:
10
(- 15 5)
(+ 1 4 5)
(* (+ 0.5 1.5) (/ 10 2))
(/ 100 (/ 100 10))
