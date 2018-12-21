; Exercises 5.1-5.12

; 5.1 What values are printed when you type these expressions to Scheme? (Figure it out in your head before you try it on the computer.)

(sentence ’I ’(me mine)); (I me mine)
(sentence ’() ’(is empty)); (is empty)
(word ’23 ’45); 2345
(se ’23 ’45); (23 45)
(bf ’a); ""
(bf ’(aye)); ()
(count (first ’(maggie mae))); 6
(se "" ’() "" ’()); ("" "")
(count (se "" ’() "" ’())); 2

; **********************************************************

; 5.2 For each of the following examples, write a procedure of two arguments that, when applied to the sample arguments, returns the sample result. Your procedures may not include any quoted data.
(f1 ’(a b c) ’(d e f))
;(B C D E)
(f2 ’(a b c) ’(d e f))
;(B C D E AF)
(f3 ’(a b c) ’(d e f))
;(A B C A B C)
(f4 ’(a b c) ’(d e f))
;BE

; answer:
(define (f1 sent1 sent2)
  (sentence (bf sent1) (bl sent2)))

(define (f2 sent1 sent2)
  (se (se (bf sent1)
          (bl sent2))
      (word (first sent1) (last sent2))))

(define (f3 sent1 sent2)
  (se sent1 sent1))

(define (f4 sent1 sent2)
  (word (first (bf sent1))
        (first (bf sent2))))

; **********************************************************

; 5.3 Explain the difference in meaning between (first ’mezzanine) and (first ’(mezzanine)).

; answer: (first 'mezzanine) takes word 'mezzanine as its argument and returns the first letter m. (first '(mezzanine)) takes a one-word sentence '(mezzanine) as its argument and returns the first word 'mezzaine

; **********************************************************

; 5.4 Explain the difference between the two expressions (first (square 7)) and (first ’(square 7)).

; answer: (first (square 7)) takes the value of (square 7) as its argument. (square 7) returns number 49. so (first 49) returns 4.
; (first '(square 7)) takes sentence '(square 7) as its argument and returns the first word 'square.

; **********************************************************

; 5.5 Explain the difference between (word ’a ’b ’c) and (se ’a ’b ’c).

; answer: (word 'a 'b 'c) takse words 'a 'b 'c as arguments, combines them as a whole new word and returns 'abc.
; (se 'a 'b 'c) takes words 'a 'b 'c as arguments, combines them into a sentence and returns '(a b c).

; **********************************************************

; 5.6 Explain the difference between (bf ’zabadak) and (butfirst ’zabadak).

; answer: bf is the abbrevation of butfirst. the two procedures takes the same argument and return the same word 'abadak

; **********************************************************

; 5.7 Explain the difference between (bf ’x) and (butfirst ’(x)).

; answer: (bf 'x) takes one letter word 'x as argument and returns an empty word "".
; (butfirst '(x)) takes one word sentence '(x) as argument and returns an empty sentence ().

; **********************************************************

; 5.8 Which of the following are legal Scheme sentences?

(here, there and everywhere)
(help!) ; legle Scheme sentence
(all i've got to do)
(you know my name (look up the number))

; **********************************************************

; 5.9 Figure out what values each of the following will return before you try them on the computer:

(se (word (bl (bl (first '(make a))))
          (bf (bf (last '(baseball mitt)))))
    (word (first 'with) (bl (bl (bl (bl 'rigidly))))
          (first 'held) (first (bf 'stitches))))
; (matt wright)

(se (word (bl (bl 'bring)) 'a (last 'clean))
    (word (bl (last '(baseball hat))) (last 'for) (bl (bl 'very))
          (last (first '(sunny days)))))
; (brian harvey)

; **********************************************************

; 5.10 What kinds of argument can you give butfirst so that it returns a word? A sentence?

; answer:  when butfirst takes a word or a number as its argument, it returns a word.
; when butfirst takes a sentence as its argument it returns a sentence.

; **********************************************************

; 5.11 What kinds of argument can you give last so that it returns a word? A sentence?

; answer: when last takes a word, a number or a sentence as its argument, it returns a word.
; last doesn't return a sentence.

; **********************************************************

; 5.12 Which of the functions first, last, butfirst, and butlast can return an empty word? For what arguments? What about returning an empty sentence?

; answer: When butfirst and butlast take a one-letter word as its argument, they return an empty word.
; when taking a one-word sentence as its argument, butfirst and butlast return an empty sentence.
