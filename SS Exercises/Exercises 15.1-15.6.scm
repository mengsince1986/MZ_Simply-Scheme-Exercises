; Exercises 15.1-15.6

; 15.1 Write a procedure to-binary:

; > (to-binary 9)
; 1001

; > (to-binary 23)
; 10111

; answer:
(define (to-binary num)
  (cond ((= num 0) 0)
        ((= num 1) 1)
        (else (word (to-binary (floor (/ num 2)))
                    (remainder num 2)))))

; **********************************************************

; 15.2 A “palindrome” is a sentence that reads the same backward as forward. Write a predicate palindrome? that takes a sentence as argument and decides whether it is a palindrome. For example:

; > (palindrome? '(flee to me remote elf))
; #T
; > (palindrome? '(flee to me remote control))
; #F

; Do not reverse any words or sentences in your solution.

; answer:
(define (palindrome? sent)
  (let ((sent-wd (sent-t-wd sent)))
    (cond ((<= (count sent-wd) 1) #t)
          ((equal? (first sent-wd) (last sent-wd))
           (palindrome? (butlast (butfirst sent-wd))))
          (else #f))))

(define (sent-t-wd sent)
  (cond ((empty? sent) "")
        ((= (count sent) 1) (word (first sent)))
        (else (word (first sent)
                    (sent-t-wd (butfirst (butlast sent)))
                    (last sent)))))

; **********************************************************

; 15.3 Write a procedure substrings that takes a word as its argument. It should return a sentence containing all of the substrings of the argument. A substring is a subset whose letters come consecutively in the original word. For example, the word bat is a subset, but not a substring, of brat.

; answer:
(define (substrings wd)
  (reduce-duplicate (substrings-helper wd)))

(define (substrings-helper wd)
  (if (empty? wd)
      (se "")
      (sentence (wd-reduce wd)
                (substrings-helper (butfirst wd)))))

(define (wd-reduce wd)
  (if (empty? wd)
      '()
      (sentence wd
                (wd-reduce (butlast wd)))))

(define (reduce-duplicate sent)
  (cond ((empty? sent) '())
        ((member? (first sent) (butfirst sent))
         (reduce-duplicate (butfirst sent)))
        (else (sentence (first sent)
                        (reduce-duplicate (butfirst sent))))))

; **********************************************************

; 15.4 Write a predicate procedure substring? that takes two words as arguments and returns #t if and only if the first word is a substring of the second. (See Exercise 15.3 for the definition of a substring.)

; Be careful about cases in which you encounter a “false start,” like this:

; > (substring? 'ssip 'mississippi)
; #T

; and also about subsets that don’t appear as consecutive letters in the second word:

; > (substring? 'misip 'mississippi)
; #F

; answer:
(define (substring? wd-sub wd-parent)
  (substring?-helper wd-sub wd-sub wd-parent))

(define (substring?-helper wd-sub wd-sub-temp wd-parent)
  (cond ((empty? wd-sub-temp) #t)
        ((empty? wd-parent) #f)
        ((equal-head? wd-sub-temp wd-parent)
         (and #t (substring?-helper wd-sub (butfirst wd-sub-temp) (butfirst wd-parent))))
        (else (substring?-helper wd-sub wd-sub (butfirst wd-parent)))))

(define (substring? wd-sub wd-parent)
  (cond ((< (count wd-parent) (count wd-sub)) #f)
        ((equal-head? wd-sub wd-parent) #t)
        (else (substring? wd-sub (butfirst wd-parent)))))

(define (equal-head? wd-sub wd-parent)
  (cond ((empty? wd-sub) #t)
        ((empty? wd-parent) #f)
        ((equal? (first wd-sub) (first wd-parent))
         (and #t (equal-head? (butfirst wd-sub) (butfirst wd-parent))))
        (else #f)))

; **********************************************************

; 15.5 Suppose you have a phone number, such as 223-5766, and you’d like to figure out a clever way to spell it in letters for your friends to remember. Each digit corresponds to three possible letters. For example, the digit 2 corresponds to the letters A, B, and C. Write a procedure that takes a number as argument and returns a sentence of all the possible spellings:

; > (phone-spell 2235766)
; (AADJPMM AADJPMN . . . CCFLSOO)

; (We’re not showing you all 2187 words in this sentence.) You may assume there are no zeros or ones in the number, since those don’t have letters.

; Hint: This problem has a lot in common with the subsets example.

; answer:
(define (phone-spell num)
 (let ((num-sent (num-t-sent num)))
   (phone-spell-helper num-sent)))

(define (phone-spell-helper num-sent)
  (if (empty? num-sent)
      (sentence "")
      (multi-prepend-every (first num-sent)
                           (phone-spell-helper (butfirst num-sent)))))

(define (num-t-sent num)
  (if (empty? num)
      '()
      (sentence (digit-t-letters (first num))
                (num-t-sent (butfirst num)))))

(define (digit-t-letters digit)
  (cond ((= digit 2) 'ABC)
        ((= digit 3) 'DEF)
        ((= digit 4) 'GHI)
        ((= digit 5) 'JKL)
        ((= digit 6) 'MNO)
        ((= digit 7) 'PQRS)
        ((= digit 8) 'TUV)
        ((= digit 9) 'WXYZ)
        ))

(define (multi-prepend-every multiple sent)
  (if (empty? multiple)
      '()
      (sentence (prepend-every (first multiple) sent)
                (multi-prepend-every (butfirst multiple) sent))))

(define (prepend-every letter sent)
  (if (empty? sent)
      '()
      (se (word letter (first sent))
          (prepend-every letter (bf sent)))))

; 15.6 Let’s say a gladiator kills a roach. If we want to talk about the roach, we say “the roach the gladiator killed.” But if we want to talk about the gladiator, we say “the gladiator that killed the roach.”

; People are pretty good at understanding even rather long sentences as long as they’re straightforward: “This is the farmer who kept the cock that waked the priest that married the man that kissed the maiden that milked the cow that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.” But even a short nested sentence is confusing: “This is the rat the cat the dog worried killed.” Which rat was that?

; Write a procedure unscramble that takes a nested sentence as argument and returns a straightforward sentence about the same cast of characters:

; > (unscramble '(this is the roach the gladiator killed))
; (THIS IS THE GLADIATOR THAT KILLED THE ROACH)

; > (unscramble '(this is the rat the cat the dog the boy the girl saw owned chased bit))
; (THIS IS THE GIRL THAT SAW THE BOY THAT OWNED THE DOG THAT CHASED THE CAT THAT BIT THE RAT)

; You may assume that the argument has exactly the structure of these examples, with no special cases like “that lay in the house” or “that Jack built.”

; solution:
(define (unscramble sent)
  (let ((simplified-sent (butfirst (butfirst sent))))
    (sentence '(this is)
              (unscramble-helper simplified-sent))))

(define (unscramble-helper sent)
  (if (<= (count sent) 2)
      sent
      (sentence (extract-straight-last-nv sent)
                (unscramble-helper (but-last-nv sent)))))

(define (but-last-nv sent)
  (cond ((< (count sent) 3) sent)
        ((equal? 'the (last (butlast (butlast sent))))
         (butlast (butlast (butlast sent))))
        (else (sentence (but-last-nv (butlast sent))
                        (last sent)))))

(define (extract-straight-last-nv sent)
  (cond ((< (count sent) 3) '())
        ((equal? 'the (last (butlast (butlast sent))))
         (sentence 'the (last (butlast sent)) 'that (last sent)))
        (else (extract-straight-last-nv (butlast sent)))))
