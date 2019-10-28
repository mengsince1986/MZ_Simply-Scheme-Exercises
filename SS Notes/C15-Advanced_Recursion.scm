; Chapter 15 Advanced Recursion

;; Selection Sort

;;; The argument will be any sentence; our procedure will return a sentence with the same words in alphabetical order.

;;; > (sort '(i wanna be your man))
;;; (BE I MAN WANNA YOUR)

(define (sort sent)
  (if (empty? sent)
      '()
      (se (earliest-word sent)
          (sort (remove-once (earliest-word sent) sent)))))

(define (earliest-word sent)
  (earliest-helper (first sent) (bf sent)))

(define (earliest-helper so-far rest)
  (cond ((empty? rest) so-far)
        ((before? so-far (first rest))
         (earliest-helper so-far (bf rest)))
        (else (earliest-helper (first rest) (bf rest)))))

(define (remove-once wd sent)
  (cond ((empty? rest) '())
        ((equal? wd (first sent)) (bf sent))
        (else (se (first sent) (remove-once wd (bf sent))))))

;; From-Binary

;;; We want to take a word of ones and zeros, representing a binary number, and compute the numeric value that it represents. Each binary digit (or bit ) corresponds to a power of two, just as ordinary decimal digits represent powers of ten. So the binary number 1101 represents (1 × 8) + (1 × 4) + (0 × 2) + (1 × 1) = 13. We want to be able to say

;;; > (from-binary 1101)
;;; 13

;;; low-efficient version:

(define (from-binary bits)
  (if (empty? bits)
      0
      (+ (* (first bits) (expt 2 (count (bf bits))))
         (from-binary (bf bits)))))

;;; high-effiecient version:

(define (from-binary bits)
  (if (empty? bits)
      0
      (+ (* (from-binary (bl bits)) 2)
         (last bits))))

;; Mergesort

;;; One of the fastest sorting algorithms is called mergesort, and it works like this: In order to mergesort a sentence, divide the sentence into two equal halves and recursively sort each half. Then take the two sorted subsentences and merge them together, that is, create one long sorted sentence that contains all the words of the two halves. The base case is that an empty sentence or a one-word sentence is already sorted.

(define (mergesort sent)
  (if (<= (count sent) 1)
      sent
      (merge (mergesort (one-half sent))
             (mergesort (other-half sent)))))

(define (merge left right)
  (cond ((empty? left) right)
        ((empty? right) left)
        ((before? (first left) (first right))
         (se (first left) (merge (bf left) right)))
        (else (se (first right) (merge left (bf right))))))

(define (one-halef sent)
  (if (<= (count sent) 1)
      sent
      (se (first sent) (one-half (bf (bf sent))))))

(define (other-half sent)
  (if (<= (count sent) 1)
      '()
      (se (first (bf sent)) (other-half (bf (bf sent))))))

;; Subsets

;;; We want to know all the subsets of the letters of a word—that is, words that can be formed from the original word by crossing out some (maybe zero) of the letters.

;;; For example, if we start with a short word like rat, the subsets are r, a, t, ra, rt, at, rat, and the empty word (""). As the word gets longer, the number of subsets gets bigger very quickly.


(define (prepend-every letter sent)
  (if (empty? sent)
      '()
      (se (word letter (first sent))
          (prepend-every letter (bf sent)))))

(define (subsets wd)
  (if (empty? wd)
      (se "")
      (let ((smaller (subsets (bf wd))))
        (se smaller
            (prepend-every (first wd) smaller)))))
