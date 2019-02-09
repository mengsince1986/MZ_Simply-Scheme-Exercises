; Project: Scoring Bridge Hands

; At the beginning of a game of bridge, each player assigns a value to his or her hand by counting points. Bridge players use these points in the first part of the game, the “bidding,” to decide how high to bid. (A bid is a promise about how well you’ll do in the rest of the game. If you succeed in meeting your bid you win, and if you don’t meet the bid, you lose.) For example, if you have fewer than six points, you generally don’t bid anything at all.

; You’re going to write a computer program to look at a bridge hand and decide how many points it’s worth. You won’t have to know anything about the rest of the game; we’ll tell you the rules for counting points.

; A bridge hand contains thirteen cards. Each ace in the hand is worth four points, each king is worth three points, each queen two points, and each jack one. The other cards, twos through tens, have no point value. So if your hand has two aces, a king, two jacks, and eight other cards, it’s worth thirteen points.

; A bridge hand might also have some “distribution” points, which are points having to do with the distribution of the thirteen cards among the four suits. If your hand has only two cards of a particular suit, then it is worth an extra point. If it has a “singleton,” only one card of a particular suit, that’s worth two extra points. A “void,” no cards in a particular suit, is worth three points.

; In our program, we’ll represent a card by a word like h5 (five of hearts) or dk (king of diamonds). A hand will be a sentence of cards, like this:

; (sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3)

; This hand is worth 14 points: ace of spades (4), plus queen of hearts (2), plus jack of hearts (1), plus king of clubs (3), plus king of diamonds (3), plus one more for having only two clubs.

; To find the suit of a card, we take its first, and to find the rank, we take the butfirst. (Why not the last?)

; We have a particular program structure in mind. We’ll describe all of the procedures you need to write; if you turn each description into a working procedure, then you should have a complete program. In writing each procedure, take advantage of the ones you’ve already written. Our descriptions are ordered bottom-up, which means that for each procedure you will already have written the helper procedures you need. (This ordering will help you write the project, but it means that we’re beginning with small details. If we were describing a project to help you understand its structure, we’d do it in top-down order, starting with the most general procedures. We’ll do that in the next chapter, in which we present a tic-tac-toe program as a larger Scheme programming example.)

; ********************************************************** Card-val

; Write a procedure card-val that takes a single card as its argument and returns the value of that card.
(card-val ’cq) ; 2
(card-val ’s7) ; 0
(card-val ’ha) ; 4

; answer:
(define (card-val card)
  (let ((card-rank (butfirst card)))
    (cond ((equal? card-rank 'a) 4)
          ((equal? card-rank 'k) 3)
          ((equal? card-rank 'q) 2)
          ((equal? card-rank 'j) 1)
          (else 0))))

; ********************************************************** High-card-points

; Write a procedure high-card-points that takes a hand as its argument and returns the total number of points from high cards in the hand. (This procedure does not count distribution points.)
(high-card-points ’(sa s10 hq ck c4)); 9
(high-card-points ’(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3)); 13

; answer:
(define (high-card-points hand)
  (accumulate (lambda (sum card-point)
                (+ sum card-point))
              (every card-val hand)))

; ********************************************************** Count-suit

; Write a procedure count-suit that takes a suit and a hand as arguments and returns the number of cards in the hand with the given suit.
;(count-suit ’s ’(sa s10 hq ck c4)) ;2
;(count-suit ’c ’(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3)); 2
;(count-suit ’d ’(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2)); 5

; answer:
(define (count-suit suit hand)
  (count (keep (lambda (card)
                 (equal? (first card) suit))
               hand)))

; ********************************************************** Suit-Counts

; Write a procedure suit-counts that takes a hand as its argument and returns a sentence containing the number of spades, the number of hearts, the number of clubs, and the number of diamonds in the hand.

(suit-counts ’(sa s10 hq ck c4))
; (2 1 2 0)

(suit-counts ’(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; (5 3 2 3)

(suit-counts ’(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; (5 1 2 5)

; answer:
(define (suit-counts hand)
  (sentence (count-suit 's hand)
            (count-suit 'h hand)
            (count-suit 'c hand)
            (count-suit 'd hand)))

; ********************************************************** Suit-dist-points

; Write suit-dist-points that takes a number as its argument, interpreting it as the number of cards in a suit. The procedure should return the number of distribution points your hand gets for having that number of cards in a particular suit.

(suit-dist-points 2); 1

(suit-dist-points 7); 0

(suit-dist-points 0); 3

; answer:
(define (suit-dist-points card-num)
  (cond ((= card-num 2) 1)
        ((= card-num 1) 2)
        ((= card-num 0) 3)
        (else 0)))

; ********************************************************** Hand-dist-points

; Write hand-dist-points, which takes a hand as its argument and returns the number of distribution points the hand is worth.

(hand-dist-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; 1

(hand-dist-points '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; 3

; answer:
(define (hand-dist-points hand)
  (accumulate
    (lambda (sum points) (+ sum points))
    (every suit-dist-points (suit-counts hand))))

; ********************************************************** Bridge-val

; Write a procedure bridge-val that takes a hand as its argument and returns the total number of points that the hand is worth.

(bridge-val '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; 14

(bridge-val '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; 8

; answer:
(define (bridge-val hand)
  (+ (high-card-points hand) (hand-dist-points hand)))

