; Exercies 8.1-8.3

; 8.1 What does Scheme return as the value of each of the following expressions? Figure it out for yourself before you try it on the computer.

; answer:
(every last '(algebra purple spaghetti tomato gnu)); '(a e i o u)
(keep number? '(one two three four)); '()
(accumulate * '(6 7 13 0 9 42 17)); 0
(member? 'h (keep vowel? '(t h r o a t))); #f
(every square (keep even? '(87 4 7 12 0 5))); '(16 144 0)
(accumulate word (keep vowel? (every first '(and i love her)))); 'ai
((repeated square 0) 25); 25
(every (repeated bl 2) '(good day sunshine)); '(go d sunshi)

; **********************************************************

; 8.2 Fill in the blanks in the following Scheme interactions:

; (_________ vowel? ’birthday) ;'IA
; (_________ first '(golden slumbers)) ;(G S)
; (_________ '(golden slumbers)) ;'GOLDEN
; (_________ ________ '(little child)) ;(E D)
; (_________ ________ (_______ ______ '(little child))) ;'ED
; (_________ + '(2 3 4 5)) ;(2 3 4 5)
; (_________ + '(2 3 4 5)) ;14

;answer:
(keep vowels? 'birthday)
(every first '(golden slumbers))
(first '(golden slumbers))
(every last '(little child))
(accumulate word (every last '(little child)))
(every + '(2 3 4 5))
(accumulate + '(2 3 4 5))

; **********************************************************

; 8.3 Describe each of the following functions in English. Make sure to include a description of the domain and range of each function. Be as precise as possible; for example, “the argument must be a function of one numeric argument” is better than “the argument must be a function.”

; answer:
(define (f a)
  (keep even? a))
; function f accpets one argument and returns even numbers in the argument. the argument must be one or multiple integers and the returned value  is one or multiple even integers.

(define (g b)
  (every b ’(blue jay way)))
; function g accepts one argument b and apply b on each word of '(blue jay way). the argument b must be a function of one-word/sentence argument. the returned value is a sentence.

(define (h c d)
  (c (c d)))
; function h accpets two arguments c and d and apply c to the result of (c d). the arguments c must be a function and d must be a value that is in the domain of function c.

(define (i e)
  (/ (accumulate + e) (count e)))
; function i accepts one argument e and return the average value of e. the arguments e must be an array of numbers. the returned value is the average value of argument e.

accumulate
; `accumulate` accepts two arguments and apply the the first argument to the second argument. the first argument must be a function of two arguments. the returned value is a combined value from the second argument applied by first argument.

sqrt
; `sqrt` accepts one argument and returns its square root. the argument must be a number.

repeated
; `repeated` accepts two argumentis and returns a new function. the first argument must be a procedure while the second argument must be an integer equal to or more than 0.

(repeated sqrt 3)
; 'repeated' accepts function `sqrt` as its first argument and number 3 as its second argument and returns a new function. the new function accepts one numeric argument and returns the square root of the square root of the square root of its argument.

(repeated even? 2)
; 'repeated' accepts function `even?` as its first argument and number 2 as its second argument and returns a new function. the new function accepts one numeric argument and returns an error message because the function applys `even?` to the reuslt of (even? 2) which is a boolean instead of an integer.

(repeated first 2)
; 'repeated' accepts function `first` as its first argument and number 2 as its second argument and returns a new function. the new function accepts an argument which must be a word or sentence and returns the first element of the first element of its argument.

(repeated (repeated bf 3) 2)
  ; `repeated` accepts the returned value of (repeated bf 3) as its first argument and number 2 as its second argument and returns a new function. (repeated bf 3) takes a word or sentence as its argument and returns a function that returns a word or sentence with its first three elements excluded. In turn, the new function accepts a word or sentence as its argument and returns a word or sentence with its first six elements excluded.



