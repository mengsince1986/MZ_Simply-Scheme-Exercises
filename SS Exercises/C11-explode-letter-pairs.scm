(define (explode wd)
  (if (<= (count wd) 1)
      (sentence wd)
      (sentence (first wd)
                (explode (butfirst wd)))))

; **********************************************************

(explode 'dynamite)
; (D Y N A M I T E)

; **********************************************************

(define (letter-pairs wd)
  (if (<= (count wd) 2)
      (sentence wd)
      (sentence (letter-pairs (butlast wd))
                (word (last (butlast wd)) (last wd)))))

; **********************************************************

(letter-pairs 'george)
; (GE EO OR RG GE)

; **********************************************************

