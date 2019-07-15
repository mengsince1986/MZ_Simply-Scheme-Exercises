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

; **********************************************************

; 22.3 Write a procedure to count the number of words in a file. It should take the filename as argument and return the number.

; **********************************************************

; 22.4 Write a procedure to count the number of characters in a file, including space characters. It should take the filename as argument and return the number.
