;;; The databse project of Simply_Scheme with additional features completed

;;; The database ADT: a filename, list of fields and list of records

(define (make-db filename fields records)
  (vector filename fields records))

(define (db-filename db)
  (vector-ref db 0))

(define (db-set-filename! db filename)
  (vector-set! db 0 filename))

(define (db-fields db)
  (vector-ref db 1))

(define (db-set-fields! db fields)
  (vector-set! db 1 fields))

(define (db-records db)
  (vector-ref db 2))

(define (db-set-records! db records)
  (vector-set! db 2 records))


;;; Stuff about the current state

(define current-state (vector #f #t)) ; #f is the default db. #t is the default predicate for selected-records

(define (no-db?)
  (not (vector-ref current-state 0)))

(define (current-db)
  (if (no-db?)
      (error "No current database!")
      (vector-ref current-state 0)))

(define (set-current-db! db)
  (vector-set! current-state 0 db))

(define (current-fields)
  (db-fields (current-db)))

(define (current-state-predicate)
  (vector-ref current-state 1))

(define (current-selected-records)
  (let ((unfiltered-records (db-records (current-db)))
        (predicate (current-state-predicate)))
    (select-specified-records unfiltered-records predicate
                      '())))

(define (select-specified-records unfiltered-records predicate
                          selected-records)
  (cond ((null? unfiltered-records) selected-records)
        ((predicate (car unfiltered-records))
         (select-specified-records (cdr unfiltered-records) predicate
                           (cons (car unfiltered-records) selected-records)))
        (else (select-specified-records (cdr unfiltered-records) predicate
                                selected-records))))

(define (selected-db)
  (let ((db (current-db)))
    (make-db (db-filename db)
             (db-fields db)
             (current-selected-records))))

;; User commands

(define (new-db filename fields)
  (clear-current-db!)
  (set-current-db! (make-db filename fields '()))
  'created)

(define (insert)
  (let ((new-record (get-record)))
    (db-insert new-record (current-db)))
  (if (ask "Insert another? ")
      (insert)
      'inserted))

(define (db-insert record db)
  (db-set-records! db (cons record (db-records db))))

(define (get-record)
  (get-record-loop (blank-record) (current-fields)))

(define (get-record-loop record fields)
  (if (null? fields)
      record
      (begin (display "Value for ")
             (display (car fields))
             (display "--> ")
             (record-set! record (car fields) (read))
             (get-record-loop record (cdr fields)))))

;; count-db
;; Implement the count-db procedure. It should take no arguments, and it should return the number of records in the current database.

(define (count-db)
  (length (db-records (current-db))))

;; count-selected

(define (count-selected)
  (length (current-selected-records)))

;; list-db
;; Implement the list-db procedure. It should take no arguments, and it should print the current database in the format shown earlier.

(define (list-db)
  (let ((db (current-db)))
    (list-db-helper (db-fields db) (db-records db) 1)))

;; list-selected
(define (list-selected)
  (let ((db (current-db)))
    (list-db-helper (db-fields db)
                    (current-selected-records)
                    1)))

(define (list-db-helper fields records index)
  (if (null? records)
      (display "Listed ")
      (begin (display "Record ")
             (display index)
             (newline)
             (list-record (car records) fields)
             (newline)
             (list-db-helper fields (cdr records) (+ 1 index)))))

(define (list-record record fields)
  (if (null? fields)
      'done
      (let ((field (car fields)))
        (display field)
        (display ": ")
        (display (get record field))
        (newline)
        (list-record record (cdr fields)))))

;; edit-record
;; Implement edit-record, which takes a number between one and the number of records in the current database as its argument. It should allow the user to interactively edit the given record of the current database, as shown earlier.

(define (edit-record index)
  (let ((db (current-db)))
    (let ((fields (db-fields db))
          (record (list-ref (db-records db) (- index 1))))
      (list-record record fields)
      (edit-record-helper fields record)
      (newline)
      (display "Edited "))))

(define (edit-record-helper fields record)
  (newline)
  (display "Edit which field?")
  (let ((command (read)))
    (if (equal? #f command)
        'done
        (if (member command fields)
            (begin (edit-field record command)
                   (list-record record fields)
                   (edit-record-helper fields record))
            (begin (display "No such filed in this data")
                   (newline)
                   (newline)
                   (edit-record-helper fields record))))))

(define (edit-field record field)
  (display "New value for ")
  (display field)
  (display "--> ")
  (let ((new-value (read)))
    (record-set! record field new-value)))

;; save-db and load-db
;; Write save-db and load-db. Save-db should take no arguments and should save the current database into a file with the name that was given when the database was created. Make sure to save the field names as well as the information in the records.

;; load-db should take one argument, the filename of the database you want to load.  It should replace the current database with the one in the specified file. (Needless to say, it should expect files to be in the format that save-db creates.)

;; In order to save information to a file in a form that Scheme will be able to read back later, you will need to use the write procedure instead of display or show, as discussed in Chapter 22.

(define (save-db)
  (let ((db (current-db)))
    (let ((out-p (open-output-file (db-filename db))))
      (write db out-p)
      (close-output-port out-p)
      (display "current data is saved "))))

(define (load-db file-name)
  (clear-current-db!)
  (let ((in-p (open-input-file file-name)))
    (let ((db (read in-p)))
      (set-current-db! db))
    (close-input-port in-p)
    (display "Data ")
    (display file-name)
    (display " is loaded ")))

;; clear-current-db!
;; The new-db and load-db procedures change the current database. New-db creates a new, blank database, while load-db reads in an old database from a file. In both cases, the program just throws out the current database. If you forgot to save it, you could lose a lot of work.

;; Write a procedure clear-current-db! that clears the current database. If there is no current database, clear-current-db! should do nothing. Otherwise, it should ask the user whether to save the database, and if so it should call save-db.

;; Modify new-db and load-db to invoke clear-current-db!.

(define (clear-current-db!)
  (if (no-db?)
      'done
      (if (ask "Save the current database or not?")
          (begin (newline)
                 (save-db)
                 (newline))
          'done)))

;; get
;; Many of the kinds of things that you would want to do to a database involve looking up the information in a record by the field name. For example, the user might want to list only the artists and titles of the album database, or sort it by year, or list only the albums that Brian likes.

;; But this isn’t totally straightforward, since a record doesn’t contain any information about names of fields. It doesn’t make sense to ask what value the price field has in the record

;; #(SPROCKET 15 23 17 2)

;; without knowing the names of the fields of the current database and their order.

;; Write a procedure get that takes two arguments, a field name and a record, and returns the given field of the given record. It should work by looking up the field name in the list of field names of the current database.

;; > (get 'title '#((the zombies) "Odessey and Oracle" 1967 #t))
;; "Odessey and Oracle"

;; Get can be thought of as a selector for the record data type. To continue the implementation of a record ADT, write a constructor blank-record that takes no arguments and returns a record with no values in its fields. (Why doesn’t blank-record need any arguments?) Finally, write the mutator record-set! that takes three arguments: a field name, a record, and a new value for the corresponding field.

;; Modify the rest of the database program to use this ADT instead of directly manipulating the records as vectors.

(define (get record field)
  (get-with-specific-fields record field (current-fields)))

(define (get-with-specific-fields record field fields)
  (vector-ref record (field-index field fields)))

(define (blank-record)
  (blank-record-with-specific-fields (current-fields)))

(define (blank-record-with-specific-fields fields)
  (make-vector (length fields)))

(define (record-set! record field new-val)
  (record-set-with-specific-fields! record field (current-fields) new-val))

(define (record-set-with-specific-fields! record field fields new-val)
  (vector-set! record (field-index field fields) new-val))

(define (field-index field fields)
  (field-index-helper field fields 0))

(define (field-index-helper field fields index)
  (if (equal? field (car fields))
      index
      (field-index-helper field (cdr fields) (+ index 1))))

;; sort
;; Write a sort command that takes a predicate as its argument and sorts the database according to that predicate. The predicate should take two records as arguments and return #t if the first record belongs before the second one, or #f otherwise.

;; Note: Don’t invent a sorting algorithm for this problem. You can just use one of the sorting procedures from Chapter 15 and modify it slightly to sort a list of records instead of a sentence of words.

(define (sort predicate)
  (let ((db (current-db)))
    (db-set-records! db
                     (mergesort (db-records db) predicate))
    'done
    (display "sorted ")))

(define (mergesort records predicate)
  (if (<= (length records) 1)
      records
      (merge predicate
             (mergesort (one-half records) predicate)
             (mergesort (other-half records) predicate))))

(define (merge predicate left right)
  (cond ((null? left) right)
        ((null? right) left)
        ((predicate (car left) (car right))
         (cons (car left) (merge predicate (cdr left) right)))
        (else (cons (car right) (merge predicate
                                       left (cdr right))))))

(define (one-half records)
  (if (<= (length records) 1)
      records
      (cons (car records) (one-half (cddr records)))))

(define (other-half records)
  (if (<= (length records) 1)
      '()
      (cons (car (cdr records)) (other-half (cddr records)))))

;; Sort-on-by

;;; Although sort is a very general-purpose tool, the way that you have to specify how to sort the database is cumbersome. Write a procedure sort-on-by that takes two arguments, the name of a field and a predicate. It should invoke sort with an appropriate predicate to achieve the desired sort. For example, you could say

;;; (sort-on-by 'title before?)

;;; and

;;; (sort-on-by 'year <)

;;; instead of the two sort examples we showed earlier.

(define (sort-on-by field predicate)
  (sort (lambda (r1 r2) (predicate (get r1 field) (get r2 field)))))

;; Generic-before?

;;; The next improvement is to eliminate the need to specify a predicate explicitly. Write a procedure generic-before? that takes two arguments of any types and returns #t if the first comes before the second. The meaning of “before” depends on the types of the arguments.

(define (generic-before? arg-1 arg-2)
  (cond ((and (number? arg-1) (number? arg-2))
         (< arg-1 arg-2))
        ((and (word? arg-1) (word? arg-2))
         (before? arg-1 arg-2))
        ((and (list? arg-1) (list? arg-2))
         (list-before? arg-1 arg-2))
        ((or (and (word? arg-1) (list? arg-2))
             (and (list? arg-1) (word? arg-2)))
         (generic-before? (to-list arg-1) (to-list-arg-2)))
        (else (error "generic-before? doesn't understand the type of arguments"))))

(define (list-before? lst-1 lst-2)
  (cond ((null? lst-1) #t)
        ((null? lst-2) #f)
        ((and (list? (car lst-1)) (list? (car lst-2))) ; this cond deals with substructed lists
         (let ((sub-lst-1 (car lst-1)) ; the substructed lists should be symmetric
               (sub-lst-2 (car lst-2)))
           (if (list-before? sub-lst-1 sub-lst-2)
               #t
               (if (list-before? sub-lst-2 sub-lst-1)
                   #f
                   (list-before? (cdr lst-1) (cdr lst-2))))))
        ((before? (car lst-1) (car lst-2)) #t)
        ((before? (car lst-2) (car lst-1)) #f)
        (else (list-before? (cdr lst-1) (cdr lst-2)))))

;; Sort-on

;;; Now write sort-on , which takes the name of a field as its argument and sorts the current database on that field, using generic- before? as the comparison predicate.

(define (sort-on field)
  (sort-on-by field generic-before?))

;; Add-field

;;; Sometimes you discover that you don’t have enough fields in your database. Write a procedure add-field that takes two arguments: the name of a new field and an initial value for that field. Add-field should modify the current database to include the new field. Any existing records in the database should be given the indicated initial value for the field.

;;; If you like, you can write add-field so that it will accept either one or two arguments. If given only one argument, it should use #f as the default field value.

;;; solution:

;;; Modify the related record ADT procedures get, record-set! and blank-record

(define (add-field new-field . initial)
  (if (null? initial)
      (add-field-helper new-field #f)
      (add-field-helper new-field (car initial))))

(define (add-field-helper new-field initial)
  (let ((db (current-db))
        (current-fields (current-fields)))
    (let ((new-fields (cons new-field current-fields)))
      (db-set-records! db
                       (recreate-records '()
                                         (cons new-field current-fields)
                                         current-fields
                                         new-field
                                         initial
                                         (count-db)))
      (db-set-fields! db new-fields)
      (display "field ")
      (display new-field)
      (display " is added to the current records"))))

(define (recreate-records new-records
                          new-fields current-fields
                          new-field new-field-initial
                          index)
  (if (< index 1)
      new-records
      (recreate-records (cons (recreate-record (blank-record-with-specific-fields new-fields)
                                               new-fields current-fields
                                               new-field new-field-initial
                                               index)
                              new-records)
                        new-fields current-fields
                        new-field new-field-initial
                        (- index 1))))

(define (recreate-record new-record
                         new-fields current-fields
                         new-field new-field-initial
                         index)
  (record-set-with-specific-fields! new-record
                                    new-field new-fields
                                    new-field-initial)
  (append-current-fields new-record
                         new-fields current-fields
                         index)
  new-record)

(define (append-current-fields new-record
                               new-fields current-fields
                               index)
  (let ((current-record (list-ref (db-records (current-db)) (- index 1))))
    (append-current-field current-record new-record
                          current-fields current-fields
                          new-fields)))

(define (append-current-field current-record new-record
                              current-fields fields-to-cp
                              new-fields)
  (if (null? fields-to-cp)
      'done
      (begin (let ((current-field (car fields-to-cp)))
               (record-set-with-specific-fields! new-record
                                                 current-field new-fields
                                                 (get-with-specific-fields current-record
                                                                           current-field
                                                                           current-fields)))
             (append-current-field current-record new-record
                                   current-fields (cdr fields-to-cp)
                                   new-fields))))

;; Select-by

;;; Change the current-state vector to have another element: a selection predicate. This predicate takes a record as its argument and returns whether or not to include this record in the restricted database. Also write count-selected and list-selected, which are just like count-db and list-db but include only those records that satisfy the predicate. The initial predicate should include all records.

;;; You can’t just throw away the records that aren’t selected. You have to keep them in memory somehow, but make them invisible to count-selected and list-selected.  The way to do that is to create another selector, current-selected-records, that returns a list of the selected records of the current database.

(define (select-by predicate)
  (vector-set! current-state 1 predicate)
  (display "Selected "))

;; Save-selection

;;; Write a save-selection procedure that’s similar to save-db but saves only the currently selected records. It should take a file name as its argument.

(define (save-selection file-name)
  (let ((out-p (open-output-file file-name)))
    (write (selected-db) out-p)
    (close-output-port out-p)
    (display "data is saved with selected records ")))

;;; Utilities

(define (ask question)
  (display question)
  (let ((answer (read)))
    (cond ((equal? (first answer) 'y) #t)
          ((equal? (first answer) 'n) #f)
          (else (show "Please type Y or N.")
                (ask question)))))

