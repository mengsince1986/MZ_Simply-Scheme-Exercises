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

; **********************************************************

; 23.4 Write vector->list.

; solution:

(define (vector->list vec)
 (vec->lst-helper vec 0 (- (vector-length vec) 1)))

(define (vec->lst-helper vec index end)
  (if (= index end)
      (list (vector-ref vec index))
      (cons (vector-ref vec index)
            (vec->lst-helper vec (+ index 1) end))))

; **********************************************************

; 23.5 Write a procedure vector-map that takes two arguments, a function and a vector, and returns a new vector in which each box contains the result of applying the function to the corresponding element of the argument vector.

; solution:

(define (vector-map fun vec)
  (let ((vec-length (vector-length vec)))
    (vec-map-helper fun vec (make-vector vec-length) (- vec-length 1))))

(define (vec-map-helper fun vec new-vec index)
  (if (< index 0)
      new-vec
      (begin (vector-set! new-vec index
                          (fun (vector-ref vec index)))
             (vec-map-helper fun vec new-vec (- index 1)))))

; **********************************************************

; 23.6 Write a procedure vector-map! that takes two arguments, a function and a vector, and modifies the argument vector by replacing each element with the result of applying the function to that element. Your procedure should return the same vector.

; solution:

(define (vector-map! fun vec)
  (vec-map!-helper fun vec (- (vector-length vec) 1))
  vec)

(define (vec-map!-helper fun vec index)
  (if (< index 0)
      'done
      (begin (vector-set! vec index
                          (fun (vector-ref vec index)))
             (vec-map!-helper fun vec (- index 1)))))

; **********************************************************

; 23.7 Could you write vector-filter? How about vector-filter!? Explain the issues involved.

; answer:

; It's attainable to write vector-filter. Theoretically, We can filter the values of a vector and copy the filtered values into a new vecor. But it will be tricky to define the new vector since at first we don't know how many value containers we need when make-vector the new vecor. One possible strategy is copy the filtered values of the vector to a list and then convert the list to vector.

; It's not attainable to write vector-fiter! because a vector has a fixed number of boxes containing values. Instead of removing a value box from a vector, we can only change the value itself.

; **********************************************************

; 23.8 Modify the lap procedure to print “Car 34 wins!” when car 34 completes its 200th lap. (A harder but more correct modification is to print the message only if no other car has completed 200 laps.)

; ----------------------------------------------------------
(define *lap-vector* (make-vector 100))

(define (initialize-lap-vector index)
  (if (< index 0)
      'done
      (begin (vector-set! *lap-vector* index 0)
             (initialize-lap-vector (- index 1)))))

(define (lap car-number)
  (vector-set! *lap-vector*
               car-number
               (+ (vector-ref *lap-vector* car-number) 1))
  (vector-ref *lap-vector* car-number))
; ----------------------------------------------------------

; solution:

(define (lap car-number)
  (vector-set! *lap-vector*
               car-number
               (+ (vector-ref *lap-vector* car-number) 1))
  (let ((current-lap (vector-ref *lap-vector* car-number)))
    (if (= current-lap 200)
        (begin (display "Car ")
               (display car-number)
               (show " wins!"))
        (vector-ref *lap-vector* car-number))))

; extra:

(define (lap-v2 car-number)
  (vector-set! *lap-vector*
               car-number
               (+ (vector-ref *lap-vector* car-number) 1))
  (let ((current-lap (vector-ref *lap-vector* car-number)))
    (if (and (= current-lap 200)
             (if-first-complete? car-number *lap-vector* (- (vector-length *lap-vector*) 1)))
        (begin (display "Car ")
               (display car-number)
               (show " wins!"))
        (vector-ref *lap-vector* car-number))))

(define (if-first-complete? car-number recorder index)
  (if (< index 0)
      car-number
      (if (or (= index car-number)
              (< (vector-ref recorder index) 200))
          (if-first-complete? car-number recorder (- index 1))
          #f)))

; **********************************************************

; 23.9 Write a procedure leader that says which car is in the lead right now.

; solution:

(define (leader recorder)
  (leader-helper recorder (- (vector-length recorder) 2) (- (vector-length recorder) 1)))

(define (leader-helper recorder rest lead-car)
  (if (< rest 0)
      lead-car
      (if (> (vector-ref recorder rest) (vector-ref recorder lead-car))
          (leader-helper recorder (- rest 1) rest)
          (leader-helper recorder (- rest 1) lead-car))))

; **********************************************************

; 23.10 Why doesn’t this solution to Exercise 23.9 work?

; (define (leader)
;   (leader-helper 0 1))

; (define (leader-helper leader index)
;   (cond ((= index 100) leader)
;         ((> (lap index) (lap leader))
;          (leader-helper index (+ index 1)))
;         (else (leader-helper leader (+ index 1)))))

; answer: The leader defined above doesn't work because the leader-helper may repeadly apply procedure lap on leader car and make it bigger than other cars. Procedure lap should be replaced by procedure vector-ref to check the cars's current laps instead of changing its current laps.

; **********************************************************

; 23.11 In some restaurants, the servers use computer terminals to keep track of what each table has ordered. Every time you order more food, the server enters your order into the computer. When you’re ready for the check, the computer prints your bill.

; You’re going to write two procedures, order and bill. Order takes a table number and an item as arguments and adds the cost of that item to that table’s bill. Bill takes a table number as its argument, returns the amount owed by that table, and resets the table for the next customers. (Your order procedure can examine a global variable *menu* to find the price of each item.)

(order 3 'potstickers)
(order 3 'wor-won-ton)
(order 5 'egg-rolls)
(order 3 'shin-shin-special-prawns)

(bill 3)
; 13.85

(bill 5)
; 2.75

; solution:

(define *menu* (list '(egg-rolls 2.75) '(potstickers 5) '(wor-won-ton 3)             ; create *menu* a-list
                     '(shin-shin-special-prawns 5.85) '(fish-n-chips 4.5)
                     '(beef-pie 1.2) '(newyorker-pizza 9.9) '(fried-dumplings 12)))

(define *table-bills* (make-vector 10))    ; create ten-table *table-bills* vector

(define (initialize-table-bills index)     ; define initialize-table-bills to initialize the whole *table-bills* vector with 0
  (if (< index 0)
      'done
      (begin (vector-set! *table-bills* index 0)
             (initialize-table-bills (- index 1)))))

(initialize-table-bills 9)                 ; Initialize the 10 table bills, here the table numbers are from 0 to 9

(define (order table dish)                 ; define procedure order
  (vector-set! *table-bills* table
               (+ (vector-ref *table-bills* table)
                  (cadr (assoc dish *menu*))))
  (show "Order is registered"))

; define procedure bill

(define (bill table)
  (show (vector-ref *table-bills* table))
  (vector-set! *table-bills* table 0))

; **********************************************************











