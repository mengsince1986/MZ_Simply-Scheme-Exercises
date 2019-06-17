; Exercises 20.4-20.9

; 20.4 Write a program that carries on a conversation like the following example. What the user types is in boldface.

(converse)
; Hello, I'm the computer. What's your name? Brian Harvey
; Hi, Brian. How are you? I’m fine.
; Glad to hear it.

; solution:
(define (converse)
  (display "Hello, I'm the computer. What's your name? ")
  (let ((full-name (read-line)))
    (display "Hi, ")
    (display (car full-name))
    (display ". "))
  (display "How are you? ")
  (let ((reply (read-line)))
    (show "Glad to hear it.")))

; **********************************************************

; 20.5 Our name-table procedure uses a fixed width for the column containing the last names of the people in the argument list. Suppose that instead of liking British-invasion music you are into late romantic Russian composers:

(name-table '((piotr tchaikovsky) (nicolay rimsky-korsakov)
              (sergei rachmaninov) (modest musorgsky)))

; Alternatively, perhaps you like jazz:

(name-table '((bill evans) (paul motian) (scott lefaro)))

; Modify name-table so that it figures out the longest last name in its argument list, adds two for spaces, and uses that number as the width of the first column.

;solution:

(define (name-table names)
  (name-table-process names names))

(define (name-table-process names original-names)
  (cond ((= (length names) 1)
         (name-table-output original-names (+ (count (cadar names)) 2)))
        ((> (count (cadar names)) (count (cadadr names)))
         (name-table-process (cons (car names) (cddr names)) original-names))
        (else (name-table-process (cdr names) original-names))))

(define (name-table-output names col-length)
  (if (null? names)
      'done
      (begin (display (align (cadar names) col-length))
             (show (caar names))
             (name-table-output (cdr names) col-length))))

; **********************************************************

; 20.6 The procedure ask-user isn’t robust. What happens if you type something that isn’t a number, or isn’t between 1 and 9? Modify it to check that what the user types is a number between 1 and 9. If not, it should print a message and ask the user to try again.

; solution:

(define (ask-user position letter)
  (print-position position)
  (display letter)
  (display "'s move: ")
  (let ((move (read)))
    (if (and (>= move 1) (<= move 9))
        move
        (begin
          (show "your move is illegal, please input a number between 1 and 9")
          (ask-user position letter)))))

; **********************************************************

; 20.7 Another problem with ask-user is that it allows a user to request a square that isn’t free. If the user does this, what happens? Fix ask-user to ensure that this can’t happen.

; solution:
(define (ask-user position letter)
  (newline)
  (print-position position)
  (display letter)
  (display "'s move: ")
  (let ((move (read)))
    (if (member? move (moves-filter position '(1 2 3 4 5 6 7 8 9)))
        move
        (begin
          (show "your move is illegal, please input your move again")
          (ask-user position letter)))))

(define (moves-filter position moves)
  (cond ((empty? position) moves)
        ((equal? '_ (first position))
         (cons (car moves) (moves-filter (bf position) (bf moves))))
        (else (moves-filter (bf position) (bf moves)))))

; **********************************************************

; 20.8 At the end of the game, if the computer wins or ties, you never find out which square it chose for its final move. Modify the program to correct this. (Notice that this exercise requires you to make play-ttt-helper non-functional.)

; solution:

(define (play-ttt x-strat o-strat)
  (play-ttt-helper x-strat o-strat '_________ 'x ""))

(define (play-ttt-helper x-strat o-strat position whose-turn last-move)
  (cond ((already-won? position (opponent whose-turn))
         (begin (newline)
                (print-position position)
                (display (opponent whose-turn))
                (display " wins at square ")
                (show last-move)))
        ((tie-game? position)
         (begin (newline)
                (print-position position)
                (display (opponent whose-turn))
                (display " makes a tie-game at ")
                (show last-move)))
        (else (let ((square (if (equal? whose-turn 'x)
                                (x-strat position 'x)
                                (o-strat position 'o))))
                (play-ttt-helper x-strat
                                 o-strat
                                 (add-move square whose-turn position)
                                 (opponent whose-turn)
                                 square)))))

; ---------------------------dependencies

(define (already-won? position who)
  (member? (word who who who) (find-triples position)))

(define (tie-game? position)
  (not (member? '_ position)))

(define (add-move square letter position)
  (if (= square 1)
      (word letter (bf position))
      (word (first position)
            (add-move (- square 1) letter (bf position)))))

(define (ask-user position letter)
  (newline)
  (print-position position)
  (display letter)
  (display "'s move: ")
  (let ((move (read)))
    (if (member? move (moves-filter position '(1 2 3 4 5 6 7 8 9)))
        move
        (begin
          (show "your move is illegal, please input your move again")
          (ask-user position letter)))))

(define (moves-filter position moves)
  (cond ((empty? position) moves)
        ((equal? '_ (first position))
         (cons (car moves) (moves-filter (bf position) (bf moves))))
        (else (moves-filter (bf position) (bf moves)))))

(define (print-position position)
  (print-row (subword position 1 3))
  (show "-+-+-")
  (print-row (subword position 4 6))
  (show "-+-+-")
  (print-row (subword position 7 9))
  (newline))

(define (print-row row)
  (maybe-display (first row))
  (display "|")
  (maybe-display (first (bf row)))
  (display "|")
  (maybe-display (last row))
  (newline))

(define (maybe-display letter)
  (if (not (equal? letter '_))
      (display letter)
      (display " ")))

(define (subword wd start end)
  ((repeated bf (- start 1))
   ((repeated bl (- (count wd) end))
    wd)))

(define (subword wd start end)
  (cond ((> start 1) (subword (bf wd) (- start 1) (- end 1)))
        ((< end (count wd)) (subword (bl wd) start end))
        (else wd)))

; ---------------------------

; **********************************************************

; 20.9 The way we invoke the game program isn’t very user-friendly. Write a procedure game that asks you whether you wish to play x or o , then starts a game. (By definition, x plays first.) Then write a procedure games that allows you to keep playing repeatedly.  It can ask “do you want to play again?” after each game. (Make sure that the outcome of each game is still reported, and that the user can choose whether to play x or o before each game.)

; solution:

(define (game)
  (newline)
  (show "Please choose your side: x or o?")
  (newline)
  (let ((player (read)))
    (if (member? player '(x o))
        (if (equal? player 'x)
            (play-ttt ask-user ttt)
            (play-ttt ttt ask-user))
        (begin (newline)
               (show "Well, I think you can only choose between x and o in tic-tac-toe.")
               (newline)
               (game)))))

(define (games)
  (game)
  (newline)
  (show "Do you want to play again?")
  (newline)
  (let ((answer (read)))
    (if (member? answer '(yes yeah y no nope n))
        (if (member? answer '(yes yeah y))
            (games)
            (begin (newline)
                   (show "See you.")
                   (newline)))
        (begin (newline)
               (show "What do you mean by that? I can only consider it as no")
               (newline)
               (show "See you.")
               (newline)))))

