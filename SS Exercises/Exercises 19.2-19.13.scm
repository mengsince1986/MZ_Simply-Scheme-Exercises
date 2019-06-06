; Exercises 19.2-19.13

; -------------------- tree constructor/selectors/predicates
(define (make-node datum children)
  (cons datum children))

(define (leaf datum)
  (make-node datum '()))

(define (leaf? node)
  (null? (children node)))

(define (datum node)
  (car node))

(define (children node)
  (cdr node))
; --------------------

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

(define (true-for-all? pred sent)
  (if (null? sent)
      #f
      (true-for-all-helper pred sent)))

(define (true-for-all-helper pred sent)
  (cond ((null? sent) #t)
        ((not (pred (car sent))) #f)
        (else (true-for-all-helper pred (cdr sent)))))

; **********************************************************

; 19.6 Write a procedure true-for-any-pair? that takes a predicate and a sentence as arguments. The predicate must accept two words as its arguments. Your procedure should return #t if the argument predicate will return true for any two adjacent words in the sentence:

(true-for-any-pair? equal? '(a b c b a))
; #F

(true-for-any-pair? equal? '(a b c c d))
; #T

(true-for-any-pair? < '(20 16 5 8 6))
; #T

; solution:

(define (true-for-any-pair? pred sent)
  (cond ((null? (cdr sent)) #f)
        ((pred (car sent) (cadr sent)) #t)
        (else (true-for-any-pair? pred (cdr sent)))))

; **********************************************************

; 19.7 Write a procedure true-for-all-pairs? that takes a predicate and a sentence as arguments. The predicate must accept two words as its arguments. Your procedure should return #t if the argument predicate will return true for every two adjacent words in the sentence:

(true-for-all-pairs? equal? '(a b c c d))
; #F

(true-for-all-pairs? equal? '(a a a a a))
; #T

(true-for-all-pairs? < '(20 16 5 8 6))
; #F

(true-for-all-pairs? < '(3 7 19 22 43))
; #T

; solution:

(define (true-for-all-pairs? pred sent)
  (let ((1st-equal-2nd? (pred (car sent) (cadr sent))))
    (cond ((= (length sent) 2) 1st-equal-2nd?)
          ((not 1st-equal-2nd?) #f)
          (else (true-for-all-pairs? pred (cdr sent))))))

; **********************************************************

; 19.8 Rewrite true-for-all-pairs? (Exercise 19.7) using true-for-any-pair?  (Exercise 19.6) as a helper procedure. Don’t use recursion in solving this problem (except for the recursion you’ve already used to write true-for-any-pair? ). Hint: You’ll find the not procedure helpful.

; solution:

(define (true-for-all-pairs? pred sent)
  (not (true-for-any-pair? (lambda (a b) (not (pred a b)))
                           sent)))

; **********************************************************

; 19.9 Rewrite either of the sort procedures from Chapter 15 to take two arguments, a list and a predicate. It should sort the elements of that list according to the given predicate:

; ----------
; the selection sort in Chapter 15

(define (sort sent)
  (if (empty? sent)
      '()
      (se (earliest-word sent)
          (sort (remove-once (earliest-word sent) sent)))))

(define (earliest-word sent)
  (earliest-helper (first sent) (bf sent)))

(define (earliest-helper so-far rest)
  (cond ((empty? rest) so-far)
        ((before? so-far (first rest))
         (earliest-helper so-far (bf rest)))
        (else (earliest-helper (first rest) (bf rest)))))

(define (remove-once wd sent)
  (cond ((empty? sent) '())
        ((equal? wd (first sent)) (bf sent))
        (else (se (first sent) (remove-once wd (bf sent))))))
; ----------

(sort '(4 23 7 5 16 3) <)
; (3 4 5 7 16 23)

(sort '(4 23 7 5 16 3) >)
; (23 16 7 5 4 3)

(sort '(john paul george ringo) before?)
; (GEORGE JOHN PAUL RINGO)

; solution:

(define (sort lst pred)
  (if (null? lst)
      '()
      (cons (head-element lst pred)
            (sort (remove-once (head-element lst pred) lst) pred))))

(define (head-element lst pred)
  (head-element-helper (car lst) (cdr lst) pred))

(define (head-element-helper so-far rest pred)
  (cond ((null? rest) so-far)
        ((pred so-far (car rest))
         (head-element-helper so-far (cdr rest) pred))
        (else (head-element-helper (car rest) (cdr rest) pred))))

(define (remove-once element lst)
  (cond ((null? lst) '())
        ((equal? element (car lst)) (cdr lst))
        (else (cons (car lst) (remove-once element (cdr lst))))))

; **********************************************************

; 19.10 Write tree-map, analogous to our deep-map, but for trees, using the datum and children selectors.

; solution:

(define (tree-map fn tree)
  (if (leaf? tree)
      (leaf (fn (datum tree)))
      (cons (fn (datum tree))
            (forest-map fn (children tree)))))

(define (forest-map fn forest)
  (if (null? forest)
      '()
      (cons (tree-map fn (car forest))
            (forest-map fn (cdr forest)))))

; **********************************************************

; 19.11 Write repeated. (This is a hard exercise!)

; --------------------
; The procedure repeated takes two arguments, a procedure and a number, and returns a new procedure. The returned procedure is one that invokes the original procedure repeatedly.
; --------------------

; solution:

(define (repeated fn n)
 (if (<= n 1)
     (lambda arg (apply fn arg))
     (lambda arg (apply fn (repeated-helper fn arg (- n 1))))))

(define (repeated-helper fn arg n)
  (if (= n 1)
      (list (apply fn arg))
      (list (apply fn (repeated-helper fn arg (- n 1))))))

; -------------------- thinking process

(define (repeated-twice-single-arg fn)
  (lambda (arg) (fn (fn arg))))

(define (repeated-twice-single-arg-v2 fn)
  (lambda (arg) (apply fn (list (apply fn (list arg))))))

(define (repeated-twice-infinite-arg fn)
 (lambda arg (apply fn (list (apply fn arg)))))

; --------------------

; **********************************************************

; 19.12 Write tree-reduce. You may assume that the combiner argument can be invoked with no arguments.

(tree-reduce
 +
 (make-node 3 (list (make-node 4 '())
                    (make-node 7 '())
                    (make-node 2 (list (make-node 3 '())
                                       (make-node 8 '()))))))
; 27

; solution:

(define (tree-reduce combiner tree)
  (if (leaf? tree)
      (datum tree)
      (combiner (datum tree) (forest-reduce combiner (children tree)))))

(define (forest-reduce combiner forest)
  (if (null? (cdr forest))
      (tree-reduce combiner (car forest))
      (combiner (tree-reduce combiner (car forest))
                (forest-reduce combiner (cdr forest)))))

; **********************************************************

; 19.13 Write deep-reduce , similar to tree-reduce, but for structured lists:

(deep-reduce word '(r ((a (m b) (l)) (e (r)))))
; RAMBLER

; solution:

(define (deep-reduce combiner structure)
  (if (not (empty? structure))
      (real-deep-reduce combiner structure)
      (combiner)))

(define (real-deep-reduce combiner structure)
  (cond ((word? structure) structure)
        ((null? (cdr structure)) (real-deep-reduce combiner (car structure)))
        (else (combiner (real-deep-reduce combiner (car structure))
                        (real-deep-reduce combiner (cdr structure))))))
