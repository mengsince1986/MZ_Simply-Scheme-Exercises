; Exercises 19.2-19.13

; 19.2 Write keep. Don’t forget that keep has to return a sentence if its second argument is a sentence, and a word if its second argument is a word.

; (Hint: it might be useful to write a combine procedure that uses either word or sentence depending on the types of its arguments.)

; solution:
(define (keep pred sw)
  (if (word? sw)
      (combine-keep "" word pred sw)
      (combine-keep '() sentence pred sw)))

(define (combine-keep base combiner pred sw)
  (cond ((empty? sw) base)
        ((pred (first sw))
         (combiner (first sw)
                   (combine-keep base combiner pred (butfirst sw))))
        (else (combine-keep base combiner pred (butfirst sw)))))

; **********************************************************

; 19.3 Write the three-argument version of accumulate that we described.

(three-arg-accumulate + 0 '(4 5 6))
; 15

(three-arg-accumulate + 0 '())
; 0

(three-arg-accumulate cons '() '(a b c d e))
; (A B C D E)

;solution:

(define (three-arg-accumulate combiner base stuff)
  (if (not (empty? stuff))
      (real-three-arg-accumulate combiner base stuff)
      (combiner)))

(define (real-three-arg-accumulate combiner base stuff)
  (if (empty? stuff)
      base
      (combiner (first stuff)
                (real-three-arg-accumulate combiner base (butfirst stuff)))))

; **********************************************************

; 19.4 Our accumulate combines elements from right to left. That is,

(accumulate - '(2 3 4 5))

; computes 2 − (3 − (4 − 5)). Write left-accumulate, which will compute ((2 − 3) − 4) − 5 instead. (The result will be the same for an operation such as + , for which grouping order doesn’t matter, but will be different for -.)

; solution:
(define (left-accumulate combiner stuff)
  (if (not (empty? stuff))
      (real-left-accumulate combiner stuff)
      (combiner)))

(define (real-left-accumulate combiner stuff)
  (if (empty? (butlast stuff))
      (last stuff)
      (combiner (real-left-accumulate combiner (butlast stuff))
                (last stuff))))

; **********************************************************

; 19.5 Rewrite the true-for-all? procedure from Exercise 8.10. Do not use every, keep, or accumulate.

; ----------
; 8.10 Write a predicate true-for-all? that takes two arguments, a predicate procedure and a sentence. It should return #t if the predicate argument returns true for every word in the sentence.

(true-for-all? even? '(2 4 6 8))
; #T

(true-for-all? even? '(2 6 3 4))
; #F
; ----------

