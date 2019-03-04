; Exercises 13.1-13.4

; 13.1 Trace the explode procedure from page 183 and invoke

; (explode ’ape)

;How many recursive calls were there? What were the arguments to each recursive call? Turn in a transcript showing the trace listing.

; answer: there were 4 recursive calls.
; the first call takes 'ape as its argument
; the second call takes 'pe as its argument
; the third call takes 'e as its argument
; the fourth call takes "" as its argument
; the tracing list is as following:
; (explode 'ape)
; >(explode 'ape)
; > (explode 'pe)
; > >(explode 'e)
; > > >(explode "")
; < < <'()
; < <'(e)
; < '(p e)
; <'(a p e)
; '(a p e)

; **********************************************************

; 13.2 How many pigl-specialist little people are involved in evaluating the following expression?

(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

; (pigl 'throughout)

; What are their arguments and return values, and to whom does each give her result?

; answer:
; There are 4 little people involved in evaluating the expression.
; little people p01 takes 'throughout as its argument and hire p02
; little people p02 takes 'hroughoutt as its argument and hire p03
; little people p03 takes 'roughoutth as its argument and hire p04
; little people p04 takes 'oughoutthr as its argument and hire p04
; then
; p04 firstly returns its result 'oughoutthray to p03
; p03 returns its result 'oughoutthray to p02
; p02 returns its result 'oughoutthray to p01

; **********************************************************

; 13.3 Here is our first version of downup from Chapter 11. It doesn’t work because it has no base case.

; (define (downup wd)
;   (se wd (downup (bl wd)) wd))

; (downup ’toe)
; ERROR: Invalid argument to BUTLAST: ""

;Explain what goes wrong to generate that error. In particular, why does Scheme try to take the butlast of an empty word?

; answer: the procedure throws an error because it tries to `butlast` an empty word. the recursive procedure proceeds (downup 'toe)-->(downup 'to)-->(downup 't)-->(downup "") in sequence. the last recursive call tries to (se "" (downup (bl "")) ""), in which (bl "") throws an error.

; **********************************************************

; 13.4 Here is a Scheme procedure that never finishes its job:

(define (forever n)
  (if (= n 0)
      1
      (+ 1 (forever n))))

; Explain why it doesn’t give any result. (If you try to trace it, make sure you know how to make your version of Scheme stop what it’s doing and give you another prompt.)

; answer: the procedure gives no result because it doesn't reduce the argument size to the base case in each recursive call. the argument of forever never changes, so unless the argument is precisiely 0, the procedure will repeat itself forever.
