; Exercises 21.1-21.9

; 21.1 The get-args procedure has a let that creates the variable first, and then that variable is used only once inside the body of the let. Why doesn’t it just say the following?

(define (get-args n)
  (if (= n 0)
      '()
      (cons (get-arg) (get-args (- n 1)))))

; answer:
; Creating a variable to store the value of `get-arg` in `get-args` is necessary because the order to evaluate the subexpressions in `cons` is unspecified.

; If `get-arg` is put into `cons` directly and the user's scheme interpreter evaluates subexpresssions from right to left, (get-args (- n 1)) will be evaluated before (get-arg) in `cons`. As a result, the first argument the user inputs will be put at the end of the argument list and cause error of "Argument(s) not in domain.".

; **********************************************************

; 21.2 The domain-checking function for equal? is

(lambda (x y) #t)

; This seems silly; it’s a function of two arguments that ignores both arguments and always returns #t. Since we know ahead of time that the answer is #t , why won’t it work to have equal? ’s entry in the a-list be

(list 'equal? equal? 2 #t)

; answer:
; The domain-checking function (lambda (x y) #t) for `equal?` can't be replaced by expression #t
; because in `in-domain?` a domain-checking function is required to be used as the first argument for `apply` function

(apply (type-predicate fn-name) args)

; It will cause error of "bad arguments" if a domain-checking functions is replaced by an expression.

; **********************************************************

; 21.3 Every time we want to know something about a function that the user typed in, such as its number of arguments or its domain-checking predicate, we have to do an assoc in *the-functions*. That’s inefficient. Instead, rewrite the program so that get-fn returns a function’s entry from the a-list, instead of just its name. Then rename the variable fn-name to fn-entry in the functions-loop procedure, and rewrite the selectors scheme-procedure, arg-count, and so on, so that they don’t invoke assoc.

; solution:

(define (functions-loop)
  (let ((fn-entry (get-fn)))
    (if (equal? (car fn-entry) 'exit)
        "Thanks for using FUNCTIONS!"
        (let ((args (get-args (arg-count fn-entry))))
          (if (not (in-domain? args fn-entry))
              (show "Argument(s) not in domain.")
              (show-answer (apply (scheme-function fn-entry) args)))
          (functions-loop)))))

(define (get-fn)
  (display "Function: ")
  (let ((line (read-line)))
    (cond ((empty? line)
           (show "Please type a function!")
           (get-fn))
          ((not (= (count line) 1))
           (show "You typed more than one thing!  Try again.")
           (get-fn))
          ((not (valid-fn-name? (first line)))
           (show "Sorry, that's not a function.")
           (get-fn))
          (else (assoc (car line) *the-functions*)))))

(define (scheme-function fn-entry)
  (cadr fn-entry))

(define (arg-count fn-entry)
  (caddr fn-entry))

(define (type-predicate fn-entry)
  (cadddr fn-entry))

(define (in-domain? args fn-entry)
  (apply (type-predicate fn-entry) args))

(define (named-every fn-name list)
  (every (scheme-function (assoc fn-name *the-functions*)) list))

(define (named-keep fn-name list)
  (keep (scheme-function (assoc fn-name *the-functions*)) list))

(define (hof-types-ok? fn-name stuff range-predicate)
  (let ((fn-entry (assoc fn-name *the-functions*)))
    (and (valid-fn-name? fn-name)
         (= 1 (arg-count fn-entry))
         (word-or-sent? stuff)
         (empty? (keep (lambda (element)
                         (not ((type-predicate fn-entry) element)))
                       stuff))
         (null? (filter (lambda (element)
                          (not (range-predicate element)))
                        (map (scheme-function fn-entry)
                             (every (lambda (x) x) stuff)))))))

; **********************************************************

; 21.4 Currently, the program always gives the message “argument(s) not in domain” when you try to apply a function to bad arguments. Modify the program so that each record in *the-functions* also contains a specific out-of-domain message like “both arguments must be numbers,” then modify functions to look up and print this error message along with “argument(s) not in domain.”

; solution:
; here I only add a specific out-of-domain message to the `*` entry, any other specific out-of-domain messages are supposed to add to the end of each entry in *the-functions*.

(define (functions-loop)
  (let ((fn-entry (get-fn)))
    (if (equal? (car fn-entry) 'exit)
        "Thanks for using FUNCTIONS!"
        (let ((args (get-args (arg-count fn-entry))))
          (if (not (in-domain? args fn-entry))
              (begin (show "Argument(s) not in domain.")
                     (show (cadddr (cdr fn-entry))))
              (show-answer (apply (scheme-function fn-entry) args)))
          (functions-loop)))))

(define *the-functions*
  (list (list '* * 2 two-numbers? "Both arguments must be numbers.")
        (list '+ + 2 two-numbers?)
        (list '- - 2 two-numbers?)
        (list '/ / 2 can-divide?)
        (list '< < 2 two-reals?)
        (list '<= <= 2 two-reals?)
        (list '= = 2 two-numbers?)
        (list '> > 2 two-reals?)
        (list '>= >= 2 two-reals?)
        (list 'abs abs 1 real?)

        (list 'acos acos 1 trig-range?)
        (list 'and (lambda (x y) (and x y)) 2
              (lambda (x y) (and (boolean? x) (boolean? y))))
        (list 'appearances appearances 2 member-types-ok?)
        (list 'asin asin 1 trig-range?)
        (list 'atan atan 1 number?)
        (list 'bf bf 1 not-empty?)
        (list 'bl bl 1 not-empty?)
        (list 'butfirst butfirst 1 not-empty?)
        (list 'butlast butlast 1 not-empty?)
        (list 'ceiling ceiling 1 real?)
        (list 'cos cos 1 number?)
        (list 'count count 1 word-or-sent?)
        (list 'equal? equal? 2 (lambda (x y) #t))
        (list 'even? even? 1 integer?)
        (list 'every named-every 2
              (lambda (fn stuff)
                (hof-types-ok? fn stuff word-or-sent?)))
        (list 'exit '() 0 '())
        ; in case user applies number-of-arguments to exit
        (list 'exp exp 1 number?)
        (list 'expt expt 2
              (lambda (x y)
                (and (number? x) (number? y)
                     (or (not (real? x)) (>= x 0) (integer? y)))))
        (list 'first first 1 not-empty?)
        (list 'floor floor 1 real?)
        (list 'gcd gcd 2 two-integers?)
        (list 'if (lambda (pred yes no) (if pred yes no)) 3
              (lambda (pred yes no) (boolean? pred)))
        (list 'item item 2
              (lambda (n stuff)
                (and (integer? n) (> n 0)
                     (word-or-sent? stuff) (<= n (count stuff)))))
        (list 'keep named-keep 2
              (lambda (fn stuff)
                (hof-types-ok? fn stuff boolean?)))
        (list 'last last 1 not-empty?)
        (list 'lcm lcm 2 two-integers?)
        (list 'log log 1 (lambda (x) (and (number? x) (not (= x 0)))))
        (list 'max max 2 two-reals?)
        (list 'member? member? 2 member-types-ok?)
        (list 'min min 2 two-reals?)
        (list 'modulo modulo 2 dividable-integers?)
        (list 'not not 1 boolean?)

        (list 'number-of-arguments arg-count 1 valid-fn-name?)
        (list 'odd? odd? 1 integer?)
        (list 'or (lambda (x y) (or x y)) 2
              (lambda (x y) (and (boolean? x) (boolean? y))))
        (list 'quotient quotient 2 dividable-integers?)
        (list 'random random 1 (lambda (x) (and (integer? x) (> x 0))))
        (list 'remainder remainder 2 dividable-integers?)
        (list 'round round 1 real?)
        (list 'se se 2
              (lambda (x y) (and (word-or-sent? x) (word-or-sent? y))))
        (list 'sentence sentence 2
              (lambda (x y) (and (word-or-sent? x) (word-or-sent? y))))
        (list 'sentence? sentence? 1 (lambda (x) #t))
        (list 'sin sin 1 number?)
        (list 'sqrt sqrt 1 (lambda (x) (and (real? x) (>= x 0))))
        (list 'tan tan 1 number?)
        (list 'truncate truncate 1 real?)
        (list 'vowel?
              (lambda (x)
                (and (word? x)
                     (= (count x) 1)
                     (member? x '(a e i o u))))
              1
              (lambda (x) #t))
        (list 'word word 2 (lambda (x y) (and (word? x) (word? y))))
        (list 'word? word? 1 (lambda (x) #t))))

; **********************************************************

; 21.5 Modify the program so that it prompts for the arguments this way:

; Function: if
; First Argument: #t
; Second Argument: paperback
; Third Argument: writer

; The result is: PAPERBACK

; but if there’s only one argument, the program shouldn’t say First :

; Function: sqrt
; Argument: 36

; The result is 6

; solution:

(define (get-args n)
  (if (= n 1)
      (get-args-single-helper n)
      (get-args-multi-helper n 1)))

(define (get-args-single-helper n)
  (if (= n 0)
      '()
      (begin (display "Argument: ")
             (let ((first (get-arg)))
               (cons first (get-args-single-helper (- n 1)))))))

(define (get-args-multi-helper n num-order)
  (if (= n 0)
      '()
      (begin (display (num-to-order num-order))
             (display " Argument: ")
             (let ((arg (get-arg)))
               (cons arg (get-args-multi-helper (- n 1) (+ num-order 1)))))))

(define (get-arg)
  (let ((line (read-line)))
    (cond ((empty? line)
           (show "Please type an argument!")
           (get-arg))
          ((and (equal? "(" (first (first line)))
                (equal? ")" (last (last line))))
           (let ((sent (remove-first-paren (remove-last-paren line))))
             (if (any-parens? sent)
                 (begin
                   (show "Sentences can't have parentheses inside.")
                   (get-arg))
                 (map booleanize sent))))
          ((any-parens? line)
           (show "Bad parentheses")
           (get-arg))
          ((empty? (bf line)) (booleanize (first line)))
          ((member? (first (first line)) "\"'")
           (show "No quoting arguments in this program.  Try again.")
           (get-arg))
          (else (show "You typed more than one argument!  Try again.")
                (get-arg)))))

(define (num-to-order num)
  (cond ((= num 1) 'First)
        ((= num 2) 'Second)
        ((= num 3) 'Third)))

; **********************************************************

; 21.6 The assoc procedure might return #f instead of an a-list record. How come it’s okay for arg-count to take the caddr of assoc ’s return value if (caddr #f) is an error?

; answer:
; It's okay for arg-count if assoc's return value is #f (when the input of function name doesn't match any record in *the-functions*), because procedure get-fn checks if the input function name is valid first and shows "sorry, that's not a function" when the input of function name is not valid and ask for the input of function name by invoking get-fn again.

; **********************************************************

; 21.7 Why is the domain-checking predicate for the word? function

(lambda (x) #t)

; instead of the following procedure?

(lambda (x) (word? x))

; answer:
; Because word? takes any scheme input as its argument and return #t when the input is a word and #f when it is not. If the domain-checking preicate for word? is replaced by (lambda (x) (word? x)), the valid non-word argument input will be considered invalid.

; **********************************************************

; 21.8 What is the value of the following Scheme expression?

(functions)

; answer:
; The returned value of (functions) is "Thanks for using Functions!". Everything else are side-effects printed on the screen.

; **********************************************************

; 21.9 We said in the recursion chapters that every recursive procedure has to have a base case and a recursive case, and that the recursive case has to somehow reduce the size of the problem, getting closer to the base case. How does the recursive call in get-fn reduce the size of the problem?

; answer:
; In get-fn the recursive call (get-fn) gets to base case (first line) by printing the debug messages to the end-users. The messages printed help the end-users to debug their input and make less and less invlaid input in every recursive call unitl the input falls in the domain of the procedure.
