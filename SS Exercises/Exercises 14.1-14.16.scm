; Exercises 14.1-14.16

; Classify each of these problems as a pattern (every, keep, or accumulate), if possible, and then write the procedure recursively. In some cases we’ve given an example of invoking the procedure we want you to write, instead of describing it.

; 14.1
; (remove-once 'morning '(good morning good morning))
; (GOOD GOOD MORNING)

; (It’s okay if your solution removes the other MORNING instead, as long as it removes only one of them.)

; answer: keep pattern
(define (remove-once wd sent)
  (cond ((empty? sent) '())
        ((equal? wd (first sent))
         (butfirst sent))
        (else (sentence (first sent)
                        (remove-once wd (butfirst sent))))))

; **********************************************************

; 14.2
; (up ’town)
; (T TO TOW TOWN)

; answer: every pattern
(define (up wd)
  (if (empty? wd)
      '()
      (sentence (up (butlast wd)) wd)))

; **********************************************************

; 14.3
; (remdup '(ob la di ob la da))    ;; remove duplicates
; (ob la di da)

;(It's okay if your procedure returns (di ob la da) instead, as long as it removes all but one instance of each duplicated word.)

; answer: keep pattern
(define (remdup sent)
  (cond ((empty? sent) '())
        ((member? (first sent) (bf sent))
         (remdup (bf sent)))
        (else (sentence (first sent) (remdup (bf sent))))))

; **********************************************************

; 14.4
; (odds '(i lost my little girl))
; (I MY GIRL)

; answer: Initialization procedure + helper procedure
(define (odds sent)
  (odds-helper 1 1 sent))

(define (odds-helper count remain sent)
  (cond ((empty? sent) '())
        ((= remain 0) (odds-helper count count (butfirst sent)))
        (else (sentence (first sent)
                        (odds-helper count (- remain 1) (butfirst sent))))))

; **********************************************************

; 14.5 [8.7] Write a procedure letter-count that takes a sentence as its argument and returns the total number of letters in the sentence:

; (letter-count ’(fixing a hole))
; 11

; answer: accumulate pattern
(define (letter-count sent)
  (if (empty? sent)
      0
      (+ (count (first sent))
         (letter-count (butfirst sent)))))

; **********************************************************

; 14.6 Write member?.

; answer: other patterns
(define (member-v2? element sent)
  (cond ((empty? sent) #f)
        ((equal? element (first sent)) #t)
        (else (member-v2? element (butfirst sent)))))

; **********************************************************

; 14.7 Write differences, which takes a sentence of numbers as its argument and returns a sentence containing the differences between adjacent elements. (The length of the returned sentence is one less than that of the argument.)

; (differences ’(4 23 9 87 6 12))
; (19 -14 78 -81 6)

; answer: loose every pattern
(define (differences sent)
  (if (<= (count sent) 1)
      '()
      (sentence (- (first (butfirst sent)) (first sent))
                (differences (butfirst sent)))))

; **********************************************************

; 14.8 Write expand, which takes a sentence as its argument. It returns a sentence similar to the argument, except that if a number appears in the argument, then the return value contains that many copies of the following word:

; (expand '(4 calling birds 3 french hens))
; (CALLING CALLING CALLING CALLING BIRDS FRENCH FRENCH FRENCH HENS)

; (expand '(the 7 samurai))
; (THE SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI)

; answer: loose every pattern
(define (expand-v2 sent)
  (cond ((empty? sent) '())
        ((= (count sent) 1) (first sent))
        ((number? (first sent))
         (sentence (copy (first sent) (first (butfirst sent)))
                   (expand-v2 (butfirst (butfirst sent)))))
        (else (sentence (first sent)
                        (expand-v2 (butfirst sent))))))

(define (copy num wd)
  (if (= num 0)
      '()
      (sentence wd (copy (- num 1) wd))))

; **********************************************************

; 14.9 Write a procedure called location that takes two arguments, a word and a sentence. It should return a number indicating where in the sentence that word can be found. If the word isn’t in the sentence, return #f. If the word appears more than once, return the location of the first appearance.

; (location 'me '(you never give me your money))
; 4

; answer: loose accumulate pattern
(define (location wd sent)
  (cond ((empty? sent) #f)
        ((equal? wd (first sent)) 1)
        (else (+ 1 (location wd (butfirst sent))))))

; **********************************************************

; 14.10 Write the procedure count-adjacent-duplicates that takes a sentence as an argument and returns the number of words in the sentence that are immediately followed by the same word:

; (count-adjacent-duplicates ’(y a b b a d a b b a d o o))
; 3

; (count-adjacent-duplicates ’(yeah yeah yeah))
; 2

; answer: keep and accumulate combining pattern
(define (count-adjacent-duplicates sent)
  (cond ((<= (count sent) 1) 0)
        ((equal? (first sent) (first (butfirst sent)))
         (+ 1 (count-adjacent-duplicates (butfirst sent))))
        (else (count-adjacent-duplicates (butfirst sent)))))

; **********************************************************

; 14.11 Write the procedure remove-adjacent-duplicates that takes a sentence as argument and returns the same sentence but with any word that’s immediately followed by the same word removed:

; (remove-adjacent-duplicates '(y a b b a d a b b a d o o))
; (Y A B A D A B A D O)

; (remove-adjacent-duplicates '(yeah yeah yeah))
; (YEAH)

; answer: keep pattern
(define (remove-adjacent-duplicates sent)
  (cond ((empty? sent) '())
        ((= (count sent) 1) sent)
        ((equal? (first sent) (first (butfirst sent)))
         (remove-adjacent-duplicates (butfirst sent)))
        (else (sentence (first sent) (remove-adjacent-duplicates (butfirst sent))))))

; **********************************************************

; 14.12 Write a procedure progressive-squares? that takes a sentence of numbers as its argument. It should return #t if each number (other than the first) is the square of the number before it:

; (progressive-squares? ’(3 9 81 6561))
; #T

; (progressive-squares? ’(25 36 49 64))
; #F

; answer: other pattern
(define (progressive-squares? num-sent)
  (cond ((<= (count num-sent) 1) #t)
        ((= (square (first num-sent)) (first (butfirst num-sent)))
         (and #t (progressive-squares? (butfirst num-sent))))
        (else #f)))

(define (square num)
  (* num num))

; **********************************************************

; 14.13 What does the pigl procedure from Chapter 11 do if you invoke it with a word like “frzzmlpt” that has no vowels? Fix it so that it returns “frzzmlptay.”

; original pigl:
(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

; answer: other pattern
(define (pigl-general wd)
  (cond ((empty? wd) '())
        ((include-vowel? wd) (pigl wd))
        (else (word wd 'ay))))

(define (include-vowel? wd)
  (cond ((empty? wd) #f)
        ((member? (first wd) 'aeiou) #t)
        (else (include-vowel? (butfirst wd)))))

; **********************************************************

; 14.14 Write a predicate same-shape? that takes two sentences as arguments. It should return #t if two conditions are met: The two sentences must have the same number of words, and each word of the first sentence must have the same number of letters as the word in the corresponding position in the second sentence.

; (same-shape? '(the fool on the hill) '(you like me too much))
; #T

; (same-shape? '(the fool on the hill) '(and your bird can sing))
; #F

; answer: other pattern
(define (same-shape? sent-1 sent-2)
  (if (not (= (count sent-1) (count sent-2)))
      #f
      (same-shape-helper sent-1 sent-2)))

(define (same-shape-helper sent-1 sent-2)
  (cond ((empty? sent-1) #t)
        ((= (count (first sent-1)) (count (first sent-2)))
         (and #t (same-shape-helper (butfirst sent-1) (butfirst sent-2))))
        (else #f)))

; **********************************************************

; 14.15 Write merge, a procedure that takes two sentences of numbers as arguments. Each sentence must consist of numbers in increasing order. Merge should return a single sentence containing all of the numbers, in order. (We’ll use this in the next chapter as part of a sorting algorithm.)

; (merge '(4 7 18 40 99) '(3 6 9 12 24 36 50))
; (3 4 6 7 9 12 18 24 36 40 50 99)

; answer: other pattern
(define (merge sent-1 sent-2)
  (cond ((empty? sent-1) sent-2)
        ((empty? sent-2) sent-1)
        (else (merge (butfirst sent-1)
                     (merge-single (first sent-1) sent-2)))))

(define (merge-single wd sent)
  (cond ((empty? sent) wd)
        ((<= wd (first sent)) (sentence wd sent))
        ((sentence (first sent) (merge-single wd (butfirst sent))))))

; **********************************************************

; 14.16 Write a procedure syllables that takes a word as its argument and returns the number of syllables in the word, counted according to the following rule: the number of syllables is the number of vowels, except that a group of consecutive vowels counts as one. For example, in the word “soaring,” the group “oa” represents one syllable and the vowel “i” represents a second one.

; Be sure to choose test cases that expose likely failures of your procedure. For example, what if the word ends with a vowel? What if it ends with two vowels in a row? What if it has more than two consecutive vowels?

; (Of course this rule isn’t good enough. It doesn’t deal with things like silent “e”s that don’t create a syllable (“like”), consecutive vowels that don’t form a diphthong (“cooperate”), letters like “y” that are vowels only sometimes, etc. If you get bored, see whether you can teach the program to recognize some of these special cases.)

; answer: loose accumulate pattern
(define (syllables wd)
  (cond ((empty? wd) 0)
        ((= (count wd) 1) (if (if-vowel? wd)
                              1
                              0))
        ((and (if-vowel? (first wd))
              (not (if-vowel? (first (butfirst wd)))))
         (+ 1 (syllables (butfirst (butfirst wd)))))
        (else (syllables (butfirst wd)))))

(define (if-vowel? wd)
  (if (member? wd 'aeiou)
      #t
      #f))
