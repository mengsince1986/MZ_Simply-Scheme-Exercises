; ******************************************************** accept patten and sentence

; <-----> match
; <-----> accept pattern and sentence arguments
; <-----> create '() as initial known-values
; <-----> invoke match-using-known-values

(define (match pattern sent)
  (match-using-known-values pattern sent '()))

; ******************************************************** general matching

; <-----> match-using-known-values
; <-----> accept pattern, sentence and known-values as arguments

; <-----> list five general categorises for matching:
; <-----> 1. pattern is empty
; <-----> 2. first pattern is special placeholder (* & ? !)
; <-----> 3. sentence is empty
; <-----> 4. one by one non-special word matching
; <-----> 5. else

; <-----> create (if special? is invoked):
; <-----> (first pattern) as wd

; <-----> let placeholder get (first pattern)

; <-----> create (if match-special is invoked):
; <-----> (first placeholder) as howmany
; <-----> (bf placeholder) as name
; <-----> (bf pattern) as pattern-rest
; <-----> sent as sent
; <-----> known-values as knwon-values

; <-----> invoke:
; <-----> special? (if pattern is not empty)
; <-----> match-special (if first pattern is special)
; <-----> match-using-known-values (if check non-special word)

(define (match-using-known-values pattern sent known-values)
  (cond ((empty? pattern)
         (if (empty? sent) known-values 'failed))
        ((special? (first pattern))
         (let ((placeholder (first pattern)))
           (match-special (first placeholder)
                          (bf placeholder)
                          (bf pattern)
                          sent
                          known-values)))
        ((empty? sent) 'failed)
        ((equal? (first pattern) (first sent))
         (match-using-known-values (bf pattern) (bf sent) known-values))
        (else 'failed)))

; <-----> special?
; <-----> accept wd as argument
(define (special? wd)
  (member? (first wd) '(* & ? !)))

; ********************************************************************************* special pattern matching

; <-----> match-special
; <-----> accept howmany, name, pattern-rest, sent, and known-values as arguments

; <-----> list 2 categories and 4 sub-categories for matching special patterns
; <-----> 1. the same placeholder is already in the konwn-values
; <-----> 2. new place holders:
; <----->    1) ?
; <----->    2) !
; <----->    3) *
; <----->    4) &

; <-----> invoke lookup to let old-value get (lookup name known-values)
; <-----> invoke length-ok? when old-value is not 'no-value
; <-----> <-----> invoke already-known-match if length-ok? returns true
; <-----> <-----> and take old-value as value

; <-----> invoke longest-match when howmany equal to ?/!/*/&
; <-----> create:
; <----->   1. 0/1 as min
; <----->   2. #t/#f as max-one?

(define (match-special howmany name pattern-rest sent known-values)
  (let ((old-value (lookup name known-values)))
    (cond ((not (equal? old-value 'no-value))
           (if (length-ok? old-value howmany)
               (already-known-match
                 old-value pattern-rest sent known-values)
               'failed))
          ((equal? howmany '?)
           (longest-match name pattern-rest sent 0 #t known-values))
          ((equal? howmany '!)
           (longest-match name pattern-rest sent 1 #t known-values))
          ((equal? howmany '*)
           (longest-match name pattern-rest sent 0 #f known-values))
          ((equal? howmany '&)
           (longest-match name pattern-rest sent 1 #f known-values)))))


; <-----> length-ok?

(define (length-ok? value howmany)
  (cond ((empty? value) (member? howmany '(? *)))
        ((not (empty? (bf value))) (member? howmany '(* &)))
        (else #t)))

; <-----> already-known-match

(define (already-known-match value pattern-rest sent known-values)
  (let ((unmatched (chop-leading-substring value sent)))
    (if (not (equal? unmatched 'failed))
        (match-using-known-values pattern-rest unmatched known-values)
        'failed)))

; <-----> chop-leading-substring

(define (chop-leading-substring value sent)
  (cond ((empty? value) sent)
        ((empty? sent) 'failed)
        ((equal? (first value) (first sent))
         (chop-leading-substring (bf value) (bf sent)))
        (else 'failed)))

; <-----> longest-match
; <-----> accept name, pattern-rest, sent, min, max-one? and known-values as arguments

; <-----> list 2 categorises and 2 sub-categories:
; <----->   1. sentence is empty
; <----->   2. sentence is not empty
; <----->      1) max-one? is true
; <----->      2) max-one? is false

; <-----> invoke match-using-known-values when sent is empty and min=0
; <-----> invoke (add name '() known-values) to be known-values

; <-----> when max-one? is true, invoke lm-helper with
; <-----> (se (first sent)) as sent-matched
; <-----> (bf sent) as sent-unmatched

; <-----> when max-one? is false, invoke lm-helper with
; <-----> sent as sent-matched
; <-----> '() as sent-unmatched

(define (longest-match name pattern-rest sent min max-one? known-values)
  (cond ((empty? sent)
         (if (= min 0)
             (match-using-known-values pattern-rest
                                       sent
                                       (add name '() known-values))
             'failed))
        (max-one?
          (lm-helper name pattern-rest (se (first sent))
                     (bf sent) min known-values))
        (else (lm-helper name pattern-rest
                         sent '() min known-values))))

; <-----> lm-helper
; <-----> accept name, pattern-rest, sent-matched, sent-unmatched min and known-values as arguments

; <-----> if length of sent-matched is not less than min
; <-----> let tentative-result = (match-using-known-values pattern-rest sent-unmatched (add name sent-matched known-values))

; <-----> list 3 categories for matching:
; <----->   1. tentative-result is not failed
; <----->   2. sent-matched is empty
; <----->   3. tentative-result is failed but sent-matched is not empty

; <-----> invoke lm-helper with
; <-----> (bl sent-matched) as sent-matched
; <-----> (se (last sent-matched) sent-unmatched) as sent-unmatched

(define (lm-helper name pattern-rest
                   sent-matched sent-unmatched min known-values)
  (if (< (length sent-matched) min)
      'failed
      (let ((tentative-result (match-using-known-values
                                pattern-rest
                                sent-unmatched
                                (add name sent-matched known-values))))
        (cond ((not (equal? tentative-result 'failed)) tentative-result)
              ((empty? sent-matched) 'failed)
              (else (lm-helper name
                               pattern-rest
                               (bl sent-matched)
                               (se (last sent-matched) sent-unmatched)
                               min
                               known-values))))))

;;; Known values database abstract data type

(define (lookup name known-values)
  (cond ((empty? known-values) 'no-value)
        ((equal? (first known-values) name)
         (get-value (bf known-values)))
        (else (lookup name (skip-value known-values)))))

(define (get-value stuff)
  (if (equal? (first stuff) '!)
      '()
      (se (first stuff) (get-value (bf stuff)))))

(define (skip-value stuff)
  (if (equal? (first stuff) '!)
      (bf stuff)
      (skip-value (bf stuff))))

(define (add name value known-values)
  (if (empty? name)
      known-values
     (se known-values name value '!)))
