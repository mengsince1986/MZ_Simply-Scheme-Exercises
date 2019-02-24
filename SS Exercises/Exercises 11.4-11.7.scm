; Exercises 11.4-11.7

; Use recursion to solve these problems, not higher order functions (Chapter 8)!


; 11.4 Who first said “use what you have to get what you need”?

; answer: I read this quote first from Simply Scheme.

; **********************************************************

; 11.5 Write a procedure initials that takes a sentence as its argument and returns a sentence of the first letters in each of the sentence’s words:

;(initials ’(if i needed someone))
;(I I N S)

; answer:
(define (initials sent)
  (if (empty? sent)
      '()
      (sentence (first (first sent))
                (initials (butfirst sent)))))

; **********************************************************

; 11.6 Write a procedure countdown that works like this:

;(countdown 10)
;(10 9 8 7 6 5 4 3 2 1 BLASTOFF!)

;(countdown 3)
;(3 2 1 BLASTOFF!)

; answer:
(define (countdown num)
  (if (= num 1)
      '(1 blastoff!)
      (sentence num (countdown (- num 1)))))

; **********************************************************

; 11.7 Write a procedure copies that takes a number and a word as arguments and returns a sentence containing that many copies of the given word:

;(copies 8 ’spam)
;(SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM)

; answer:
(define (copies num wd)
  (if (= 0 num)
      '()
      (sentence wd (copies (- num 1) wd))))
