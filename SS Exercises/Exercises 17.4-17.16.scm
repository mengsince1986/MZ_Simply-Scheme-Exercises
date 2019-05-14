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


; **********************************************************

; 17.10 Write length.
