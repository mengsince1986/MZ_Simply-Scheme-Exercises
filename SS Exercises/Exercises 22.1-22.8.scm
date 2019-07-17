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
        (+ (length data) (count-words-helper in-port)))))

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
        (+ (count (del-parentheses data)) (count-characters-helper in-port)))))

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
