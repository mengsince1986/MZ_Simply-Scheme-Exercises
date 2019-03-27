; Project: Scoring Poker Hands

; ********************************************************** Expected output

; The idea of this project is to invent a procedure poker-value that works like this:

; > (poker-value '(h4 s4 c6 s6 c4))
; (FULL HOUSE - FOURS OVER SIXES)

; > (poker-value '(h7 s3 c5 c4 d6))
; (SEVEN-HIGH STRAIGHT)

; > (poker-value '(dq d10 dj da dk))
; (ROYAL FLUSH - DIAMONDS)

; > (poker-value '(da d6 d3 c9 h6))
; (PAIR OF SIXES)

; As you can see, we are representing cards and hands just as in the Bridge project, except that poker hands have only five cards.

; ********************************************************** Poker Hands

; Here are the various kinds of poker hands, in decreasing order of value:

; • Royal flush: ten, jack, queen, king, and ace, all of the same suit
; • Straight flush: five cards of sequential rank, all of the same suit
; • Four of a kind: four cards of the same rank
; • Full house: three cards of the same rank, and two of a second rank • Flush: five cards of the same suit, not sequential rank
; • Straight: five cards of sequential rank, not all of the same suit
; • Three of a kind: three cards of the same rank, no other matches
; • Two pair: two pairs of cards, of two different ranks
; • Pair: two cards of the same rank, no other matches
; • Nothing: none of the above

; An ace can be the lowest card of a straight (ace, 2, 3, 4, 5) or the highest card of a straight (ten, jack, queen, king, ace), but a straight can’t “wrap around”; a hand with queen, king, ace, 2, 3 would be worthless (unless it’s a flush).

; ********************************************************** Hints to Structure the program

; Notice that most of the hand categories are either entirely about the ranks of the cards (pairs, straight, full house, etc.) or entirely about the suits (flush). It’s a good idea to begin your program by separating the rank information and the suit information. To check for a straight flush or royal flush, you’ll have to consider both kinds of information.

; In what form do you want the suit information? Really, all you need is a true or false value indicating whether or not the hand is a flush, because there aren’t any poker categories like “three of one suit and two of another.”

; What about ranks? There are two kinds of hand categories involving ranks: the ones about equal ranks (pairs, full house) and the ones about sequential ranks (straight). You might therefore want the rank information in two forms. A sentence containing all of the ranks in the hand, in sorted order, will make it easier to find a straight. (You still have to be careful about aces.)

; For the equal-rank categories, what you want is some data structure that will let you ask questions like “are there three cards of the same rank in this hand?” We ended up using a representation like this:

; > (compute-ranks ’(q 3 4 3 4))
; (ONE Q TWO 3 TWO 4)

; One slightly tricky aspect of this solution is that we spelled out the numbers of cards, one to four, instead of using the more obvious (1 Q 2 3 2 4). The reason, as you can probably tell just by looking at the latter version, is that it would lead to confusion between the names of the ranks, most of which are digits, and the numbers of occurrences, which are also digits. More specifically, by spelling out the numbers of occurrences, we can use member? to ask easily if there is a three-of-a-kind rank in the hand.

; You may find it easier to begin by writing a version that returns only the name of a category, such as three of a kind, and only after you get that to work, revise it to give more specific results such as three sixes.

; ********************************************************** Solution

; ********************************************************** poker-value: Compute the poker value
(define (poker-value hands)
  (cond ((if-royal-flush? hands) (royal-flush-description hands))
        ((if-straight-flush? hands) (straight-flush-description hands))
        ((if-four-of-kind? hands) (four-kind-description hands))
        ((if-full-house? hands) (full-house-description hands))
        ((if-flush? hands) (flush-description hands))
        ((if-straight? hands) (straight-description hands))
        ((if-three-of-kind? hands) (three-kind-description hands))
        ((if-two-pair? hands) (two-pair-description hands))
        ((if-pair? hands) (pair-description hands))
        (else (nothing-description hands))))

; ********************************************************** if-royal-flush?
; ********************************************************** royal-flush-description
(define (if-royal-flush? hands)
  (and (if-flush? hands)
       (equal? (sequential-ranks hands) '(10 11 12 13 14))))

(define (royal-flush-description royal-flush-hands)
  (sentence '(royal flush) '- (flush-suit royal-flush-hands)))

; ********************************************************** if-straight-flush?
; ********************************************************** straight-flush-description
(define (if-straight-flush? hands)
  (and (if-flush? hands)
       (if-straight? hands)))

(define (straight-flush-description hands)
  (sentence (spell-top-rank hands)
            '(straight flush)
            '- (flush-suit hands)))

; ********************************************************** if-four-of-kind?
; ********************************************************** four-of-kind-description
(define (if-four-of-kind? hands)
  (member? 'four (compute-ranks hands)))

(define (four-kind-description hands)
  (let ((computed-ranks (compute-ranks hands)))
    (sentence '(four of kind) '-
              (four-kind-description-helper computed-ranks))))

(define (four-kind-description-helper computed-ranks)
  (if (equal? (first computed-ranks) 'four)
      (word (spell-card-rank (first (butfirst computed-ranks))) 's)
      (four-kind-description-helper (butfirst (butfirst computed-ranks)))))

; ********************************************************** if-full-house?
; ********************************************************** full-house-description
(define (if-full-house? hands)
  (and (member? 'three (compute-ranks hands))
       (member? ' two (compute-ranks hands))))

(define (full-house-description hands)
  (let ((computed-ranks (compute-ranks hands)))
    (sentence '(full-house) '-
              (full-house-description-helper computed-ranks))))

(define (full-house-description-helper computed-ranks)
  (if (equal? (first computed-ranks) 'three)
      (sentence (word (spell-card-rank (first (butfirst computed-ranks))) 's)
                'over
                (word (spell-card-rank (last computed-ranks)) 's))
      (sentence (word (spell-card-rank (last computed-ranks)) 's)
                'over
                (word (spell-card-rank (first (butfirst computed-ranks))) 's))))

; ********************************************************** if-flush?: check if a hand is flush or not
; ********************************************************** flush-suit: return the name of the flush suit
; ********************************************************** flush-description
(define (if-flush? hands)
  (cond ((= (count hands) 1) #t)
        ((equal? (first (first hands)) (first (first (butfirst hands))))
         (and #t (if-flush? (butfirst hands))))
        (else #f)))

(define (flush-suit hands)
  (cond ((equal? 'c (first (first hands)))
         'clubs)
        ((equal? 'd (first (first hands)))
         'diamonds)
        ((equal? 'h (first (first hands)))
         'hearts)
        ((equal? 's (first (first hands)))
         'spades)
        (else 'wrong)))

(define (flush-description hands)
  (sentence '(flush) '- (flush-suit hands)))

; **********************************************************  if-straight?: check if hands are straight or not
; **************************** increment-by-1?: check if ranks value increase by 1
; ********************************************************** straight-description
(define (if-straight? hands)
  (let ((ascending-ranks (sequential-ranks hands)))
    (increment-by-1? ascending-ranks)))

(define (increment-by-1? ascending-ranks)
  (cond ((= (count ascending-ranks) 1) #t)
        ((= (+ 1 (first ascending-ranks)) (first (butfirst ascending-ranks)))
         (and #t (increment-by-1? (butfirst ascending-ranks))))
        (else #f)))

(define (straight-description hands)
  (sentence (spell-top-rank hands)
            'straight))

; ********************************************************** if-three-of-kind?
; ********************************************************** three-kind-description
(define (if-three-of-kind? hands)
  (member? 'three (compute-ranks hands)))

(define (three-kind-description hands)
  (let ((computed-ranks (compute-ranks hands)))
    (sentence '(three of kind) '-
              (three-kind-description-helper computed-ranks))))

(define (three-kind-description-helper computed-ranks)
  (if (equal? (first computed-ranks) 'three)
      (word (spell-card-rank (first (butfirst computed-ranks))) 's)
      (three-kind-description-helper (butfirst (butfirst computed-ranks)))))

; ********************************************************** if-two-pair?
; ********************************************************** two-pair-description
(define (if-two-pair? hands)
  (= (appearances 'two (compute-ranks hands)) 2))

(define (two-pair-description hands)
  (let ((two-ranks (two-pair-description-helper (compute-ranks hands))))
    (sentence '(two pair) '-
              (word (spell-card-rank (item 2 two-ranks)) 's)
              'and
              (word (spell-card-rank (item 4 two-ranks)) 's))))

(define (two-pair-description-helper computed-ranks)
  (cond ((empty? computed-ranks) '())
        ((equal? 'one (first computed-ranks))
         (two-pair-description-helper (butfirst (butfirst computed-ranks))))
        (else (sentence (first computed-ranks) (first (butfirst computed-ranks))
                        (two-pair-description-helper (butfirst (butfirst computed-ranks)))))))

; ********************************************************** if-pair?
; ********************************************************** pair-description
(define (if-pair? hands)
  (member? 'two (compute-ranks hands)))

(define (pair-description hands)
 (let ((computed-ranks (compute-ranks hands)))
   (sentence 'pair '- (pair-description-helper computed-ranks))))

(define (pair-description-helper computed-ranks)
  (if (equal? 'two (first computed-ranks))
      (word (spell-card-rank (first (butfirst computed-ranks))) 's)
      (pair-description-helper (butfirst (butfirst computed-ranks)))))

; ********************************************************** nothing-description
(define (nothing-description hands)
  (sentence 'nothing '- (spell-top-rank hands)))

; **************************** spell-top-rank: return and spell the top rank
; ************* spell-card-rank: spell the given rank
; ************* max-sent: return the top number of a sentence
(define (spell-top-rank hands)
  (let ((ascending-ranks (sequential-ranks hands)))
    (word (spell-card-rank (max-sent ascending-ranks))
          '-
          'high)))

(define (spell-card-rank rank)
  (cond ((or (equal? rank 'a) (equal? rank 1) (equal? rank 14)) 'ace)
        ((equal? rank 2) 'two)
        ((equal? rank 3) 'three)
        ((equal? rank 4) 'four)
        ((equal? rank 5) 'five)
        ((equal? rank 6) 'six)
        ((equal? rank 7) 'seven)
        ((equal? rank 8) 'eight)
        ((equal? rank 9) 'nine)
        ((equal? rank 10) 'ten)
        ((or (equal? rank 'j) (equal? rank 11)) 'jack)
        ((or (equal? rank 'q) (equal? rank 12)) 'queen)
        ((or (equal? rank 'k) (equal? rank 13)) 'king)))

(define (numural-rank rank)
  (cond ((equal? ))))

(define (max-sent num-sent)
  (if (= (count num-sent) 1)
      (first num-sent)
      (max (first num-sent)
           (max-sent (butfirst num-sent)))))


; **************************** sequential-ranks: produce sequential data structure for hands
(define (sequential-ranks hands)
  (let ((num-ranks (numural-ranks hands)))
    (mergesort num-ranks)))

; ************* mergesort: ascend numbers
(define (mergesort sent)
  (if (<= (count sent) 1)
      sent
      (merge (mergesort (one-half sent))
             (mergesort (other-half sent)))))

(define (merge left right)
  (cond ((empty? left) right)
        ((empty? right) left)
        ((< (first left) (first right))
         (se (first left) (merge (bf left) right)))
        (else (se (first right) (merge left (bf right))))))

(define (one-half sent)
  (if (<= (count sent) 1)
      sent
      (se (first sent) (one-half (bf (bf sent))))))

(define (other-half sent)
  (if (<= (count sent) 1)
      '()
      (se (first (bf sent)) (other-half (bf (bf sent))))))


; ************* numural-ranks: interpet ace j q k into numbers
; ************* replace: replace the target in one sentence with substitute
; ************* mutant-ace: change ace's value according to different situations
; ************* keep-ranks: extract the ranks from a hand
(define (numural-ranks hands)
  (mutant-ace (numural-ranks-helper (keep-ranks hands))))

(define (numural-ranks-helper ranks)
  (replace 'j 11 (replace 'q 12 (replace 'k 13 ranks))))

(define (mutant-ace ranks)
  (if (and (member? 'a ranks)
           (member? 2 ranks)
           (member? 3 ranks)
           (member? 4 ranks)
           (member? 5 ranks))
      (replace 'a 1 ranks)
      (replace 'a 14 ranks)))

(define (replace target sub sent)
  (cond ((empty? sent) '())
        ((equal? target (first sent))
         (sentence sub (replace target sub (butfirst sent))))
        (else (sentence (first sent) (replace target sub (butfirst sent))))))

(define (keep-ranks hands)
  (if (empty? hands)
      '()
      (sentence (butfirst (first hands))
                (keep-ranks (butfirst hands)))))


; ********************************************************** computed-ranks: produce equal-rank data structure for hands
; **************************** spell-numbers: spell numbers
; **************************** remove: remove all targets from a sentence
(define (compute-ranks hands)
  (let ((ranks (keep-ranks hands)))
    (compute-ranks-helper ranks)))

(define (compute-ranks-helper ranks)
  (if (empty? ranks)
      '()
      (sentence (spell-1-4 (appearances (first ranks) ranks))
                (first ranks)
                (compute-ranks-helper (remove-all (first ranks) ranks)))))

(define (spell-1-4 num)
 (cond ((= 1 num) 'one)
       ((= 2 num) 'two)
       ((= 3 num) 'three)
       ((= 4 num) 'four)
       (else 'impossible)))

(define (remove-all target sent)
  (cond ((empty? sent) '())
        ((equal? target (first sent))
         (remove-all target (butfirst sent)))
        (else (sentence (first sent)
                        (remove-all target (butfirst sent))))))

; ********************************************************** Extra Work for Hotshots

; In some versions of poker, each player gets seven cards and can choose any five of the seven to make a hand. How would it change your program if the argument were a sentence of seven cards? (For example, in five-card poker there is only one possible category for a hand, but in seven-card you have to pick the best category that can be made from your cards.) Fix your program so that it works for both five-card and seven-card hands.

; ********************************************************** Solution
; Note: The following solution only return one of the best kind hands.
; for example, the peocedure poker-7-value chooses a hand of straight over three of kind,
; but it doesn't always return the best straight combination of straight when there are more than one straight hands in the seven cards.
; to make the poker-7-value choose the best combination within on category of hands, more procedures are to be developed, like best-straight-flush?, best-four-of-kind etc.
; **********************************************************

; ********************************************************** poker-7-value: return the best hand value from the 7 cards
; **************************** poker-7-value-helper
(define (poker-7-value hands-7)
  (let ((possible-hands (cal-possible-hands hands-7)))
    (poker-value (poker-7-value-helper possible-hands))))

(define (poker-7-value-helper possible-hands)
  (if (= (count possible-hands) 1)
      (to-hand-sent (first possible-hands))
      (higher-hand (to-hand-sent (first possible-hands))
                   (poker-7-value-helper (butfirst possible-hands)))))

; **************************** higher-hand: return the higher-value hand from two hands
(define (higher-hand hand-1 hand-2)
  (if (> (hand-scores hand-1) (hand-scores hand-2))
      hand-1
      hand-2))

; **************************** hand-scores: give scores to each knid of hand
(define (hand-scores hand)
  (cond ((if-royal-flush? hand) 10)
        ((if-straight-flush? hand) 9)
        ((if-four-of-kind? hand) 8)
        ((if-full-house? hand) 7)
        ((if-flush? hand) 6)
        ((if-straight? hand) 5)
        ((if-three-of-kind? hand) 4)
        ((if-two-pair? hand) 3)
        ((if-pair? hand) 2)
        (else 1)))

; **************************** to-hand-sent: transfer hand word (s8s9has10c3) to hand sentence (s8 s9 ha s10 c3)
(define (to-hand-sent wd)
  (cond ((empty? wd) '())
        ((equal? (first (butfirst wd)) 1)
         (sentence (word (first wd) (first (butfirst wd)) (first (butfirst (butfirst wd))))
                   (to-hand-sent (butfirst (butfirst (butfirst wd))))))
        ((sentence (word (first wd) (first (butfirst wd)))
                   (to-hand-sent (butfirst (butfirst wd)))))))

; ********************************************************** cal-possible-hands: return the possible hands of 7 cards
(define (cal-possible-hands hands)
  (possible-combinations 5 hands))

; **************************** possible-combinations: return all the possible combinations (ele-num elements) in a sentence
(define (possible-combinations ele-num sent)
  (cond ((= ele-num 1) sent)
        ((empty? sent) '())
        (else (sentence (append-every-group (first sent)
                                            (possible-combinations (- ele-num 1) (butfirst sent)))
                        (possible-combinations ele-num (butfirst sent))))))

; **************************** append-every-group: append a word to every group in a sentence
(define (append-every-group wd sent)
  (if (empty? sent)
      '()
      (sentence (word wd (first sent))
                (append-every-group wd (butfirst sent)))))


; Another possible modification to the program is to allow for playing with “wild” cards. If you play with “threes wild,” it means that if there is a three in your hand you’re allowed to pretend it’s whatever card you like. For this modification, your program will require a second argument indicating which cards are wild. (When you play with wild cards, there’s the possibility of having five of a kind. This beats a straight flush.)
