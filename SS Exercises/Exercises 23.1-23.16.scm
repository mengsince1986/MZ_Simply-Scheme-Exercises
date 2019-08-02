; Exercises 23.1-23.16

; Do not solve any of the following exercises by converting a vector to a list, using list procedures, and then converting the result back to a vector.

; 23.1 Write a procedure sum-vector that takes a vector full of numbers as its argument and returns the sum of all the numbers:

(sum-vector '#(6 7 8))
; 21

; solution:

(define (sum-vector vec)
  (sum-vec-helper vec (- (vector-length vec) 1)))

(define (sum-vec-helper vec index)
  (if (< index 0)
      0
      (+ (vector-ref vec index)
         (sum-vec-helper vec (- index 1)))))

; **********************************************************

; 23.2 Some versions of Scheme provide a procedure vector-fill! that takes a vector and anything as its two arguments. It replaces every element of the vector with the second argument, like this:

(define vec (vector 'one 'two 'three 'four))

vec
; #(one two three four)

(vector-fill! vec 'yeah)

vec
; #(yeah yeah yeah yeah)

; Write vector-fill! . (It doesn’t matter what value it returns.)

; solution:

(define (vector-fill! vec ele)
  (vc-fill!-helper vec ele (- (vector-length vec) 1)))

(define (vc-fill!-helper vec ele index)
  (if (< index 0)
      vec
      (begin (vector-set! vec index ele)
             (vc-fill!-helper vec ele (- index 1)))))

; **********************************************************

; 23.3 Write a function vector-append that works just like regular append , but for vectors:

(vector-append '#(not a) '#(second time))
; #(not a second time)

(define (vector-append vec-a vec-b)
  (let ((index-a (- (vector-length vec-a) 1))
        (index-b (- (vector-length vec-b) 1))
        (vec-ab (make-vector (+ (vector-length vec-a)
                                (vector-length vec-b)))))
    (vec-append-helper vec-ab (- (vector-length vec-ab) 1)
                       vec-a index-a
                       vec-b index-b)))

(define (vec-append-helper vec-ab index-ab
                           vec-a index-a
                           vec-b index-b)
  (copy-vec vec-ab index-ab vec-b index-b)
  (copy-vec vec-ab (- index-ab (vector-length vec-b))
            vec-a index-a)
  vec-ab)

(define (copy-vec vec-out start vec-in index-in)
  (if (< index-in 0)
      'done
      (begin (vector-set! vec-out start
                          (vector-ref vec-in index-in))
             (copy-vec vec-out (- start 1)
                       vec-in (- index-in 1)))))


