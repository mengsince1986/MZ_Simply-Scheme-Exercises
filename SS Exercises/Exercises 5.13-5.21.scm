; Exercises 5.13-5.21

; 5.13 What does ''banana stand for?

; answer: ''banana stands for (quote banana)

; What is (first ''banana) and why?

; answer: it returns 'quote. because the first ' is interpreted as procedure quote, then the second ' and banana are taken as its arguments. the value of the second ' is procedure quote. so 'banana is returned as (quote banana). (first '(quote banana)) returns 'quote.

; **********************************************************

; 5.14 Write a procedure third that selects the third letter of a word (or the third word of a sentence).

; answer:
(define (third symbol)
  (first (bf (bf symbol))))

; **********************************************************

; 5.15 Write a procedure first-two that takes a word as its argument, returning a two-letter word containing the first two letters of the argument.
(first-two 'ambulatory)
;AM

; answer:
(define (first-two symbol)
  (word (first symbol)
        (first (bf symbol))))

; **********************************************************

; 5.16 Write a procedure two-first that takes two words as arguments, returning a two-letter word containing the first letters of the two arguments.
(two-first 'brian 'epstein) ;BE

; answer:
(define (two-first symbol-1 symbol-2)
  (word (first symbol-1)
        (first symbol-2)))

; Now write a procedure two-first-sent that takes a two-word sentence as argument, returning a two-letter word containing the first letters of the two words.
(two-first-sent '(brian epstein)) ;BE

; answer:
(define (two-first-sent two-word-sentence)
  (word (first (first two-word-sentence))
        (first (last two-word-sentence))))

; **********************************************************

; 5.17 Write a procedure knight that takes a person's name as its argument and returns the name with “Sir” in front of it.
(knight '(david wessel))
;(SIR DAVID WESSEL)

; answer:
(define (knight name)
  (sentence 'Sir name))

; **********************************************************

; 5.18 Try the following and explain the result:

(define (ends word)
  (word (first word) (last word)))

(ends 'john)

; answer: (ends 'john) returns an error. the error is due to the nameing of the formal parameter. word is a pre-definied procedure which means the same name (word in this example) is used with two meanings in the procedure. to fix the error, the formal parameter should be changed into other names like 'symbol.

; **********************************************************

; 5.19 Write a procedure insert-and that takes a sentence of items and returns a new sentence with an “and” in the right place:
(insert-and '(john bill wayne fred joey)) ;(JOHN BILL WAYNE FRED AND JOEY)

;answer:
(define (insert-and items)
  (sentence (bl items)
            (sentence 'and (last items))))

; **********************************************************

; 5.20 Define a procedure to find somebody's middle names:
(middle-names '(james paul mccartney))
; (PAUL)
(middle-names '(john ronald raoul tolkien))
; (RONALD RAOUL)
(middle-names '(bugs bunny))
; ()
(middle-names '(peter blair denis bernard noone))
; (BLAIR DENIS BERNARD)

; answer:
(define (middle-names names)
  (bl (bf names)))

; **********************************************************

; 5.21 Write a procedure query that turns a statement into a question by swapping the first two words and adding a question mark to the last word:
(query '(you are experienced))
;(ARE YOU EXPERIENCED?)

(query '(i should have known better))
;(SHOULD I HAVE KNOWN BETTER?)

; answer:
(define (query statement)
  (sentence (first (bf statement))
            (first statement)
            (bl (bf (bf statement)))
            (word (last statement) '?)))



