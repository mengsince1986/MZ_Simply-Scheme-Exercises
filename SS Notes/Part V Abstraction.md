# Part V Abstraction

**What are the two kinds of abstraction specified in this part?**

* data abstraction
* the implementation of higher-order functions

## Chapter 17 Lists

**How to use list to define an icecream menu?**

```scheme
(vanilla (ultra chocolate) (heath bar crunch) ginger (cherry garcia))
```

This is meant to represent five flavors, two of which are named by single words, and the other three of which are named by sentences.

The data structure we’re using in this example is called a ***list***.

**What are the differnces between a sentence and a list?**

|                |      lists       |      sentences       |
|----------------|:----------------:|:--------------------:|
| **elements**   |     anything     |        words         |
| **definition** | sefl-referential | non-self-referential |

A list that’s an element of another list is called a ***sublist***. We’ll use the name ***structured*** list for a list that includes sublists.

**How to use lists in pattern matcher?**

We used list structure to hold known-values databases, such as 

```scheme
((FRONT (YOUR MOTHER)) (BACK (SHOULD KNOW)))
```

*Lists are at the core of what Lisp has been about from its beginning. (In fact the name “Lisp” stands for “LISt Processing.”)**

---

### Selectors and Constructors

**What are the *selectors* of lists?**

* `car` -- to select the first element of a list.
* `cdr` -- to select the portion of a list containing all but the first element.

**What is the *predicate* function to check for an empty list?**

* `null?` -- returns `#t` for the empty list, `#f` for anything else.

**What are the *constructors* for lists?**

* `list` -- takes any number of arguments and returns a list with those arguments as its elements.

```scheme
(list (+ 2 3) 'squash (= 2 2) (list 4 5) remainder 'zucchini)
;(5 SQUASH #T (4 5) #<PROCEDURE> ZUCCHINI)
```

<img src="/images/list.png" width="400">

* `cons` -- takes tow arguments, an element and a list and returns a new list whose `car` is the first argument and whose `cdr` is the second.

```scheme
(cons 'for '(no one))
; (FOR NO ONE)
```

<img src="/images/cons.png" width="400">

* `append` -- combines the elements of two or more lists into a larger list.

```scheme
(append '(get back) '(the word))
; (GET BACK THE WORD)
```

<img src="/images/append.png" width="400">


```scheme
(list ’(i am) ’(the walrus))
; ((I AM) (THE WALRUS))

(cons ’(i am) ’(the walrus))
; ((I AM) THE WALRUS)

(append ’(i am) ’(the walrus))
; (I AM THE WALRUS)
```

---

### Programming with Lists

