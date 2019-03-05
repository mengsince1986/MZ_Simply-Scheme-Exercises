; Exercises 13.5-13.6.scm

; 13.5 It may seem strange that there is one little person per invocation of a procedure, instead of just one little person per procedure. For certain problems, the person-per- procedure model would work fine. Consider, for example, this invocation of pigl:

; (pigl ’prawn)
; AWNPRAY

; Suppose there were only one pigl specialist in the computer, named Patricia. Alonzo hires Patricia and gives her the argument prawn. She sees that it doesn’t begin with a vowel, so she moves the first letter to the end, gets rawnp, and tries to pigl that. Again, it doesn’t begin with a vowel, so she moves another letter to the end and gets awnpr. That does begin with a vowel, so she adds an ay, returning awnpray to Alonzo.

; Nevertheless, this revised little-people model doesn’t always work. Show how it fails to explain what happens in the evaluation of

(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))

; (downup 'smile)

; answer: (downup 'smile) invokes 5 recursive calls ,as if it hired 5 little people p01-p05, in sequence:

; (downup 'smile)
;;  (downup 'smil)
;;;   (downup 'smi)
;;;;    (downup 'sm)
;;;;;     (downup 's)
;;;;;     '(s)
;;;;  '(sm s sm)
;;;  '(smi sm s sm smi)
;;  '(smil smi sm s sm smi smil)
; '(smile smil smi sm s sm smi smil smile)

; then the last recursive call (p05) firstly returns value '(s) to its parent call p04. In sequence, p04 returns its value '(sm s sm) to p03. The final result won't be returned until p01 gets value from p02 and returns '(smile smil smi sm s sm smi smil smile)

; unlike (pigl 'prawn), the returned value from the last recursive call of (downup 'smile) is '(s) which is not the final returned value.

; **********************************************************

; 13.6 As part of computing (factorial 6), Scheme computes (factorial 2) and gets the answer 2. After Scheme gets that answer, how does it know what to do next?

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

; answer: except the root call (factorial 6), all the following recursive calls are part of the operands in its parent call. the value returned by (factorial 2) is part of the operands of (factorial 3) -- (* 3 (factorial 2)). To evaluate a procedure , scheme firsly calculates the value of each operand and then apply the value of its procedure expression to the operands. so scheme passes the answer 2 from (factorial 2) to (factorial 3). In turn (factorial 3) will pass its answer to (factorial 4). This process keeps running until (factorial 5) passes its answer to (factorial 6).

; >(factorial 6)
; > (factorial 5)
; > >(factorial 4)
; > > (factorial 3)
; > > >(factorial 2)
; > > > (factorial 1)
; < < < 1
; < < <2
; < < 6
; < <24
; < 120
; <720


