; Exercises 17.4-17.16

; 17.4 Describe the result of calling the following procedure with a list as its argument.  (See if you can figure it out before you try it.)

(define (mystery lst)
  (mystery-helper lst '()))

(define (mystery-helper lst other)
  (if (null? lst)
      other
      (mystery-helper (cdr lst) (cons (car lst) other))))

; answer:
; The procedure `mystery` accepts a list as its argument, reverse the list elements, and return the reversed list.

; for example
(mystery '(a b c))

; returns

'(c b a)

; **********************************************************

; 17.5 Here’s a procedure that takes two numbers as arguments and returns whichever number is larger:

(define (max2 a b)
  (if (> b a) b a))

; Use max2 to implement max , a procedure that takes one or more numeric arguments and returns the largest of them.

; solution:
(define (max num . rest-of-nums)
  (cond ((null? rest-of-nums) num)
        ((= (length rest-of-nums) 1)
         (max2 num (car rest-of-nums)))
        ((= (max2 num (car rest-of-nums)) num)
         (apply max (cons num (cdr rest-of-nums))))
        (else (apply max rest-of-nums))))

; extra solution without using max2
(define (max num . rest-of-nums)
  (cond ((null? rest-of-nums) num)
        ((> (car rest-of-nums) num)
         (apply max rest-of-nums))
        (else (apply max (cons num (cdr rest-of-nums))))))

; **********************************************************

; 17.6 Implement append using car , cdr , and cons . (Note: The built-in append can take any number of arguments. First write a version that accepts only two arguments.  Then, optionally, try to write a version that takes any number.)

; solution for 2-argumnt append:

(define (append-2 lst-1 lst-2)
  (append-2-helper (reverse lst-1) lst-2))

(define (append-2-helper lst-1 lst-2)
  (if (null? lst-1)
      lst-2
      (append-2-helper (cdr lst-1)
                       (cons (car lst-1) lst-2))))

; solution for multi-argument append:

(define (append lst . rest-of-lsts)
  (if (null? rest-of-lsts)
      lst
      (apply append (cons (append-2 lst (car rest-of-lsts))
                          (cdr rest-of-lsts)))))

; **********************************************************

; 17.7 Append may remind you of sentence . They’re similar, except that append works only with lists as arguments, whereas sentence will accept words as well as lists.  Implement sentence using append . (Note: The built-in sentence can take any number of arguments. First write a version that accepts only two arguments. Then, optionally, try to write a version that takes any number. Also, you don’t have to worry about the error checking that the real sentence does.)

; solution:

(define (sentence-2 elm-1 elm-2)
  (cond ((and (list? elm-1) (list? elm-2))
         (append elm-1 elm-2))
        ((and (not (list? elm-1)) (not (list? elm-2)))
         (list elm-1 elm-2))
        ((list? elm-2) (cons elm-1 elm-2))
        (else (append elm-1 (list elm-2)))))

(define (sentence elm . rest-of-elms)
  (if (null? rest-of-elms)
      elm
      (apply sentence (cons (sentence-2 elm (car rest-of-elms))
                            (cdr rest-of-elms)))))

; **********************************************************

; 17.8 Write member.

; solution:
(define (member elm lst)
  (cond ((null? lst) #f)
        ((equal? elm (car lst)) lst)
        (else (member elm (cdr lst)))))

; **********************************************************

; 17.9 Write list-ref.

; solution:
(define (list-ref lst index)
  (cond ((< index 0) '(error - index is less than the minimum range))
        ((> index (- (length lst) 1)) '(error - index is more than the maximum range))
        ((= index 0) (car lst))
        (else (list-ref (cdr lst) (- index 1)))))

; **********************************************************

; 17.10 Write length.

; solution:
(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst)))))

; **********************************************************

; 17.11 Write before-in-list?, which takes a list and two elements of the list. It should return #t if the second argument appears in the list argument before the third argument:

(before-in-list? '(back in the ussr) 'in 'ussr)
; #T

(before-in-list? '(back in the ussr) 'the 'back)
; #F

; The procedure should also return #f if either of the supposed elements doesn’t appear at all.

; solution:
(define (before-in-list? lst elm-1 elm-2)
  (let ((elm-1-chop (member elm-1 lst))
        (elm-2-chop (member elm-2 lst)))
    (cond ((or (not elm-1-chop) (not elm-2-chop)) #f)
          ((> (length elm-1-chop) (length elm-2-chop)) #t)
          (else #f))))

; **********************************************************

; 17.12 Write a procedure called flatten that takes as its argument a list, possibly including sublists, but whose ultimate building blocks are words (not Booleans or procedures). It should return a sentence containing all the words of the list, in the order in which they appear in the original:

(flatten '(((a b) c (d e)) (f g) ((((h))) (i j) k)))
; (A B C D E F G H I J K)

;solution:
(define (flatten lst)
  (cond ((word? lst) (list lst))
        ((null? lst) '())
        (else (append (flatten (car lst))
                      (flatten (cdr lst))))))

; **********************************************************

; 17.13 Here is a procedure that counts the number of words anywhere within a structured list:

(define (deep-count lst)
  (cond ((null? lst) 0)
        ((word? (car lst)) (+ 1 (deep-count (cdr lst))))
        (else (+ (deep-count (car lst))
                 (deep-count (cdr lst))))))

; Although this procedure works, it’s more complicated than necessary. Simplify it.

; solution:
(define (deep-count-s lst)
  (cond ((null? lst) 0)
        ((word? lst) 1)
        (else (+ (deep-count-s (car lst))
                 (deep-count-s (cdr lst))))))

; **********************************************************

; 17.14 Write a procedure branch that takes as arguments a list of numbers and a nested list structure. It should be the list-of-lists equivalent of item , like this:

(branch '(3) '((a b) (c d) (e f) (g h)))
; (E F)

(branch '(3 2) '((a b) (c d) (e f) (g h)))
; F

(branch '(2 3 1 2) '((a b) ((c d) (e f) ((g h) (i j)) k) (l m)))
; H

; In the last example above, the second element of the list is ((C D) (E F) ((G H) (I J)) K) The third element of that smaller list is ((G H) (I J)) ; the first element of that is (G H); and the second element of that is just H.

; solution:
(define (branch index-lst deep-lst)
  (branch-helper (reverse (num-lst-minus1 index-lst)) deep-lst))

(define (branch-helper index-lst deep-lst)
  (if (null? index-lst)
      deep-lst
      (list-ref (branch-helper (cdr index-lst) deep-lst) (car index-lst))))

(define (num-lst-minus1 num-lst)
  (if (null? num-lst)
      '()
      (cons (- (car num-lst) 1)
            (num-lst-minus1 (cdr num-lst)))))

; **********************************************************

; 17.15 Modify the pattern matcher to represent the known-values database as a list of two-element lists, as we suggested at the beginning of this chapter.

; original:
(FRONT YOUR MOTHER ! BACK SHOULD KNOW !)

; list-version:
((FRONT (YOUR MOTHER)) (BACK (SHOULD KNOW)))

; solution:

;;; Known values database abstract data type

(define (lookup name known-values)
  (cond ((empty? known-values) 'no-value)
        ((equal? (car (car known-values)) name)
         (get-value (bf known-values)))
        (else (lookup name (skip-value known-values)))))

(define (get-value stuff)
  (cdar stuff))

(define (skip-value stuff)
  (cdr stuff))

(define (add name value known-values)
  (if (empty? name)
      known-values
      (append known-values (list (list name value)))))

; **********************************************************

; 17.16 Write a predicate valid-infix? that takes a list as argument and returns #t if and only if the list is a legitimate infix arithmetic expression (alternating operands and operators, with parentheses—that is, sublists—allowed for grouping).

(valid-infix? '(4 + 3 * (5 - 2)))
; #T

(valid-infix? '(4 + 3 * (5 2)))
; #F

; solution:

(define (valid-infix? lst)
  (cond ((< (length lst) 3) #f)
        ((valid-infix-lst? lst)
         (valid-infix-helper (sub-lsts lst)))
        (else #f)))

(define (valid-infix-helper lst)
  (cond ((null? lst) #t)
        ((valid-infix? (car lst))
         (valid-infix-helper (cdr lst)))
        (else #f)))

(define (sub-lsts lst)
  (cond ((null? lst) '())
        ((list? (car lst)) (cons (car lst) (sub-lsts (cdr lst))))
        (else (sub-lsts (cdr lst)))))

(define (valid-infix-lst? lst)
  (if (and (number-list? (odd-elements lst))
           (operator-lst? (even-elements lst)))
      #t
      #f))

(define (number-list? lst)
  (cond ((null? lst) #t)
        ((or (number? (car lst))
             (list? (car lst)))
         (number-list? (cdr lst)))
        (else #f)))

(define (operator-lst? lst)
  (cond ((null? lst) #t)
        ((member (car lst) '(+ - * /))
         (operator-lst? (cdr lst)))
        (else #f)))

(define (odd-elements lst)
  (cond ((null? lst) '())
        ((= (length lst) 1) (list (car lst)))
        (else (cons (car lst) (odd-elements (cddr lst))))))

(define (even-elements lst)
  (if (or (null? lst)
          (= (length lst) 1))
      '()
      (cons (cadr lst) (even-elements (cddr lst)))))
