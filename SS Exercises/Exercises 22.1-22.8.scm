; Exercises 22.1-22.8

; -----------------------------------------------------------
(define (file-generator file-name file-length)
  (let ((outp (open-output-file file-name)))
    (input-data outp file-length)
    (close-output-port outp)
    'done))

(define (input-data outp file-length)
  (if (= file-length 0)
      (begin (show-line '(>>> input finished))
             'done)
      (let ((data (read-line)))
        (show data outp)
        (input-data outp (- file-length 1)))))
; -----------------------------------------------------------

; 22.1 Write a concatenate procedure that takes two arguments: a list of names of input files, and one name for an output file. The procedure should copy all of the input files, in order, into the output file.

; solution:

(define (concatenate files-names output-file)
  (let ((out-port (open-output-file output-file)))
    (concatenate-helper files-names out-port)
    (close-output-port out-port)
    (show-line '(>> all files are copied to the target file))
    'done))

(define (concatenate-helper files-names out-port)
  (if (null? files-names)
      #f
      (begin (copy-file (car files-names) out-port)
             (concatenate-helper (cdr files-names) out-port))))

(define (copy-file file-name out-port)
  (let ((in-port (open-input-file file-name)))
    (copy-file-helper in-port out-port)
    (close-input-port in-port)
    (show-line '(one file is copied to the target file))
    'done))

(define (copy-file-helper in-port out-port)
  (let ((data (read in-port)))
    (if (eof-object? data)
        #f
        (begin (show data out-port)
               (copy-file-helper in-port out-port)))))

; **********************************************************

; 22.2 Write a procedure to count the number of lines in a file. It should take the filename as argument and return the number.

; solution:

(define (count-lines filename)
  (let ((in-port (open-input-file filename)))
    (let ((lines (count-lines-helper in-port)))
      (close-input-port in-port)
      lines)))

(define (count-lines-helper in-port)
  (let ((data (read-line in-port)))
    (if (eof-object? data)
        0
        (+ 1 (count-lines-helper in-port)))))

; **********************************************************

; 22.3 Write a procedure to count the number of words in a file. It should take the filename as argument and return the number.

; solution:

(define (count-words filename)
  (let ((in-port (open-input-file filename)))
    (let ((words (count-words-helper in-port)))
      (close-input-port in-port)
      words)))

(define (count-words-helper in-port)
  (let ((data (read in-port)))
    (if (eof-object? data)
        0
        (+ (length data) (count-words-helper in-port)))))   ; `length` can only deal with files of sentences
                                                            ; `length` needs to be replaces with a recursice procedure to deall with files of lists

; **********************************************************

; 22.4 Write a procedure to count the number of characters in a file, including space characters. It should take the filename as argument and return the number.

; solution:

(define (count-characters filename)
  (let ((in-port (open-input-file filename)))
    (let ((characters (count-characters-helper in-port)))
      (close-input-port in-port)
      characters)))

(define (count-characters-helper in-port)
  (let ((data (read-string in-port)))
    (if (eof-object? data)
        0
        (+ (count (del-parentheses data)) (count-characters-helper in-port)))))   ; `count` can only deal with files of sentences.
                                                                                  ; `count` needs to be replaced with a recursive procedure to deal with files of lists

(define (del-parentheses wd)
  (if (equal? (first wd) "(")
      (bl (bf wd))
      wd))

; *********************************************************

; 22.5 Write a procedure that copies an input file to an output file but eliminates multiple consecutive copies of the same line. That is, if the input file contains the lines

;  John Lennon
;  Paul McCartney
;  Paul McCartney
;  George Harrison
;  Paul McCartney
;  Ringo Starr

; then the output file should contain

;  John Lennon
;  Paul McCartney
;  George Harrison
;  Paul McCartney
;  Ringo Starr

; solution:

(define (clean-duplicates input-file output-file)
  (let ((in-port (open-input-file input-file))
        (out-port (open-output-file output-file)))
    (clean-duplicates-helper in-port (read-line in-port) out-port)
    (close-output-port out-port)
    (close-input-port in-port)
    'done))

(define (clean-duplicates-helper in-port first-data out-port)
  (let ((data (read-line in-port)))
    (if (eof-object? data)
        #f
        (if (equal? first-data data)
            (clean-duplicates-helper in-port first-data out-port)
            (begin (show-line first-data out-port)
                   (clean-duplicates-helper in-port data out-port))))))

; **********************************************************

; 22.6 Write a lookup procedure that takes as arguments a filename and a word. The procedure should print (on the screen, not into another file) only those lines from the input file that include the chosen word.

; solution:

(define (lookup filename wd)
  (let ((in-port (open-input-file filename)))
    (lookup-helper in-port wd)
    (close-input-port in-port)
    'done))

(define (lookup-helper in-port wd)
  (let ((data (read in-port)))
    (if (eof-object? data)
        #f
        (if (member wd data)                  ; member procedure only deals with files of one-level lists
            (begin (show-line data)
                   (lookup-helper in-port wd))
            (lookup-helper in-port wd)))))

; **********************************************************

; 22.7 Write a page procedure that takes a filename as argument and prints the file a screenful at a time. Assume that a screen can fit 24 lines; your procedure should print 23 lines of the file and then a prompt message, and then wait for the user to enter a (probably empty) line. It should then print the most recent line from the file again (so that the user will see some overlap between screenfuls) and 22 more lines, and so on until the file ends.

; solution:

(define (page filename)
  (let ((in-port (open-input-file filename)))
    (page-helper in-port "" (read-line in-port) 23)
    (close-input-port in-port)
    'done))

(define (page-helper in-port last-line current-line line-limit)
  (let ((next-line (read-line in-port)))
    (if (eof-object? next-line)
        (begin (show-line current-line)
               #f)
        (if (= 0 line-limit)
            (begin (display '(Press Return to Continue))
                   (read-line)
                   (show-line last-line)
                   (show-line current-line)
                   (page-helper in-port current-line next-line 21))
            (begin (show-line current-line)
                   (page-helper in-port current-line next-line (- line-limit 1)))))))

; **********************************************************

; 22.8 A common operation in a database program is to join two databases, that is, to create a new database combining the information from the two given ones. There has to be some piece of information in common between the two databases. For example, suppose we have a class roster database in which each record includes a student’s name, student ID number, and computer account name, like this:

((john alec entwistle) 04397 john)
((keith moon) 09382 kmoon)
((peter townshend) 10428 pete)
((roger daltrey) 01025 roger)

; We also have a grade database in which each student’s grades are stored according to computer account name:

(john 87 90 76 68 95)
(kmoon 80 88 95 77 89)
(pete 100 92 80 65 72)
(roger 85 96 83 62 74)

; We want to create a combined database like this:

((john alec entwistle) 04397 john 87 90 76 68 95)
((keith moon) 09382 kmoon 80 88 95 77 89)
((peter townshend) 10428 pete 100 92 80 65 72)
((roger daltrey) 01025 roger 85 96 83 62 74)

; in which the information from the roster and grade databases has been combined for each account name.

; Write a program join that takes five arguments: two input filenames, two numbers indicating the position of the item within each record that should overlap between the files, and an output filename. For our example, we’d say

(join "class-roster" "grades" 3 1 "combined-file")

; In our example, both files are in alphabetical order of computer account name, the account name is a word, and the same account name never appears more than once in each file. In general, you may assume that these conditions hold for the item that the two files have in common. Your program should not assume that every item in one file also appears in the other. A line should be written in the output file only for the items that do appear in both files.

; solution:

(define (join file-a file-b overlap-index-a overlap-index-b file-ab)
  (let ((inport-a (open-input-file file-a))
        (inport-b (open-input-file file-b))
        (outport-ab (open-output-file file-ab)))
    (join-helper inport-a (read inport-a) inport-b (read inport-b) overlap-index-a overlap-index-b outport-ab)
    (close-output-port outport-ab)
    (close-input-port inport-a)
    (close-input-port inport-b)
    'done))

(define (join-helper inport-a data-a inport-b data-b overlap-index-a overlap-index-b outport-ab)
  (if (or (eof-object? data-a) (eof-object? data-b))
      #f
      (let ((overlap-a (list-ref data-a (- overlap-index-a 1)))
            (overlap-b (list-ref data-b (- overlap-index-b 1))))
        (if (before? overlap-a overlap-b)
            (join-helper inport-a (read inport-a) inport-b data-b overlap-index-a overlap-index-b outport-ab)
            (if (equal? overlap-a overlap-b)
                (begin (show (combine-overlap-lsts data-a data-b overlap-b) outport-ab)
                       (join-helper inport-a (read inport-a) inport-b (read inport-b) overlap-index-a overlap-index-b outport-ab))
                (join-helper inport-a data-a inport-b (read inport-b) overlap-index-a overlap-index-b outport-ab))))))

(define (combine-overlap-lsts lst-a lst-b overlap-b)
  (append lst-a (cut-element overlap-b lst-b)))

(define (cut-element target lst)
  (cond ((null? lst) '())
        ((equal? target (car lst)) (cdr lst))
        (else (cons (car lst) (cut-element target (cdr lst))))))
