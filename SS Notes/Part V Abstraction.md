# Part V Abstraction

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

\*Lists are at the core of what Lisp has been about from its beginning. (In fact the name “Lisp” stands for “LISt Processing.”)\*\*

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

- `cons` -- takes tow arguments, an element and a list and returns a new list whose `car` is the first argument and whose `cdr` is the second.

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
(member ’d '(a b c d e f g))
; (D E F G)

(member 'h '(a b c d e f g))
; #F
```

This is the main example in Scheme of the *semipredicate* idea that we mentioned earlier in passing. It doesn’t have a question mark in its name because it returns values other than #t and #f , but it works as a predicate because any non- #f value is considered true.

* `list-ref` -- like `item` execpt it counts items from zero instead of from one and takes its arguments in the other order:

```scheme
(list-ref ’(happiness is a warm gun) 3)
; WARM 
```

* `length` -- the same with `count` except that it doesn't work on words.

