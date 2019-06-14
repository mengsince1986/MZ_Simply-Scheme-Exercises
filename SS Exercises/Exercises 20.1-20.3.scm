; Exercises 20.1-20.3

; 20.1 What happens when we evaluate the following expression? What is printed, and what is the return value? Try to figure it out in your head before you try it on the computer.

(cond ((= 2 3) (show '(lady madonna)) '(i call your name))
      ((< 2 3) (show '(the night before)) '(hello little girl))
      (else '(p.s. i love you)))

; answer:
; '(the night before) is printed and '(hello little girl) is the return value

; **********************************************************

; 20.2 What does newline return in your version of Scheme?

; answer:
; a blank line

; **********************************************************

; 20.3 Define show in terms of newline and display.

; solution:
(define (show expr)
  (display expr)
  (newline))
