; Exercises 8.4-8.14

; 8.4 Write a procedure choose-beatles that takes a predicate function as its argument and returns a sentence of just those Beatles ( John, Paul, George, and Ringo) that satisfy the predicate. For example:

(define (ends-vowel? wd) (vowel? (last wd)))

(define (even-count? wd) (even? (count wd)))

(choose-beatles ends-vowel?)
; (GEORGE RINGO)

(choose-beatles even-count?)
; (JOHN PAUL GEORGE)

; answer:
(define (choose-beatles who?)
  (keep who? '(John Paul George Ringo)))

; **********************************************************

; 8.5 Write a procedure transform-beatles that takes a procedure as an argument, applies it to each of the Beatles, and returns the results in a sentence:
(define (amazify name)
  (word 'the-amazing- name))

(transform-beatles amazify)
; (THE-AMAZING-JOHN THE-AMAZING-PAUL THE-AMAZING-GEORGE THE-AMAZING-RINGO)

(transform-beatles butfirst)
; (OHN AUL EORGE INGO)

; answer:
(define (transform-beatles transformer)
  (every transformer '(John Paul George Ringo)))

; **********************************************************

; 8.6 When you’re talking to someone over a noisy radio connection, you sometimes have to spell out a word in order to get the other person to understand it. But names of letters aren’t that easy to understand either, so there’s a standard code in which each letter is represented by a particular word that starts with the letter. For example, instead of “B” you say “bravo.”

; Write a procedure words that takes a word as its argument and returns a sentence of the names of the letters in the word:

(words ’cab)
; (CHARLIE ALPHA BRAVO)

; (You may make up your own names for the letters or look up the standard ones if you want.)

; Hint: Start by writing a helper procedure that figures out the name for a single letter.

; answer:
(define (words wd)
  (every letterEncode wd))

(define (letterEncode le)
  (cond ((equal? le 'a) 'alpha)
        ((equal? le 'b) 'bravo)
        ((equal? le 'c) 'charlie)
        ((equal? le 'd) 'delta)
        ((equal? le 'e) 'echo)
        ((equal? le 'f) 'foxtrot)
        ((equal? le 'g) 'golf)
        ((equal? le 'h) 'hotel)
        ((equal? le 'i) 'india)
        ((equal? le 'j) 'juliet)
        ((equal? le 'k) 'kilo)
        ((equal? le 'l) 'lima)
        ((equal? le 'm) 'mike)
        ((equal? le 'n) 'november)
        ((equal? le 'o) 'oscar)
        ((equal? le 'p) 'papa)
        ((equal? le 'q) 'quebec)
        ((equal? le 'r) 'romeo)
        ((equal? le 's) 'sierra)
        ((equal? le 't) 'tango)
        ((equal? le 'u) 'uniform)
        ((equal? le 'v) 'victor)
        ((equal? le 'w) 'whiskey)
        ((equal? le 'x) 'xray)
        ((equal? le 'y) 'yankee)
        ((equal? le 'z) 'zulu)
        (else 'invalid letter)))

; **********************************************************

; 8.7 [14.5] Write a procedure letter-count that takes a sentence as its argument and returns the total number of letters in the sentence:
(letter-count '(fixing a hole)) ; 11

;answer:
(define (letter-count sentence)
  (accumulate +
              (every count sentence)))

; **********************************************************

; 8.8 [12.5] Write an exaggerate procedure which exaggerates sentences:
(exaggerate ’(i ate 3 potstickers))
; (I ATE 6 POTSTICKERS)

(exaggerate ’(the chow fun is good here))
; (THE CHOW FUN IS GREAT HERE)

; It should double all the numbers in the sentence, and it should replace “good” with “great,” “bad” with “terrible,” and anything else you can think of.

; answer:
(define (exaggerate sentence)
  (every superlative
         (every doubleNum sentence)))

(define (doubleNum wd)
  (if (number? wd)
      (* wd 2)
      wd))

(define (superlative wd)
  (cond ((equal? wd 'good) 'great)
        ((equal? wd 'bad) 'terrible)
        (else wd)))

; **********************************************************

; 8.9 What procedure can you use as the first argument to every so that for any sentence used as the second argument, every returns that sentence?
; answer:
(define (d-nothing-every wd) wd)

; What procedure can you use as the first argument to keep so that for any sentence used as the second argument, keep returns that sentence?
; answer:
(define (d-nothing-keep wd)
  (word? wd))

; What procedure can you use as the first argument to accumulate so that for any sentence used as the second argument, accumulate returns that sentence?
; answer:
(define (d-nothing-accumulate wd1 wd2)
  (sentence wd1 wd2))

; **********************************************************

; 8.10 Write a predicate true-for-all? that takes two arguments, a predicate proce- dure and a sentence. It should return #t if the predicate argument returns true for ever y word in the sentence.
(true-for-all? even? ’(2 4 6 8))
; #T
(true-for-all? even? ’(2 6 3 4))
; #F

; anwser:
(define (true-for-all? predicate sent)
  (equal? sent
          (keep predicate sent)))

(define (true-for-some? predicate sent)
  (not (empty? (keep predicate sent))))

; **********************************************************

; 8.11 [12.6] Write a GPA procedure. It should take a sentence of grades as its argument and return the corresponding grade point average:
(gpa ’(A A+ B+ B))
; 3.67

; Hint: write a helper procedure base-grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another helper procedure grade-modifier that returns −.33, 0, or .33, depending on whether the grade has a minus, a plus, or neither.

; answer:
(define (gpa grades)
  (/ (accumulate + (every point grades))
     (count grades)))

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

; 8.12 [11.2] When you teach a class, people will get distracted if you say “um” too many times. Write a count-ums that counts the number of times “um” appears in a sentence:
(count-ums
  ’(today um we are going to um talk about functional um programming))
;3

; answer:
(define (count-ums sent)
  (count (keep um? sent)))

(define (um? wd)
  (equal? wd 'um))

; **********************************************************

; 8.13 [11.3] Write a procedure phone-unspell that takes a spelled version of a phone number, such as POPCORN, and returns the real phone number, in this case 7672676. You will need to write a helper procedure that uses an 8-way cond expression to translate a single letter into a digit.

; answer:
(define (phone-unspell phonewords)
  (every letter2num phonewords))

(define (letter2num letter)
  (cond ((member? letter '(a b c)) 2)
        ((member? letter '(d e f)) 3)
        ((member? letter '(g h i)) 4)
        ((member? letter '(j k l)) 5)
        ((member? letter '(m n o)) 6)
        ((member? letter '(p q r s)) 7)
        ((member? letter '(t u v)) 8)
        ((member? letter '(w x y z)) 9)
        (else '(invalid input))))

; **********************************************************

; 8.14 Write the procedure subword that takes three arguments: a word, a starting position number, and an ending position number. It should return the subword containing only the letters between the specified positions:

(subword ’polythene 5 8)
; THEN

; answer:
(define (subword wd startNum endNum)
  (cutHead startNum
           (cutTail endNum wd)))

(define (cutHead num wd)
  ((repeated butfirst (- num 1)) wd))

(define (cutTail num wd)
  ((repeated butlast (- (count wd) num)) wd))
