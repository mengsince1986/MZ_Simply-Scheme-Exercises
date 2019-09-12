; Exercises 25.1-25.12

; 25.1 The “magic numbers” 26 and 30 (and some numbers derived from them) appear many times in the text of this program. It’s easy to imagine wanting more rows or columns.

; Create global variables total-cols and total-rows with values 26 and 30 respectively.  Then modify the spreadsheet program to refer to these variables rather than to the numbers 26 and 30 directly. When you’re done, redefine total-rows to be 40 and see if it works.

; solution: spread-ex25.scm
; * create global variables *total-cols* and *total-rows*
; * replace 30 and 29 in all the procedures with *total-rows*
; * replace 26 and 25 in all the procedures with *total-cols*

; **********************************************************

; 25.2 Suggest a way to notate columns beyond z. What procedures would have to change to accommodate this?

; answer: to notate columns beyond z we can
; * modify the alphabet vector, add more elements after z
 (define alphabet
   '#(a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac ad ae))

; * we also need to modify the following procedures in:
;   1. "Spreasheet size" section
       *total-cols* ; less than (length alphabet)
;   1. "Cell names" section
       cell-name?
       cell-name-column
       cell-name-row
;   2. "Utility" section
       letter?
;   3. "Printing the screen" section
       display-value

; **********************************************************

