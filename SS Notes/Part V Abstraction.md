---
title: "Part V Abstraction"
---

**What are the two kinds of abstraction specified in this part?**

- data abstraction
- the implementation of higher-order functions

## Chapter 17 Lists

**How to use list to define an icecream menu?**

```scheme
(vanilla (ultra chocolate) (heath bar crunch) ginger (cherry garcia))
```

This is meant to represent five flavors, two of which are named by single words, and the other three of which are named by sentences.

The data structure we’re using in this example is called a **_list_**.

**What are the differnces between a sentence and a list?**

|                |      lists       |      sentences       |
|----------------|:----------------:|:--------------------:|
| **elements**   |     anything     |        words         |
| **definition** | sefl-referential | non-self-referential |

A list that’s an element of another list is called a **_sublist_**. We’ll use the name **_structured_** list for a list that includes sublists.

**How to use lists in pattern matcher?**

We used list structure to hold known-values databases, such as

```scheme
((FRONT (YOUR MOTHER)) (BACK (SHOULD KNOW)))
```

_Lists are at the core of what Lisp has been about from its beginning. (In fact the name "Lisp" stands for "LISt Processing.")_

---

### Selectors and Constructors

**What are the _selectors_ of lists?**

- `car` -- to select the first element of a list.
- `cdr` -- to select the portion of a list containing all but the first element.

**What is the _predicate_ function to check for an empty list?**

- `null?` -- returns `#t` for the empty list, `#f` for anything else.

**What are the _constructors_ for lists?**

- `list` -- takes any number of arguments and returns a list with those arguments as its elements.

```scheme
(list (+ 2 3) 'squash (= 2 2) (list 4 5) remainder 'zucchini)
;(5 SQUASH #T (4 5) #<PROCEDURE> ZUCCHINI)
```

<img src="images/list.png" width="400">

- `cons` -- takes two arguments, an element and a list and returns a new list whose `car` is the first argument and whose `cdr` is the second.

```scheme
(cons 'for '(no one))
; (FOR NO ONE)
```

<img src="images/cons.png" width="400">

- `append` -- combines the elements of two or more lists into a larger list.

```scheme
(append '(get back) '(the word))
; (GET BACK THE WORD)
```

<img src="images/append.png" width="400">

```scheme
(list '(i am) '(the walrus))
; ((I AM) (THE WALRUS))

(cons '(i am) '(the walrus))
; ((I AM) THE WALRUS)

(append '(i am) '(the walrus))
; (I AM THE WALRUS)
```

---

### Programming with Lists

**How to define `praise` flavors function with `cons`?**

```scheme
(define (praise flavors)
  (if (null? flavors)                         ; if flavors is empty
      '()                                       ; return '()
      (cons (se (car flavors) '(is delicious))  ; or invoke recursive calls
            (praise (cdr flavors)))))

(praise '(ginger (ultra chocolate) lychee (rum raisin)))
; ((GINGER IS DELICIOUS) (ULTRA CHOCOLATE IS DELICIOUS)
;  (LYCHEE IS DELICIOUS) (RUM RAISIN IS DELICIOUS))
```

**How to define a En-Fr `translate` function with `car` and `cdr`?**

```scheme

(define (translate wd)
  (lookup wd '((window fenetre) (book livre) (computer ordinateur) ; Invoke function lookup
              (house maison) (closed ferme) (pate pate) (liver foie) ; define dictionary
              (faith foi) (weekend (fin de semaine))
              ((practical joke) attrape) (pal copain))))

(define (lookup wd dictionary)
  (cond ((null? dictionary) '(parlez-vous anglais?)) ; when dic is empty, return a sentence
        ((equal? wd (car (car dictionary))) ; when wd is equal to the car of car of dic
         (car (cdr (car dictionary)))) ; return car of cdr of car of dic
        (else (lookup wd (cdr dictionary))))) ; else invoke recursive call with cdr of dic

(translate 'computer)
; ORDINATEUR

(translate '(practical joke))
; ATTRAPE

(translate 'recursion)
; (PARLEZ-VOUS ANGLAIS?)
```

