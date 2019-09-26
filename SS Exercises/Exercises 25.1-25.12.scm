; Exercises 25.1-25.12

; 25.1 The “magic numbers” 26 and 30 (and some numbers derived from them) appear many times in the text of this program. It’s easy to imagine wanting more rows or columns.

; Create global variables total-cols and total-rows with values 26 and 30 respectively.  Then modify the spreadsheet program to refer to these variables rather than to the numbers 26 and 30 directly. When you’re done, redefine total-rows to be 40 and see if it works.

; solution: spread-ex25.scm
; * create global variables *total-cols* and *total-rows*
; * replace 30 and 29 in all the procedures with *total-rows*
; * replace 26 and 25 in all the procedures with *total-cols*

; **********************************************************

; 25.2 Suggest a way to notate columns beyond z. What procedures would have to change to accommodate this?

; solution: spread-ex25.scm

; to notate columns beyond z we can

; modify the alphabet vector, add more elements after z
(define alphabet
  '#(a b c d e f g h i j k l m n o p q r s t u v w x y z
       aa ab ac ad ae af ag ah ai aj ak al am an ao ap aq ar as at au av aw ax ay az))

; we also need to modify the following procedures in:
; 1. "Spreasheet size" section
     *total-cols* ; less than (length alphabet)
; 2. "Cell names" section
     cell-name?
     cell-name-column
     cell-name-row
; 3. "Utility" section
     letter?
; 4. "Printing the screen" section
     display-value

; **********************************************************

; 25.3 Modify the program so that the spreadsheet array is kept as a single vector of 780 elements, instead of a vector of 30 vectors of 26 vectors. What procedures do you have to change to make this work? (It shouldn’t be very many.)

; solution: spread-ex25.scm

;to make the spreadsheet array kept as a single vector of 780 elements, we need to change:

; 1. "Cells" section
     *the-spreadsheet-array*
     global-array-lookup
     init-array

; **********************************************************

; 25.4 The procedures get-function and get-command are almost identical in struc- ture; both look for an argument in an association list. They differ, however, in their handling of the situation in which the argument is not present in the list. Why?

; answer: to make the program robust, it's necessary to add error message in get-function.
; If the user input a function that's not included in *the-functions*, the program would stop and return an error by scheme itself. A specified error message would help users debug the program.
; While if the user input a command that's not included in *the-commands*, the program will still continue in `process-command` and treat the user input as a formula which will invoke `get-function`. So it's not necessary to add specified error message for `get-command`.

; **********************************************************

; 25.5 The reason we had to include the word id in each cell ID was so we would be able to distinguish a list representing a cell ID from a list of some other kind in an expression. Another way to distinguish cell IDs would be to represent them as vectors, since vectors do not otherwise appear within expressions. Change the implementation of cell IDs from three-element lists to two-element vectors:

(make-id 4 2)
; #(4 2)

; Make sure the rest of the program still works.

; solution: spread-ex25.scm
; modify the procedures in Cell IDs section

(define (make-id col row)
  (vector col row))

(define (id-column id)
  (vector-ref id 0))

(define (id-row id)
  (vector-ref id 1))

(define (id? x)
  (and (vector? x)
       (= (vector-length x) 2)))

; **********************************************************

; 25.6 The put command can be used to label a cell by using a quoted word as the “formula.” How does that work? For example, how is such a formula translated into an expression? How is that expression evaluated? What if the labeled cell has children?

; answer: When put command take a quoted word as the formula:
; 1. put command calls put-formula-in-cell with the quoted word.
; 2. put-formula-in-cell calls put-expr.
; 3. put-expr calls pin-down which translates the quoted word into expression.
; 4. pin-down takes the label as its first argument. Since (word? formula) is true, pin-down returns the quoted word back to put-expr.
; 5. put-expr:
;    * removes the labeled cell from all its former parents,
;    * sets the labeled cell's expression with the quoted word,
;    * sets the cell's parents as an empty list,
;    * invoke figure with the label cell's id
; 6. figure invokes setvalue with the label cell's id and its expression--quoted  word.
; 7. setvalue calls figure for all the children of the labeled cell.
; 8. figure sets all its children's value into '(), since all-evaluated? returns false.

