; Chapter 15 Advanced Recursion

; **********************************************************
; * Sort (Selection Sort)
; * From-Binary
; * Mergesort
; * Subsets
; **********************************************************

; Example: Sort

; First we’ll consider the example of sorting a sentence. The argument will be any sentence; our procedure will return a sentence with the same words in alphabetical order.

(sort '(i wanna be your man))
; (BE I MAN WANNA YOUR)

; use the before? primitive to decide if one word comes before another word alphabetically:

(before? 'starr 'best)
; #F

; How are we going to think about this problem recursively? Suppose that we’re given a sentence to sort. A relatively easy subproblem is to find the word that ought to come first in the sorted sentence; we’ll write earliest-word later to do this.

; Once we’ve found that word, we just need to put it in front of the sorted version of the rest of the sentence. This is our leap of faith: We’re going to assume that we can already sort this smaller sentence.

; The algorithm we’ve described is called selection sort.

; Another subproblem is to find the “rest of the sentence”—all the words except for the earliest. But in Exercise 14.1 you wrote a function remove-once that takes a word and a sentence and returns the sentence with that word removed. (We don’t want to use remove, which removes all copies of the word, because our argument sentence might include the same word twice.)

(define (remove-once wd sent)
  (cond ((empty? sent) '())
        ((equal? wd (first sent)) (bf sent))
        (else (se (first sent) (remove-once wd (bf sent))))))

; Let’s say in Scheme what we’ve figured out so far:

(define (sort sent)                    ;; unfinished
  (se (earliest-word sent)
      (sort (remove-once (earliest-word sent) sent))))

; We need to add a base case. The smallest sentence is (), which is already sorted.

(define (sort sent)
  (if (empty? sent)
      '()
      (se (earliest-word sent)
          (sort (remove-once (earliest-word sent) sent)))))

; We have one unfinished task: finding the earliest word of the argument.

(define (earliest-word sent)
  (earliest-helper (first sent) (bf sent)))

(define (earliest-helper so-far rest)
  (cond ((empty? rest) so-far)
        ((before? so-far (first rest))
         (earliest-helper so-far (bf rest)))
        (else (earliest-helper (first rest) (bf rest)))))

; If you’ve read Part III, you might instead want to use accumulate for this purpose:

(define (earliest-word sent)
  (accumulate (lambda (wd1 wd2) (if (before? wd1 wd2) wd1 wd2))
              sent))

; **********************************************************

; Example: From-Binary

; We want to take a word of ones and zeros, representing a binary number, and compute the numeric value that it represents. Each binary digit (or bit) corresponds to a power of two, just as ordinary decimal digits represent powers of ten. So the binary number 1101 represents

; (1×8)+(1×4)+(0×2)+(1×1)=13

(from-binary 1101)
; 13

(from-binary 111)
; 7

; Where is the smaller, similar subproblem? Probably the most obvious thing to try is our usual trick of dividing the argument into its first and its butfirst. Suppose we divide the binary number 1101 that way. We make the leap of faith by assuming that we can translate the butfirst, 101, into its binary value 5. What do we have to add for the leftmost 1? It contributes 8 to the total, because it’s three bits away from the right end of the number, so it must be multiplied by 23. We could write this idea as follows:

(define (from-binary bits)                      ;; incomplete
  (+ (* (first bits) (expt 2 (count (bf bits))))
     (from-binary (bf bits))))

; That is, we multiply the first bit by a power of two depending on the number of bits remaining, then we add that to the result of the recursive call.

; As usual, we have written the algorithm for the recursive case before figuring out the base case. But it’s pretty easy; a number with no bits (an empty word) has the value zero.

(define (from-binary bits)
  (if (empty? bits)
      0
      (+ (* (first bits) (expt 2 (count (bf bits))))
         (from-binary (bf bits)))))

; Although this procedure is correct, it’s worth noting that a more efficient version can be written by dissecting the number from right to left. As you’ll see, we can then avoid the calls to expt, which are expensive because we have to do more multiplication than should be necessary.

; Suppose we want to find the value of the binary number 1101. The butlast of this number, 110, has the value six. To get the value of the entire number, we double the six (because 1100 would have the value 12, just as in ordinary decimal numbers 430 is ten times 43) and then add the rightmost bit to get 13. Here’s the new version:

(define (from-binary bits)
  (if (empty? bits)
      0
      (+ (* (from-binary (bl bits)) 2)
         (last bits))))

; This version may look a little unusual. We usually combine the value returned by the recursive call with some function of the current element. This time, we are combining the current element itself with a function of the recursive return value. You may want to trace this procedure to see how the intermediate return values contribute to the final result.

; **********************************************************

; Example: Mergesort

; Let’s go back to the problem of sorting a sentence. It turns out that sorting one element at a time, as in selection sort, isn’t the fastest possible approach.

; One of the fastest sorting algorithms is called mergesort, and it works like this: In order to mergesort a sentence, divide the sentence into two equal halves and recursively sort each half. Then take the two sorted subsentences and merge them together, that is, create one long sorted sentence that contains all the words of the two halves. The base case is that an empty sentence or a one-word sentence is already sorted.

(define (mergesort sent)
  (if (<= (count sent) 1)
      sent
      (merge (mergesort (one-half sent))
             (mergesort (other-half sent)))))

; The leap of faith here is the idea that we can magically mergesort the halves of the sentence. If you try to trace this through step by step, or wonder exactly what happens at what time, then this algorithm may be very confusing. But if you just believe that the recursive calls will do exactly the right thing, then it’s much easier to understand this program. The key point is that if the two smaller pieces have already been sorted, it’s pretty easy to merge them while keeping the result in order.

; We still need some helper procedures. You wrote merge in Exercise 14.15. It uses the following technique: Compare the first words of the two sentences. Let’s say the first word of the sentence on the left is smaller. Then the first word of the return value is the first word of the sentence on the left. The rest of the return value comes from recursively merging the butfirst of the left sentence with the entire right sentence. (It’s precisely the opposite of this if the first word of the other sentence is smaller.)

(define (merge left right)
  (cond ((empty? left) right)
        ((empty? right) left)
        ((before? (first left) (first right))
         (se (first left) (merge (bf left) right)))
        (else (se (first right) (merge left (bf right))))))

; Now we have to write one-half and other-half. One of the easiest ways to do this is to have one-half return the elements in odd-numbered positions, and have other-half return the elements in even-numbered positions. These are the same as the procedures odds (from Exercise 14.4) and evens (from Chapter 12).

(define (one-half sent)
  (if (<= (count sent) 1)
      sent
      (se (first sent) (one-half (bf (bf sent))))))

(define (other-half sent)
  (if (<= (count sent) 1)
      '()
      (se (first (bf sent)) (other-half (bf (bf sent))))))

; **********************************************************

; Example: Subsets

; We want to know all the subsets of the letters of a word—that is, words that can be formed from the original word by crossing out some (maybe zero) of the letters. For example, if we start with a short word like rat, the subsets are

; r, a, t, ra, rt, at, rat, and the empty word ("").

; As the word gets longer, the number of subsets gets bigger very quickly.

; As with many problems about words, we’ll try assuming that we can find the subsets of the butfirst of our word. In other words, we’re hoping to find a solution that will include an expression like

; (subsets (bf wd))

; Let’s actually take a four-letter word and look at its subsets. We’ll pick brat, because we already know the subsets of its butfirst. Here are the subsets of brat:

; "" b r a t br ba bt ra rt at bra brt bat rat brat

; You might notice that many of these subsets are also subsets of rat. In fact, if you think about it, all of the subsets of rat are also subsets of brat. So the words in (subsets ’rat) are some of the words we need for (subsets ’brat).

; Let’s separate those out and look at the ones left over:

; ratsubsets: "" r  a  t  ra  rt  at  rat
; others:     b  br ba bt bra brt bat brat

; Right about now you’re probably thinking, “They’ve pulled a rabbit out of a hat, the way my math teacher always does.” The words that aren’t subsets of rat all start with b, followed by something that is a subset of rat. You may be thinking that you never would have thought of that yourself. But we’re just following the method: Look at the smaller case and see how it fits into the original problem. It’s not so different from what happened with downup.

; Now all we have to do is figure out how to say in Scheme, “Put a b in front of every word in this sentence.” This is a straightforward example of the every pattern:

(define (prepend-every letter sent)
  (if (empty? sent)
      '()
      (se (word letter (first sent))
          (prepend-every letter (bf sent)))))

; The way we’ll use this in (subsets ’brat) is

; (prepend-every 'b (subsets 'rat))

; Of course in the general case we won’t have b and rat in our program, but instead will refer to the formal parameter:

(define (subsets wd)                          ;; first version
  (se (subsets (bf wd))
      (prepend-every (first wd) (subsets (bf wd)))))

; We still need a base case. By now you’re accustomed to the idea of using an empty word as the base case. It may be strange to think of the empty word as a set in the first place, let alone to try to find its subsets. But a set of zero elements is a perfectly good set, and it’s the smallest one possible.

; The empty set has only one subset, the empty set itself. What should subsets of the empty word return? It’s easy to make a mistake here and return the empty word itself. But we want subsets to return a sentence, containing all the subsets, and we should stick with returning a sentence even in the simple case. (This mistake would come from not thinking about the range of our function, which is sentences. This is why we put so much effort into learning about domains and ranges in Chapter 2.) So we’ll return a sentence containing one (empty) word to represent the one subset.

(define (subsets wd)                         ;; second version
  (if (empty? wd)
      (se "")
      (se (subsets (bf wd))
          (prepend-every (first wd) (subsets (bf wd))))))

; This program is entirely correct. Because it uses two identical recursive calls, however, it’s a lot slower than necessar y. We can use let to do the recursive subproblem only once:

; How come we’re worrying about efficiency all of a sudden? We really did pull this out of a hat. The thing is, it’s a lot slower without the let. Adding one letter to the length of a word doubles the time required to find its subsets; adding 10 letters multiplies the time by about 1000.

(define (subsets wd)
  (if (empty? wd)
      (se "")
      (let ((smaller (subsets (bf wd))))
        (se smaller
            (prepend-every (first wd) smaller)))))