**What is the shorthand for `car` and `cdr` in scheme?**

`car` = `a`
`cdr` = `d`

And wrap `a` and `d` between `c` and `r`.

```scheme
(car (cdr (car dictionary)))
```

can be writtern in

```scheme
(cadar dictionary)
```

The most commonly used of these abbreviations are `cadr` , which selects the second
element of a list; `caddr` , which selects the third element; and `cadddr` , which selects the fourth.

---

### The Truth about Sentences

**What are sentences?**

_Sentences are lists._ Sentences are an abstract data type represented by lists. We created the sentence ADT by writing special selectors and constructors that provide a different way of using the same underlying machinery—a different interface, a different metaphor, a different point of view.

**What are the three differences between sentences and lists?**

- A sentence can contain only words, not sublists.
- Sentence selectors are symmetrical front-to-back.
- Sentences and words have the same selectors.

From Scheme’s ordinary point of view, an English sentence is just one particular case of a much more general data structure, whereas a _symbol_ is something entirely different.

> As we said in Chapter 5, “symbol” is the official name for words that are neither strings nor numbers.

**How to define `first` `last` `butfirst` `butlast` for sentences with Scheme list selectors?**

```scheme
(define (first sent)
  (car sent))

(define (last sent)
  (if (null? (cdr sent))  ; if the sent is null but the first element
      (car sent)          ; return the first element of the sent
      (last (cdr sent)))) ; or invoke the recursive call

(define (butfirst sent)
  (cdr sent))

(define (butlast sent)
  (if (null? (cdr sent))  ; if the sent is null but the first element
      '()                 ; return '()
      (cons (car sent) (butlast (cdr sent))))) ; or add the first element to result
```

---

### Higher-Order Functions

**What are the official list versions of `every` `keep` and `accumulate`?**

`map` `filter` and `reduce`

**How does `map` work?**

`map` takes two arguments, a function and a list, and returns a list containing the
result of applying the function to each element of the list.

```scheme
(map square '(9 8 7 6))
; (81 64 49 36)

(map (lambda (x) (se x x)) '(rocky raccoon))
; ((ROCKY ROCKY) (RACCOON RACCOON))

(every (lambda (x) (se x x)) '(rocky raccoon))
; (ROCKY ROCKY RACCOON RACCOON)

(map car '((john lennon) (paul mccartney)
           (george harrison) (ringo starr)))
; (JOHN PAUL GEORGE RINGO)

(map even? '(9 8 7 6))
; (#F #T #F #T)

(map (lambda (x) (word x x)) 'rain)     ; 'rain is not a list
; ERROR -- INVALID ARGUMENT TO MAP: RAIN
```

> **Where is the name `map` from?**

> The word “map” may seem strange for this function, but it comes from the mathematical study of functions, in which they talk about a mapping of the domain into the range. In this terminology, one talks about “mapping a function over a set” (a set of argument values, that is), and Lispians have taken over the same vocabulary, except that we talk about mapping over lists instead of mapping over sets.

**How does `filter` work?**

`filter` also takes a function and a list as arguments; it returns a list containing only
those elements of the argument list for which the function returns a true value. This
is the same as `keep`, except that the elements of the argument list may be sublists, and
their structure is preserved in the result.

```scheme
(filter (lambda (flavor) (member? 'swirl flavor))
        '((rum raisin) (root beer swirl) (rocky road) (fudge swirl)))
; ((ROOT BEER SWIRL) (FUDGE SWIRL))

(filter word? '((ultra chocolate) ginger lychee (raspberry sherbet)))
; (GINGER LYCHEE)

(filter (lambda (nums) (= (car nums) (cadr nums)))
        '((2 3) (4 4) (5 6) (7 8) (9 9)))
; ((4 4) (9 9))
```

`filter` is not a standard Scheme primitive, but it’s a universal convention; everyone defines it the same way we do.

**How does `reduce` work?**

