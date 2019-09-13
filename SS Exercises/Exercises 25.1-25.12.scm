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

; answer:
; 
