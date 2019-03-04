; Exercises 10.1-10.4

; 10.1 The ttt procedure assumes that nobody has won the game yet. What happens if you invoke ttt with a board position in which some player has already won? Try to figure it out by looking through the program before you run it.

; answer: the ttt procedure would continue going through the existing conditions and excucate the corresponding results, and return an error messsage -no argument for `first`- unitl all the sqaures are occupied by the players.

; A complete tic-tac-toe program would need to stop when one of the two players wins. Write a predicate already-won? that takes a board position and a letter (x or o) as its arguments and returns #t if that player has already won.

; answer:
(define (already-won? position me)
  (member? (word me me me) (find-triples position)))
; **********************************************************

; 10.2 The program also doesn’t notice when the game has ended in a tie, that is, when all nine squares are already filled. What happens now if you ask it to move in this situation?

; answer:the ttt procedure would return an error messsage -no argument for `first`.

;Write a procedure tie-game? that returns #t in this case.

; answer:
(define (tie-game-full? position)
  (not (member? '_ position)))
; **********************************************************

; 10.3 A real human playing tic-tac-toe would look at a board like this:

; [image]('oxooxxxo9)

;and notice that it’s a tie, rather than moving in square 9. Modify tie-game? from Exercise 10.2 to notice this situation and return #t.

;(Can you improve the program’s ability to recognize ties even further? What about boards with two free squares?)

; answer:
(define (tie-game-oneFreeSquare? position me)
  (and (= (appearances '_ position) 1)
       (not (i-can-win? (find-triples position) me))))

(define (tie-game-twoFreeSquares? position me)
  (and (= (appearances '_ position) 2)
       (not (i-can-win? (find-triples position) me))
       (not (i-can-win? (find-triples position) (opponent me)))))



(define (tie-game? position me)
  (cond ((= (appearances '_ position) 2)
         (and (not (i-can-win? (find-triples position) me))
              (not (i-can-win? (find-triples position) (opponent me)))))
        ((= (appearances '_ position) 1)
         (not (i-can-win? (find-triples position) me)))
        (else #f)))

;; test cases for the tied games
(tie-game? 'oxoox_xo_ 'x)  ;t  ;; test if two empty spots will lead to a tie
(tie-game? 'oxooxoxo_ 'x)  ;t  ;; test if a tie if there are two 'o shapes on a triple and one space
(tie-game? 'oxxoxo_o_ 'x)  ;f  ;; test if a tie if there are two 'o and two 'x shapes on two triple and two spaces
(tie-game? 'ox_xox_ox 'o)  ;f  ;; test if a tie if there are two 'x shapes on a triple and two spaces

; **********************************************************

; 10.4 Here are some possible changes to the rules of tic-tac-toe:
; • What if you could win a game by having three squares forming an L shape in a corner, such as squares 1, 2, and 4?
; • What if the diagonals didn’t win?
; • What if you could win by having four squares in a corner, such as 1, 2, 4, and 5?

; Answer the following questions for each of these modifications separately: What would happen if we tried to implement the change merely by changing the quoted sentence of potential winning combinations in find-triples? Would the program successfully follow the rules as modified?

; answer:
; Changing the quoted sentence of potential winning combinations for L shape winning rule would not interrupt the program.
; Changing the quoted sentence of potential winning combinations for no diagonals winning rule would not interrupt the program.
; Changing the quoted sentence of potential winning combinations for square winning rule would interrupt the program, because `i-can-win?`, `opponent-can-win?` `i-can-fork?` and `i-can-advance?` couldn't work on four-element triples.

; **********************************************************

; 10.5 Modify ttt to play chess.

