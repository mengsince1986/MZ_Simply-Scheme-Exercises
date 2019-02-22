; Exercises 11.1-11.3

; 11.1 Write downup4 using only the word and sentence primitive procedures.
; answer:
(define (downup4 wd)
  (sentence wd
            (butlast wd)
            (butlast (butlast wd))
            (first wd)
            (butlast (butlast wd))
            (butlast wd)
            wd))

; **********************************************************

; 11.2 [8.12]* When you teach a class, people will get distracted if you say “um” too many times. Write a count-ums that counts the number of times “um” appears in a sentence:

; (count-ums
;  '(today um we are going to um talk about the combining um method))
; > 3

; Here are some special-case count-ums procedures for sentences of particular lengths:

;(define (count-ums0 sent)
;  0)

;(define (count-ums1 sent)
;  (if (equal? ’um (first sent))
;      1
;      0))

;(define (count-ums2 sent)
;  (if (equal? ’um (first sent))
;      (+ 1 (count-ums1 (bf sent)))
;      (count-ums1 (bf sent))))

;(define (count-ums3 sent)
;  (if (equal? ’um (first sent))
;      (+ 1 (count-ums2 (bf sent)))
;      (count-ums2 (bf sent))))

;Write count-ums recursively.

; answer:
(define (count-ums sent)
  (cond ((= (count sent) 0) 0)
        ((equal? 'um (first sent)) (+ 1 (count-ums (butfirst sent))))
        (else (count-ums (butfirst sent)))))

; **********************************************************

; 11.3 [8.13] Write a procedure phone-unspell that takes a spelled version of a phone number, such as POPCORN, and returns the real phone number, in this case 7672676. You will need a helper procedure that translates a single letter into a digit:

(define (unspell-letter letter)
  (cond ((member? letter 'abc) 2)
        ((member? letter 'def) 3)
        ((member? letter 'ghi) 4)
        ((member? letter 'jkl) 5)
        ((member? letter 'mno) 6)
        ((member? letter 'prs) 7)
        ((member? letter 'tuv) 8)
        ((member? letter 'wxy) 9)
        (else 0)))

;Here are some some special-case phone-unspell procedures:

;(define (phone-unspell1 wd)
;  (unspell-letter wd))

;(define (phone-unspell2 wd)
;  (word (unspell-letter (first wd))
;        (unspell-letter (first (bf wd)))))

;(define (phone-unspell3 wd)
;  (word (unspell-letter (first wd))
;        (unspell-letter (first (bf wd)))
;        (unspell-letter (first (bf (bf wd))))))

;Write phone-unspell recursively.

; answer:
(define (phone-unspell wd)
  (if (= (count wd) 1)
      (unspell-letter wd)
      (word (unspell-letter (first wd))
            (phone-unspell (butfirst wd)))))