; **********************************************************

; 25.7 Add commands to move the “window” of cells displayed on the screen without changing the selected cell. (There are a lot of possible user interfaces for this feature; pick anything reasonable.)

; solution:

; first addd window moving commands in *the-commands*:

(define *the-commands*
  (list (list 'p prev-row)
        (list 'n next-row)
        (list 'b prev-col)
        (list 'f next-col)
        (list 'select select)
        (list 'window-p win-p)
        (list 'window-n win-n)
        (list 'window-b win-b)
        (list 'window-f win-f)
        (list 'put put)
        (list 'load spreadsheet-load)))

; then define the matching procedure one by one.

; Window selection commands: window-f, window-b, window-n, window-p:

(define (win-p delta)
  (let ((row (id-row (screen-corner-cell-id))))
    (if (< (- row delta) 1)
        (error "Already shown the top row")
        (begin (set-corner-row! (- row delta))
               (print-screen)))))

(define (win-n delta)
  (let ((row (id-row (screen-corner-cell-id))))
    (if (> (+ row delta 19) *total-rows*)
        (error "Already shown the bottom row")
        (begin (set-corner-row! (+ row delta))
               (print-screen)))))

(define (win-b delta)
  (let ((col (id-column (screen-corner-cell-id))))
    (if (< (- col delta) 1)
        (error "Already shown the left-most column")
        (begin (set-corner-column! (- col delta))
               (print-screen)))))

(define (win-f delta)
  (let ((col (id-column (screen-corner-cell-id))))
    (if (> (+ col delta 5) *total-cols*)
        (error "Already shown the right-most column")
        (begin (set-corner-column! (+ col delta))
               (print-screen)))))

**********************************************************
; 25.8 Modify the put command so that after doing its work it prints

; 14 cells modified

; (but, of course, using the actual number of cells modified instead of 14). This number may not be the entire length of a row or column because put doesn’t change an existing formula in a cell when you ask it to set an entire row or column.

; solution: modify the PUT section as following

(define (put formula . where)
  (put-helper formula where 0))

(define (put-helper formula where modified-num)
  (cond ((null? where)
         (begin (display-status (+ 1 modified-num))
                (put-formula-in-cell formula (selection-cell-id))))
        ((cell-name? (car where))
         (begin (display-status (+ 1 modified-num))
                (put-formula-in-cell formula (cell-name->id (car where)))))
        ((number? (car where))
         (begin (display-status (if (null? formula)
                                    *total-cols*
                                    (noval-cells (car where))))
                (put-all-cells-in-row formula (car where))))
        ((letter? (car where))
         (begin (display-status (if (null? formula)
                                    *total-rows*
                                    (noval-cells (car where))))
                (put-all-cells-in-col formula (letter->number (car where)))))
        (else (error "Put it where?")))
  )

(define (display-status num)
  (newline)
  (display "status: ")
  (display num)
  (if (> num 1)
      (display " cells modified")
      (display " cell modified")))

(define (noval-cells row-or-col)   ; return the number of the cells which has no values
  (if (number? row-or-col)
      (noval-row-cells row-or-col *total-cols* 0)
      (noval-col-cells row-or-col *total-rows* 0)))

(define (noval-row-cells row total-cells noval-cell-num)
  (cond ((= total-cells 0) noval-cell-num)
        ((null? (cell-value (make-id total-cells row)))
         (noval-row-cells row (- total-cells 1) (+ noval-cell-num 1)))
        (else (noval-row-cells row (- total-cells 1) noval-cell-num))))

(define (noval-col-cells col total-cells noval-cell-num)
  (cond ((= total-cells 0) noval-cell-num)
        ((null? (cell-value (make-id (letter->number col) total-cells)))
         (noval-col-cells col (- total-cells 1) (+ noval-cell-num 1)))
        (else (noval-col-cells col (- total-cells 1) noval-cell-num))))


