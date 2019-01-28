; Exercises 7.3-7.4

; 7.3 The following program doesn’t work. Why not? Fix it.
(define (superlative adjective word)
  (se (word adjective 'est) word))

; It’s supposed to work like this:
(superlative 'dumb 'exercise) ;(DUMBEST EXERCISE)

;answer:
; The program doesn't work due to the naming of its second formal parameter. `word` is a primitive procedure so it can't be used as a formal parameter.

; fixed version:
(define (superlative adjective wd)
  (se (word adjective 'est) wd))

; **********************************************************

; 7.4 What does this procedure do? Explain how it manages to work.
(define (sum-square a b)
  (let ((+ *)
        (* +))
    (* (+ a a) (+ b b))))

; The `sum-square` exchanges the value between `+` and `*` and returns the sum of square a and square b.
; In the procedure `sum-square`, `let` the variable `+` have the value of `*` and the variable `*` have the value of `+`. Then the procedure in the body calculats the sum of square a and square b.
