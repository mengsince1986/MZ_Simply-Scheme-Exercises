; C10 Tic-Tac-Toe

; ***************************** Find-triples: finds all the letters in all eight winning combinations.

; ************* Substitute-triple: finds all three letters corresponding to three squares.

; ******* Substitute-letter: finds the letter in a single square.
(define (substitute-letter square position)
  (if (equal? '_ (item square position))
      square
      (item square position)))

(define (substitute-triple combination position)
  (accumulate word
              (every (lambda (square)
                       (substitute-letter square position))
                     combination)))

(define (find-triples position)
  (every (lambda (comb) (substitute-triple comb position))
         '(123 456 789 147 258 369 159 357)))

; ***************************** I-can-win?

; ************* choose-win

; ******* My-pair

; **** Opponent
(define (opponent letter)
  (if (equal? letter 'x) 'o 'x))

(define (my-pair? triple me)
  (and (= (appearances me triple) 2)
       (= (appearances (opponent me) triple) 0)))

(define (choose-win winning-triples)
  (if (empty? winning-triples)
      #f
      (keep number? (first winning-triples))))

(define (i-can-win? triples me)
  (choose-win
    (keep (lambda (triple) (my-pair? triple me))
          triples)))

; ***************************** Opponent-can-win?
(define (opponent-can-win? triples me)
  (i-can-win? triples (opponent me)))

; ***************************** I-can-fork?

; ************* First-if-any

; ******* Pivots

; **** My-single?

; ** Reapeated-numbers

; * Sort-digits

; Extract-digit?
(define (extract-digit desired-digit wd)
  (keep (lambda (wd-digit) (equal? wd-digit desired-digit))
        wd))

(define (sort-digits number-word)
  (every (lambda (digit) (extract-digit digit number-word))
         '(1 2 3 4 5 6 7 8 9)))

(define (repeated-numbers sent)
  (every first
         (keep (lambda (wd) (>= (count wd) 2))
               (sort-digits (accumulate word sent)))))

(define (my-single? triple me)
  (and (= (appearances me triple) 1)
       (= (appearances (opponet me) triple) 0)))

(define (pivots triples me)
  (repeated-numbers (keep (lambda (triple) (my-single? triple me))
                          triples)))

(define (first-if-any sent)
  (if (empty? sent)
      #f
      (first sent)))

(define (i-can-fork? triples me)
  (first-if-any (pivots triples me)))

; ***************************** I-can-advance?

; ************* Best-move

; ******* Best-square

; **** Best-square-helper
(define (best-square-helper opponent-pivots pair)
  (if (member? (first pair) opponent-pivots)
      (first pair)
      (last pair)))

(define (best-square my-triple triples me)
  (best-square-helper (pivots triples (opponent me))
                      (keep number? my-triple)))

(define (best-move my-triples all-triples me)
  (if (empty? my-triples)
      #f
      (best-square (first my-triples) all-triples me)))

(define (i-can-advance? triples me)
  (best-move (keep (lambda (triple) (my-single? triple me)) triples)
             triples
             me))

; ***************************** Best-free-square

; ************* First-choice
(define (first-choice possibilities preferences)
  (first (keep (lambda (square) (member? square possibilities))
               preferences)))

(define (best-free-square triples)
  (first-choice (accumulate word triples)
                ’(5 1 3 7 9 2 4 6 8)))

; ***************************** ttt-choose
(define (ttt-choose triples me)
  (cond ((i-can-win? triples me))
        ((opponent-can-win? triples me))
        ((i-can-fork? triples me))
        ((i-can-advance? triples me))
        (else (best-free-square triples))))

; ***************************** ttt
(define (ttt position me)
  (ttt-choose (find-triples position) me))