`reduce` is just like `accumulate` except that it works only on lists, not on words. Neither is a built-in Scheme primitive; both names are seen in the literature. (The name “reduce” is official in the languages APL and Common Lisp, which do include this higher-order function as a primitive.)

```scheme
(reduce * '(4 5 6))
; 120

(reduce (lambda (list1 list2) (list (+ (car list1) (car list2))
                                    (+ (cadr list1) (cadr list2))))
        '((1 2) (30 40) (500 600)))
; (531 642)
```

---

### Other Primitives for Lists

* `list?` --  returns `#t` if its argument is a list, `#f` otherwise.
* `equal?`
* `member` -- like `member?` except for two differences: Its second argument must be a list (but can be a structured list); and instead of returning #t it returns the portion of the argument list starting with the element equal to the first argument.

```scheme
(member 'd '(a b c d e f g))
; (D E F G)

(member 'h '(a b c d e f g))
; #F
```

This is the main example in Scheme of the *semipredicate* idea that we mentioned earlier in passing. It doesn’t have a question mark in its name because it returns values other than #t and #f , but it works as a predicate because any non-`#f` value is considered true.

* `list-ref` -- like `item` execpt it counts items from zero instead of from one and takes its arguments in the other order:

```scheme
(list-ref ’(happiness is a warm gun) 3)
; WARM
```

* `length` -- the same with `count` except that it doesn't work on words.

---

### Association Lists

**What is an association list?**

A list of names and corresponding values is called an *association list*, or an *a-list*.

**How to look up a name in an a-list?**

The Scheme primitive `assoc`

```scheme
(assoc 'george
       '((john lennon) (paul mccartney)
         (george harrison) (ringo starr)))
; (GEORGE HARRISON)

(assoc 'x '((i 1) (v 5) (x 10) (l 50) (c 100) (d 500) (m 1000)))
; (X 10)

(assoc 'ringo '((mick jagger) (keith richards) (brian jones)
                (charlie watts) (bill wyman)))
; #F
```

```scheme
(define dictionary
'((window fenetre) (book livre) (computer ordinateur)
  (house maison) (closed ferme) (pate pate) (liver foie)
  (faith foi) (weekend (fin de semaine))
  ((practical joke) attrape) (pal copain)))

(define (translate wd)
  (let ((record (assoc wd dictionary)))
    (if record
        (cadr record)
        '(parlez-vous anglais?))))
```

`assoc` returns `#f` if it can’t find the entry you’re looking for in your association list.

---

### Functions That Take Variable Numbers of Arguments

**How to use dot `.` to represent any number of arguments?**

```scheme
(define (increasing? number . rest-of-numbers)
  (cond ((null? rest-of-numbers) #t)
        ((> (car rest-of-numbers) number)
         (apply increasing? rest-of-numbers))
        (else #f)))

(increasing? 4 12 82)
; #T

(increasing? 12 4 82 107)
; #F
```

In listing the formal parameters of a procedure, you can *use a dot just before the last parameter to mean that that parameter ( rest-of-numbers in this case) represents any number of arguments, including zero. The value that will be associated with this parameter when the procedure is invoked will be a list whose elements are the actual argument values.*

*The number of formal parameters before the dot determines the minimum number of arguments that must be used when your procedure is invoked. There can be only one formal parameter after the dot.*

**How does procedure `apply` work?**

`apply` takes two arguments, a procedure and a list. Apply invokes the given procedure with the elements of the given list as its arguments, and returns whatever value the procedure returns. Therefore, the following two expressions are equivalent:

```scheme
(+ 3 4 5)

(apply + '(3 4 5))
```

**What is a rest parameter?**

A parameter that follows a dot and therefore represents a variable number of arguments is called a *rest parameter*.

---

### Recursion on Arbitrary Structured Lists

**If the entire book is stored in a list structure. How to define a function to lookup how many times a word apears in the book?**

