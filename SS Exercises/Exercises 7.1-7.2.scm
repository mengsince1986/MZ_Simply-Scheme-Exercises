; Exercises 7.1-7.2

; 7.1 The following procedure does some redundant computation.

(define (gertrude wd)
  (se (if
        (vowel? (first wd)) 'an 'a)
      wd
      'is
      (if (vowel? (first wd)) 'an 'a)
      wd
      'is
      (if (vowel? (first wd)) 'an 'a)
      wd))

(define (vowel? letter)
  (if (member? letter '(a e i o))
      #t
      #f))

(gertrude ’rose)
;(A ROSE IS A ROSE IS A ROSE)

(gertrude ’iguana)
;(AN IGUANA IS AN IGUANA IS AN IGUANA)

;Use let to avoid the redundant work.

; answer:
(define (gertrude wd)
  (let ((add-article (se (if (vowel? (first wd))
                             'an
                             'a)
                         wd)))
    (se add-article 'is add-article 'is add-article)))

; 7.2 Put in the missing parentheses:
(let pi 3.14159
     pie 'lemon meringue
  se 'pi is pi 'but pie is pie)
(PI IS 3.14159 BUT PIE IS LEMON MERINGUE)

; answer:
(let ((pi 3.14159)
      (pie 'lemon meringue))
  (se 'pi 'is pi 'but 'pie 'is pie))

