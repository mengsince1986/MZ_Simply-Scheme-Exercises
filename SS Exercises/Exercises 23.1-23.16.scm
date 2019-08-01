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