```scheme
(define (deep-appearances wd structure)     ; higher-order version
  (if (word? structure)
      (if (equal? structure wd) 1 0)
      (reduce +
              (map (lambda (sublist) (deep-appearances wd sublist))
                    structure))))
```

**How to define `deep-appearances` without higher-order procedures?**

We deal with the base case—words—just as before. But for lists we do what we often do in trying to simplify a list problem: We divide the list into its first element (its `car`) and all the rest of its elements (its `cdr`).

```scheme
(define (deep-appearances wd structure)    ; compact-version
  (cond ((equal? wd structure) 1)          ; base case: desired word
        ((word? structure) 0)              ; base case: other word
        ((null? structure) 0)              ; base case: empty list
        (else (+ (deep-appearances wd (car structure))
                 (deep-appearances wd (cdr structure))))))
```

**In `deep-appearances` the desired result is a single number. What if we want to build a new list-of-lists structure? Having used `car` and `cdr` to disassemble a structure, we can use `cons` to build a new one.**

For example, we’ll translate our entire book into Pig Latin:

```scheme
(define (deep-pigl structure)
  (cond ((word? structure) (pigl structure))
        ((null? structure) '())
        (else (cons (deep-pigl (car structure))
                    (deep-pigl (cdr structure))))))
```

Compare `deep-pigl` with an every-pattern list recursion such as `praise` on page 285. Both look like

`(cons ( something (car argument)) ( something (cdr argument)))`

And yet these procedures are profoundly different. `praise` is a simple left-to-right walk through the elements of a sequence; `deep-pigl` dives in and out of sublists.  The difference is a result of the fact that `praise` does one recursive call, for the `cdr` , while `deep-pigl` does two, for the `car` as well as the `cdr`. The pattern exhibited by `deep-pigl` is called `car-cdr` recursion. (Another name for it is “tree recursion,” for a reason we’ll see in the next chapter.)

---

### Pitfalls

* Just as we mentioned about the names `word` and `sentence` , resist the temptation to use `list` as a formal parameter. We use `lst` instead, but other alternatives are capital `L` or `seq` (for “sequence”).

* The list constructor `cons` does not treat its two arguments equivalently. The second one must be the list you’re trying to extend. There is no equally easy way to extend a list on the right (although you can put the new element into a one-element list and use `append` ). If you get the arguments backward, you’re likely to get funny-looking results that aren’t lists, such as

```scheme
((3 . 2) . 1)
```

The result you get when you `cons` onto something that isn’t a list is called a _pair_. It’s sometimes called a “dotted pair” because of what it looks like when printed:

```scheme
(cons 'a 'b)
; (A . B)
```

It’s just the printed representation that’s dotted, however; the dot isn’t part of the pair any more than the parentheses around a list are elements of the list. Lists are made of pairs; that’s why `cons` can construct lists. But we’re not going to talk about any pairs that aren’t part of lists, so you don’t have to think about them at all, except to know that if dots appear in your results you’re consing backward.

* Don’t get confused between lists and sentences. Sentences have no internal structure; the good aspect of this is that it’s hard to make mistakes about building the structure, but the bad aspect is that you might need such a structure. You can have lists whose elements are sentences, but it’s confusing if you think of the same structure sometimes as a list and sometimes as a sentence.

* In reading someone else’s program, it’s easy not to notice that a procedure is making two recursive calls instead of just one. If you notice only the recursive call for the `cdr`, you might think you’re looking at a sequential recursion.

* If you’re writing a procedure whose argument is a list-of-lists, it may feel funny to let it also accept a word as the argument value. People therefore sometimes insist on a list as the argument, leading to an overly complicated base case. If your base case test says

```scheme
(word? (car structure))
```

then think about whether you’d have a better-organized program if the base case were

```scheme
(word? structure)
```

* Remember that in a deep-structure recursion you may need two base cases, one for reaching an element that isn’t a sublist, and the other for an empty list, with no elements at all. (Our `deep-appearances` procedure is an example.) Don’t forget the empty-list case.

---

**Exercises 17.1-17.3**


**Exercises 17.4-17.16**
