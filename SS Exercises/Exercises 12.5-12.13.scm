; Exercises 12.5-12.13

; Solve all of the following problems with recursive procedures. If you’ve read Part III, do not use any higher-order functions such as every, keep, or accumulate.

; 12.5 [8.8] Write an exaggerate procedure which exaggerates sentences:

;(exaggerate ’(i ate 3 potstickers))
;(I ATE 6 POTSTICKERS)

;(exaggerate ’(the chow fun is good here))
;(THE CHOW FUN IS GREAT HERE)

; It should double all the numbers in the sentence, and it should replace “good” with “great,” “bad” with “terrible,” and anything else you can think of.

; answer:
(define (exaggerate sent)
  (if (empty? sent)
      '()
      (sentence (exaggerate (butlast sent))
                (exaggerate-wd (last sent)))))

(define (exaggerate-wd wd)
  (cond ((number? wd) (* 2 wd))
        ((equal? 'good wd) 'great)
        ((equal? 'bad wd) 'terrible)
        (else wd)))

; **********************************************************

; 12.6 [8.11] Write a GPA procedure. It should take a sentence of grades as its argument and return the corresponding grade point average:

; (gpa ’(A A+ B+ B))
; 3.67

; Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns −.33, 0, or .33, depending on whether the grade has a minus, a plus, or neither.

; answer:
;; ---------------------------------------------------------
;; (gpa-2 '(B C))
;; (gpa-3 '(A B C))
;; the point is how to use gpa-2 to replace part of the procedure of gpa-3
;; i was stuck for a long time by tring to use the procedure of gpa-2 to repalce part of the procedure of gpa-3, as most of the examples in the last chapter. it turned out to be extremely confusing and complicated.
;; then i found the key was to take advantage of the returned value itself of gpa-2 to repalce part of the procedure of gpa-3.
;; since average = sum / length, (gpa-3 '(A B C)) = sum3 / length3 = ((gpa-2 '(B C)) * (3 - 1) + (point A)) / 3
;; ---------------------------------------------------------

(define (gpa grades)
  (let ((grades-length (count grades)))
    (if (= 1 grades-length)
        (point (first grades))
        (/ (+ (point (first grades))
              (* (- grades-length 1) (gpa (butfirst grades))))
           grades-length))))

(define (point grade)
  (+ (base-grade grade) (grade-modifier grade)))

(define (base-grade grade)
  (let ((base (first grade)))
    (cond ((equal? base 'A) 4)
          ((equal? base 'B) 3)
          ((equal? base 'C) 2)
          ((equal? base 'D) 1)
          ((equal? base 'F) 0)
          (else '(invalid grade)))))

(define (grade-modifier grade)
  (let ((modifier (last grade)))
    (cond ((equal? modifier '+) .33)
          ((equal? modifier '-) -.33)
          (else 0))))

; **********************************************************

; 12.7 Write a procedure spell-number that spells out the digits of a number:

; (spell-number 1971)
; (ONE NINE SEVEN ONE)

;Use this helper procedure:

(define (spell-digit digit)
  (item (+ 1 digit)
        '(zero one two three four five six seven eight nine)))

; answer:

(define (spell-number num)
  (if (empty? num)
      '()
      (sentence (spell-digit (first num))
                (spell-number (butfirst num)))))

; **********************************************************

; 12.8 Write a procedure numbers that takes a sentence as its argument and returns another sentence containing only the numbers in the argument:

; (numbers ’(76 trombones and 110 cornets))
; (76 110)

; answer
(define (numbers sent)
  (if (empty? sent)
      '()
      (sentence (keep-num (first sent))
                (numbers (butfirst sent)))))

(define (keep-num wd)
  (if (number? wd)
      wd
      '()))

; **********************************************************

; 12.9 Write a procedure real-words that takes a sentence as argument and returns all the “real” words of the sentence, using the same rule as the real-word? procedure from Chapter 1.

; answer:
(define (real-words sent)
  (if (empty? sent)
      '()
      (sentence (keep-real-word (first sent))
                (real-words (butfirst sent)))))

(define (keep-real-word wd)
  (if (real-word? wd)
      wd
      '()))

(define (real-word? wd)
  (not (member? wd '(a the an in of and for to with))))

; **********************************************************

; 12.10 Write a procedure remove that takes a word and a sentence as arguments and returns the same sentence, but with all copies of the given word removed:

; (remove ’the ’(the song love of the loved by the beatles))
; (SONG LOVE OF LOVED BY BEATLES)

; answer:
(define (remove wd sent)
  (if (empty? sent)
      '()
      (sentence (kill-same-wd wd (first sent))
                (remove wd (butfirst sent)))))

(define (kill-same-wd wd target)
  (if (equal? wd target)
      '()
      target))

; **********************************************************

; 12.11 Write the procedure count, which returns the number of words in a sentence or the number of letters in a word.

; answer:
(define (count-rec symbol)
  (if (empty? symbol)
      0
      (+ 1 (count (butfirst symbol)))))

; **********************************************************

; 12.12 Write a procedure arabic which converts Roman numerals into Arabic numerals:

; (arabic ’MCMLXXI)
; 1971

; (arabic ’MLXVI)
; 1066

; You will probably find the roman-value procedure from Chapter 6 helpful. Don’t forget that a letter can reduce the overall value if the letter that comes after it has a larger value, such as the C in MCM.

(define (roman-value letter)
  (cond ((equal? letter 'i) 1)
        ((equal? letter 'v) 5)
        ((equal? letter 'x) 10)
        ((equal? letter 'l) 50)
        ((equal? letter 'c) 100)
        ((equal? letter 'd) 500)
        ((equal? letter 'm) 1000)
        (else 0)))

; answer:
(define (second symbol)
  (first (butfirst symbol)))

(define (arabic roman-num)
  (cond ((empty? roman-num) 0)
        ((= (count roman-num) 1) (roman-value roman-num))
        ((< (roman-value (first roman-num)) (roman-value (second roman-num)))
         (+ (- (roman-value (second roman-num)) (roman-value (first roman-num)))
            (arabic (butfirst (butfirst roman-num)))))
        (else (+ (roman-value (first roman-num))
                 (arabic (butfirst roman-num))))))

; **********************************************************

; 12.13 Write a new version of the describe-time procedure from Exercise 6.14. Instead of returning a decimal number, it should behave like this:

; (describe-time 22222)
; (6 HOURS 10 MINUTES 22 SECONDS)

; (describe-time 4967189641)
; (1 CENTURIES 57 YEARS 20 WEEKS 6 DAYS 8 HOURS 54 MINUTES 1 SECONDS)

;Can you make the program smart about saying 1 CENTURY instead of 1 CENTURIES?

; answer:
(define (describe-time seconds)
  (if (= seconds 0)
      '()
      (sentence (integer-time seconds)
               (describe-time (- seconds (time-to-sec (integer-time seconds)))))))

(define (integer-time seconds)
  (cond ((>= seconds century) (integer-timeconverter seconds century 'century))
        ((>= seconds decade) (integer-timeconverter seconds decade 'decade))
        ((>= seconds year) (integer-timeconverter seconds year 'year))
        ((>= seconds month) (integer-timeconverter seconds month 'month))
        ((>= seconds week) (integer-timeconverter seconds week 'week))
        ((>= seconds day) (integer-timeconverter seconds day 'day))
        ((>= seconds hour) (integer-timeconverter seconds hour 'hour))
        ((>= seconds minute) (integer-timeconverter seconds minute 'minute))
        ((>= seconds second) (integer-timeconverter seconds second 'second))))

(define second 1)
(define minute 60)
(define hour 3600)
(define day 86400)
(define week 604800)
(define month 2629800)
(define year 31557600)
(define decade 315576000)
(define century 3155760000)

(define (integer-timeconverter units base measure)
  (thismany (floor (/ units base)) measure))


(define (thismany number noun)
  (sentence number (if (> number 1)
                       (if (end-with-y-without-vowel-before? noun)
                           (word (butlast noun) 'i 'es)
                           (word noun (if (end-with-s-x-sh-ch? noun)
                                          'es
                                          's)))
                       noun)))

(define (end-with-y-without-vowel-before? noun)
  (and (equal? (last noun) 'y)
       (not (member? (last (butlast noun)) '(a e i o u)))))

(define (end-with-s-x-sh-ch? noun)
  (or (member? (last noun) '(s x))
      (and (equal? (last noun) 'h)
           (member? (last (butlast noun)) '(s c)))))

(define (time-to-sec time)
  (* (first time) (base-to-sec (last time))))

(define (base-to-sec wd)
  (cond ((member? wd '(second seconds)) second)
        ((member? wd '(minute minutes)) minute)
        ((member? wd '(hour hours)) hour)
        ((member? wd '(day days)) day)
        ((member? wd '(week weeks)) week)
        ((member? wd '(month months)) month)
        ((member? wd '(year years)) year)
        ((member? wd '(decade decades)) decade)
        ((member? wd '(century centuries)) century)
        (else '(wrong time))))

