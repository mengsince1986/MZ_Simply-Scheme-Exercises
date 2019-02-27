; Exercises 12.1-12.4

; 12.1 Here is a definition of a procedure that returns the sum of the numbers in its argument sentence:

(define (addup nums)
  (if (empty? (bf nums))
      (first nums)
      (+ (first nums) (addup (bf nums)))))

; Although this works, it could be simplified by changing the base case. Do that.

; answer:
(define (addup nums)
  (if (empty? nums)
      0
      (+ (first nums) (addup (bf nums)))))

; **********************************************************

; 12.2 Fix the bug in the following definition:

(define (acronym sent)                   ;wrong
  (if (= (count sent) 1)
      (first sent)
      (word (first (first sent))
            (acronym (bf sent)))))

; answer:
(define (acronym sent)
  (if (empty? sent)
      ""
      (word (first (first sent))
            (acronym (bf sent)))))

; **********************************************************

; 12.3 Can we reduce the factorial base case argument from 0 to -1? If so, show the resulting procedure. If not, why not?

; answer:
; It's impossibe to reduce the factorial base case argument from 0 to -1. Even if we define (factorial (-1)) to return 1, trying to use recursive procedure to solve (factorial 0) casuses all the results to be 0, as following:
(* 0 (factorial (- 0 1)))

; **********************************************************

; 12.4 Here’s the definition of a function f :

; f(sent) = sent, if sent is empty
; f(sent) = sentence(f(butfirst(sent)), first(sent)), otherwise

; Implement f as a Scheme procedure. What does f do?

; answer:
(define (f sent)
  (if (empty? sent)
      '()
      (sentence (f (butfirst sent))
                (first sent))))

; f takes a sentence as its argument, reverses the order of the words in the sentence and returns the reversed sentence.
