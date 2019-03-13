; Project: Spelling Names of Huge Numbers

; Write a procedure number-name that takes a positive integer argument and returns a sentence containing that number spelled out in words:

; > (number-name 5513345)
; (FIVE MILLION FIVE HUNDRED THIRTEEN THOUSAND THREE HUNDRED FORTY FIVE)

; > (number-name (factorial 20))
; (TWO QUINTILLION FOUR HUNDRED THIRTY TWO QUADRILLION NINE HUNDRED TWO TRILLION EIGHT BILLION ONE HUNDRED SEVENTY SIX MILLION SIX HUNDRED FORTY THOUSAND)

; There are some special cases you will need to consider:
; • Numbers in which some particular digit is zero
; • Numbers like 1,000,529 in which an entire group of three digits is zero. • Numbers in the teens.

; Here are two hints. First, split the number into groups of three digits, going from right to left. Also, use the sentence
; '(thousand million billion trillion quadrillion quintillion sextillion septillion octillion nonillion decillion)

; You can write this bottom-up or top-down. To work bottom-up, pick a subtask and get that working before you tackle the overall structure of the problem. For example, write a procedure that returns the word FIFTEEN given the argument 15.

; To work top-down, start by writing number-name, freely assuming the existence of whatever helper procedures you like. You can begin debugging by writing stub procedures that fit into the overall program but don’t really do their job correctly. For example, as an intermediate stage you might end up with a program that works like this:

; > (number-name 1428425)              ;; intermediate version
; (1 MILLION 428 THOUSAND 425)

; **********************************************************

; solution:
(define (number-name num)
  (let ((group-digit (group num))
        (value '(thousand million
                          billion trillion quadrillion
                          quintillion sextillion septillion
                          octillion nonillion decillion)))
    (sentence (number-name-helper (butfirst group-digit) value)
              (name-digit (first group-digit)))))

(define (number-name-helper group-digit value)
  (cond ((empty? group-digit) '())
        ((= (first group-digit) 0) (number-name-helper (butfirst group-digit) (butfirst value)))
        ((sentence (number-name-helper (butfirst group-digit) (butfirst value))
                   (sentence (name-digit (first group-digit)) (first value))))))

(define (group num)
  (if (< (count num) 4)
      (sentence num)
      (sentence (word (last (butlast (butlast num)))
                      (last (butlast num))
                      (last num))
                (group (butlast (butlast (butlast num)))))))

(define (name-digit num)
  (cond ((< num 20) (digit num))
        ((= (first num) 0) (name-digit (butfirst num)))
        ((= (count num) 3) (sentence (sentence (digit (first num))
                                               'hundred)
                                     (name-digit (butfirst num))))
        ((= (count num) 2) (sentence (digit (word (first num) 0))
                                     (name-digit (butfirst num))))
        (else (digit num))))

(define (digit num)
  (cond ((= 0 num) '())
        ((= 1 num) 'one)
        ((= 2 num) 'two)
        ((= 3 num) 'three)
        ((= 4 num) 'four)
        ((= 5 num) 'five)
        ((= 6 num) 'six)
        ((= 7 num) 'seven)
        ((= 8 num) 'eight)
        ((= 9 num) 'nine)
        ((= 10 num) 'ten)
        ((= 11 num) 'eleven)
        ((= 12 num) 'twelve)
        ((= 13 num) 'thirteen)
        ((= 14 num) 'fourteen)
        ((= 15 num) 'fifteen)
        ((= 16 num) 'sixteen)
        ((= 17 num) 'seventeen)
        ((= 18 num) 'eighteen)
        ((= 19 num) 'nineteen)
        ((= 20 num) 'twenty)
        ((= 30 num) 'thirty)
        ((= 40 num) 'forty)
        ((= 50 num) 'fifty)
        ((= 60 num) 'sixty)
        ((= 70 num) 'seventy)
        ((= 80 num) 'eighty)
        ((= 90 num) 'ninety)
        ))
