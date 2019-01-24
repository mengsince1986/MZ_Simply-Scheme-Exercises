; Exercises 6.5-6.14

; Note: Writing helper procedures may be useful in solving some of these problems.

; 6.5 Write a procedure european-time to convert a time from American AM/PM notation into European 24-hour notation. Also write american-time, which does the opposite:

(european-time ’(8 am))
; 8
(european-time ’(4 pm))
; 16
(american-time 21)
; (9 PM)
(american-time 12)
; (12 PM)
(european-time ’(12 am))
; 24

; Getting noon and midnight right is tricky.

; answer:
(define (european-time usTime)
  (if (or (< (first usTime) 1) (> (first usTime) 12))
      '(wrong time)
      (cond ((= (first usTime) 12) (if (member? 'pm usTime)
                                       12
                                       24))
            ((member? 'am usTime) (first usTime))
            (else (+ (first usTime) 12)))))

(define (american-time euTime)
  (if (or (< euTime 1) (> euTime 24))
      '(wrong time)
      (cond ((< euTime 12) (sentence euTime 'am))
            ((= euTime 12) '(12 pm))
            ((< euTime 24) (sentence (- euTime 12) 'pm))
            (else '(12 am)))))

; **********************************************************

; 6.6 Write a predicate teen? that returns true if its argument is between 13 and 19.

; answer:
(define (teen? age)
  (if (or (< age 13) (> age 19))
      #f
      #t))

; **********************************************************

; 6.7 Write a procedure type-of that takes anything as its argument and returns one of the words word, sentence, number, or boolean:

(type-of ’(getting better)) ; SENTENCE
(type-of ’revolution) ; WORD
(type-of (= 3 3)) ; BOOLEAN

; (Even though numbers are words, your procedure should return number if its argument is a number.)
; Feel free to check for more specific types, such as “positive integer,” if you are so inclined.

; answer:
(define (type-of argument)
  (cond ((number? argument) 'number)
        ((word? argument) 'word)
        ((sentence? argument) 'sentence)
        ((boolean? argument) 'boolean)
        (else '(unknown type))))

; **********************************************************

; 6.8 Write a procedure indef-article that works like this:
(indef-article ’beatle)
; (A BEATLE)

(indef-article ’album)
; (AN ALBUM)

; Don’t worry about silent initial consonants like the h in hour.

; answer:
(define (indef-article noun)
  (sentence (if (member? (first noun) '(a e i o))
                'an
                'a)
            noun))

; **********************************************************

; 6.9 Sometimes you must choose the singular or the plural of a word: 1 book but 2 books. Write a procedure thismany that takes two arguments, a number and a singular noun, and combines them appropriately:

(thismany 1 ’partridge) ; (1 PARTRIDGE)
(thismany 3 ’french-hen) ; (3 FRENCH-HENS)

;answer:
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

; **********************************************************

; 6.10 Write a procedure sort2 that takes as its argument a sentence containing two numbers. It should return a sentence containing the same two numbers, but in ascending order:
(sort2 ’(5 7))
; (5 7)

(sort2 ’(7 5))
; (5 7)

; answer:
(define (sort2 twoNum)
  (if (smaller? (first twoNum) (last twoNum))
      twoNum
      (switch twoNum)))

(define (smaller? num1 num2)
  (if (< num1 num2)
      #t
      #f))

(define (switch twoNum)
  (sentence (last twoNum)
            (first twoNum)))

; **********************************************************

; 6.11 Write a predicate valid-date? that takes three numbers as arguments, representing a month, a day of the month, and a year. Your procedure should return #t if the numbers represent a valid date (e.g., it isn’t the 31st of September). February has 29 days if the year is divisible by 4, except that if the year is divisible by 100 it must also be divisible by 400.

(valid-date? 10 4 1949) ; #T

(valid-date? 20 4 1776) ; #F

(valid-date? 5 0 1992) ; #F

(valid-date? 2 29 1900) ; #F

(valid-date? 2 29 2000) ; #T

; answer:
(define (valid-date? month day year)
  (if (and (valid-year? year)
           (valid-month? month)
           (valid-day? day month year))
      #t
      #f))

(define (valid-month? month)
  (if (and (integer? month)
           (> month 0)
           (< month 13))
      #t
      #f))

(define (valid-year? year)
  (if (and (integer? year)
           (> year 0))
      #t
      #f))

(define (valid-day? day month year)
  (cond ((not (integer? day)) #f)
        ((or (< day 1) (> day 31)) #f)
        ((31-day-month? month) #t)
        ((> day 30) #f)
        ((not (= month 2)) #t)
        ((and (= month 2) (leap-year? year) (< day 30)) #t)
        ((and (= month 2) (< day 29)) #t)
        (else #f)))

(define (31-day-month? month)
  (member? month '(1 3 5 7 8 10 12)))

(define (leap-year? year)
  (cond ((not (= (remainder year 4) 0)) #f)
        ((not (= (remainder year 100) 0)) #t)
        ((not (= (remainder year 400) 0)) #f)
        (else #t)))

; **********************************************************

; 6.12 Make plural handle correctly words that end in y but have a vowel before the y, such as boy. Then teach it about words that end in x (box). What other special cases can you find?

; answer:
(define (end-with-y-without-vowel-before? noun)
  (and (equal? (last noun) 'y)
       (not (member? (last (butlast noun)) '(a e i o u)))))

(define (end-with-s-x-sh-ch? noun)
  (or (member? (last noun) '(s x))
      (and (equal? (last noun) 'h)
           (member? (last (butlast noun)) '(s c)))))

(define (plural noun)
  (cond ((end-with-y-without-vowel-before? noun)
         (word (butlast noun) 'i 'es))
        ((end-with-s-x-sh-ch? noun)
         (word noun 'es))
        (else (word noun 's))))

; **********************************************************

; 6.13 Write a better greet procedure that understands as many different kinds of names as you can think of:

(greet ’(john lennon)); (HELLO JOHN)
(greet ’(dr marie curie)); (HELLO DR CURIE)
(greet ’(dr martin luther king jr)); (HELLO DR KING)
(greet ’(queen elizabeth)); (HELLO YOUR MAJESTY)
(greet ’(david livingstone)); (DR LIVINGSTONE I PRESUME?)

; answer:
(define (greet name)
  (cond ((member? (first name) '(king queen))
         '(hello your majesty))
        ((equal? (first name) 'professor)
         (se 'hello 'professor
             (if (jr? name)
                 (last (butlast name))
                 (last name))))

        ((equal? (first name) 'dr)
         (se 'hello 'dr
             (if (jr? name)
                 (last (butlast name))
                 (last name))))

        ((famous-dr? name)
         (se 'dr
             (if (jr? name)
                 (last (butlast name))
                 (last name))
             '(I presume?)))
        (else (se 'hello
                  (first name)))))

(define (jr? name)
  (equal? (last name) 'jr))

(define (famous-dr? name)
  (member? (last name) '(freud livingstone locke carl jung)))

; **********************************************************

; 6.14 Write a procedure describe-time that takes a number of seconds as its argument and returns a more useful description of that amount of time:

(describe-time 45)
;(45 SECONDS)

(describe-time 930)
;(15.5 MINUTES)

(describe-time 30000000000)
;(9.506426344208686 CENTURIES)

;answer:
(define second 1)
(define minute 60)
(define hour 3600)
(define day 86400)
(define week 604800)
(define month 2629800)
(define year 31557600)
(define decade 315576000)
(define century 3155760000)

(define (describe-time seconds)
  (cond ((>= seconds century) (timeconverter seconds century 'century))
        ((>= seconds decade) (timeconverter seconds decade 'decade))
        ((>= seconds year) (timeconverter seconds year 'year))
        ((>= seconds month) (timeconverter seconds month 'month))
        ((>= seconds week) (timeconverter seconds week 'week))
        ((>= seconds day) (timeconverter seconds day 'day))
        ((>= seconds hour) (timeconverter seconds hour 'hour))
        ((>= seconds minute) (timeconverter seconds minute 'minute))
        ((>= seconds second) (timeconverter seconds second 'second))))

(define (timeconverter units base measure)
  (thismany (/ units base) measure))


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




