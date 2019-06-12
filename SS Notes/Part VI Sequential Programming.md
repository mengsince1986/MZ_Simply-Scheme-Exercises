---
title: "Part VI Sequential Programming"
---

The three big ideas in this part are *effect*, *sequence*, and *state*.

**What is *effect*?**

In this part of the book we’re going to talk about giving commands to the computer as well as asking it questions. That is, we’ll invoke procedures that tell Scheme to do something. Instead of merely computing a value, such a procedure has an *effect*, an action that changes something.

**What is *sequence*?**

Once we’re thinking about actions, it’s very natural to consider a *sequence* of actions.  First cooking dinner, then eating, and then washing the dishes is one sequence.

**What is *sequential programming*?**

Most books compare a program to a recipe or a sequence of instructions, along the lines of

```
to go-to-work
  get-dressed
  eat-breakfast
  catch-the-bus
```

This *sequential programming* style is simple and natural, and it does a good job of modeling computations in which the problem concerns a sequence of events. If you’re writing an airline reservation system, a sequential program with `reserve-seat` and `issue-ticket` commands makes sense. But if you want to know the acronym of a phrase, that’s not inherently sequential, and a question-asking approach is best.

**What is *state*?**

Some actions that Scheme can take affect the “outside” world, such as printing something on the computer screen. But Scheme can also carry out internal actions, invisible outside the computer, but changing the environment in which Scheme itself carries out computations. Defining a new variable with `define` is an example; before the definition, Scheme wouldn’t understand what that name means, but once the definition has been made, the name can be used in evaluating later expressions.

Scheme’s knowledge about the leftover effects of past computations is called its *state*. The third big idea in this part of the book is that *we can write programs that maintain state information and use it to determine their results.*

**How does the notion of *sequence* and *state* contradict functional programming?**

Like *sequence*, the notion of *state* contradicts functional programming. Earlier in the book, we emphasized that every time a function is invoked with the same arguments, it must return the same value. But a procedure whose returned value depends on *state*—on the past history of the computation—might return a different value on each invocation, even with identical arguments.

**What are the three useful situations for *effects*, *sequence* and *state*?**

* Interactive, question-and-answer programs that involve keyboard input while the com- putation is in progress;
* Programs that must read and write long-term data file storage;
* Computations that model an actual sequence of events in time and use the state of the program to model information about the state of the simulated events.

After introducing Scheme’s mechanisms for sequential programming, we’ll use those mechanisms to implement versions of two commonly used types of business computer applications, a spreadsheet and a database program.

---

## Chapter 20 Input and Output

### Printing

**How to print the lyrics of "99 Bottles of Beer on the Wall" with scheme?**

We’ll write a program to print a verse, rather than return it in a list:

```scheme
(define (bottles n)
  (if (= n 0)
      'burp
      (begin (verse n)
             (bottles (- n 1)))))

(define (verse n)
(show (cons n '(bottles of beer on the wall)))
(show (cons n '(bottles of beer)))
(show '(if one of those bottles should happen to fall))
(show (cons (- n 1) '(bottles of beer on the wall)))
(show '()))

(bottles 3)
; (3 BOTTLES OF BEER ON THE WALL)
; (3 BOTTLES OF BEER)
; (IF ONE OF THOSE BOTTLES SHOULD HAPPEN TO FALL)
; (2 BOTTLES OF BEER ON THE WALL)
; ()
; (2 BOTTLES OF BEER ON THE WALL)
; (2 BOTTLES OF BEER)
; (IF ONE OF THOSE BOTTLES SHOULD HAPPEN TO FALL)
; (1 BOTTLES OF BEER ON THE WALL)
; ()
; (1 BOTTLES OF BEER ON THE WALL)
; (1 BOTTLES OF BEER)
; (IF ONE OF THOSE BOTTLES SHOULD HAPPEN TO FALL)
; (0 BOTTLES OF BEER ON THE WALL)
; ()
; BURP
```

Why was "burp" printed at the end? Just because we’re printing things explicitly doesn’t mean that the read-eval-print loop stops functioning. We typed the expression `(bottles 3)` . In the course of evaluating that expression, Scheme printed several lines for us. But the value of the expression was the word burp, because that’s what bottles returned.

---

### Side Effects and Sequencing

**How does procedure `show` work?**

The procedures we’ve used compute and return a value, and do nothing else. `show` is different. Although every Scheme procedure returns a value, *the Scheme language standard doesn’t specify what value the printing procedures should return*. Instead, we are interested in their side effects. *we invoke show because we want it to do something, namely, print its argument on the screen.*

Suppose `show` returns `#f` in your version of Scheme. Then you might see

```scheme
(show 7)
; 7
; #F
```

But since the return value is unspecified, we try to write programs in such a way that *we never use `show`’s return value as the return value from our procedures.*

**What is "side effect"?**

What exactly do we mean by “side effect”? The kinds of procedures that we’ve used before this chapter can compute values, invoke helper procedures, provide arguments to the helper procedures, and return a value. There may be a lot of activity going on within the procedure, but the procedure affects the world outside of itself only by returning a value that some other procedure might use. `show` affects the world outside of itself by putting something on the screen. After show has finished its work, someone who looks at the screen can tell that show was used.

The term *side effect* is based on the idea that a procedure may have a useful return value as its main purpose and may also have an effect “on the side.” It’s a misnomer to talk about the side effect of `show`, since the effect is its main purpose.

**What is the difference between values and effects?**

Here’s an example to illustrate the difference between values and effects:

```scheme
(define (effect x)
  (show x)
  'done)

(define (value x)
  x)

(effect '(oh! darling))
; (OH! DARLING)
; DONE

(value '(oh! darling))
; (OH! DARLING)

(bf (effect '(oh! darling)))
; (OH! DARLING)
; ONE

(bf (value '(oh! darling)))
; (DARLING)

(define (lots-of-effect x)
  (effect x)
  (effect x)
  (effect x))

(define (lots-of-value x)
  (value x)
  (value x)
  (value x))

(lots-of-effect '(oh! darling))
; (OH! DARLING)
; (OH! DARLING)
; (OH! DARLING)
; DONE

(lots-of-value ’(oh! darling))
; (OH! DARLING)
```

This example also demonstrates the second new idea, *sequencing*: Each of `effect`, `lots-of-effect`, and `lots-of-value` contains more than one expression in its body. When you invoke such a procedure, *Scheme evaluates all the expressions in the body, in order, and returns the value of the last one.* This also works in the body of a `let`, which is really the body of a procedure, and in each clause of a `cond`.

```scheme
(cond ((< 4 0)
       (show '(how interesting))
       (show '(4 is less than zero?))
       #f)
      ((> 4 0)
       (show '(more reasonable))
       (show '(4 really is more than zero))
       'value)
      (else
       (show '(you mean 4=0?))
       #f))

; (MORE REASONABLE)
; (4 REALLY IS MORE THAN ZERO)
; VALUE
```

> In Chapter 4, we said that the body of a procedure was always one single expression. We lied. *But as long as you don’t use any procedures with side effects, it doesn’t do you any good to evaluate more than one expression in a body.*

When we invoked `lots-of-value`, Scheme invoked `value` three times; it discarded the values returned by the first two invocations, and returned the value from the third invocation. Similarly, when we invoked `lots-of-effect`, Scheme invoked `effect` three times and returned the value from the third invocation. But each invocation of `effect` caused its argument to be printed by invoking `show`.

---

### The `begin` Special Form

**Why is that multiple expressions can't be used in an `if` construction?**

The `lots-of-effect` procedure accomplished sequencing by having more than one expression in its body. This works fine if the sequence of events that you want to perform is the entire body of a procedure. But in `bottles` we wanted to include a sequence as one of the alternatives in an `if` construction. We couldn’t just say

```scheme
(define (bottles n)
  (if (= n 0)
      '()
      (verse n)
      (bottles (- n 1))))
```

because `if` must have exactly three arguments. Otherwise, how would `if` know whether we meant `(verse n)` to be the second expression in the true case, or the first expression in the false case?

**How does `begin` work?**

Instead, to turn the sequence of expressions into a single expression, we use the special form `begin`. *It takes any number of arguments, evaluates them from left to right, and returns the value of the last one.*

```scheme
(define bottles n)
(if (= n 0)
’burp
(begin (verse n)
(bottles (- n 1)))))
```

(One way to think about sequences in procedure bodies is that every procedure body has an invisible `begin` surrounding it.)

---

### This isn't Functional Programming

**What is the difference between a function and procedure?**

Sequencing and side effects are radical departures from the idea of functional programming. In fact, we’d like to reserve the name *function* for something that computes and returns one value, with no side effects.

“*Procedure*” is the general term for the thing that lambda returns—an embodiment of an algorithm. If the algorithm is the kind that computes and returns a single value without side effects, then we say that the procedure implements a function.

> Sometimes people sloppily say that the procedure is a function. In fact, you may hear people be really sloppy and call a non-functional procedure a function!

**Is there sequencing in functional programming?**

There is a certain kind of sequencing even in functional programming. If you say

```scheme
(* (+ 3 4) (- 92 15))
```

it’s clear that the addition has to happen before the multiplication, because the result of the addition provides one of the arguments to the multiplication.

What’s new in the sequential programming style is the emphasis on *sequence*, and the fact that the expressions in the sequence are independent instead of contributing values to each other. In this multiplication problem, for example, we don’t care whether the addition happens before or after the subtraction. If the addition and subtraction were in a sequence, we’d be using them for independent purposes:

```scheme
(begin
 (show (+ 3 4))
 (show (- 92 15)))
```

This is what we mean by being independent. *Neither expression helps in computing the other. And the order matters because we can see the order in which the results are printed.*

---

### Not Moving to the Next Line

**How to make a program print several things on the same line?**

```scheme
(begin (show-addition 3 4)
       (show-addition 6 8)
       'done)

; 3+4=7
; 6+8=14
; DONE
```

We use `display`, which doesn’t move to the next line after printing its argument:

```scheme
(define (show-addition x y)
  (display x)
  (display '+)
  (display y)
  (display '=)
  (show (+ x y)))
```

(The last one is a show because we do want to start a new line after it.)

**How to print a blank line?**

You use `newline`:

```scheme
(define (verse n)
  (show (cons n '(bottles of beer on the wall)))
  (show (cons n '(bottles of beer)))
  (show '(if one of those bottles should happen to fall))
  (show (cons (- n 1) '(bottles of beer on the wall)))
  (newline))                                                       ; replaces (show '())
```

In fact, `show` isn’t an official Scheme primitive; we wrote it in terms of `display` and `newline` .

---

### Strings

**What are strings?**

*Strings* are words enclosed in double-quote marks so that Scheme will permit the use of punctuation or other unusual characters. Strings also preserve the case of letters, so they can be used to beautify our song even more.

**How to beautify "99 Bottles of Beer on the Wall" with strings?**

Since any character can be in a string, including spaces, the easiest thing to do in this case is to treat all the letters, spaces, and punctuation characters of each line of the song as one long word.

```scheme
(define (verse n)
  (display n)
  (show " bottles of beer on the wall,")
  (display n)
  (show " bottles of beer.")
  (show "If one of those bottles should happen to fall,")
  (display (- n 1))
  (show " bottles of beer on the wall.")
  (newline))

(verse 6)
; 6 bottles of beer on the wall,
; 6 bottles of beer.
; If one of those bottles should happen to fall,
; 5 bottles of beer on the wall.
; #F                                             ; or whatever is returned by (newline)
```

It’s strange to think of “bottles of beer on the wall,” as a single word. But *the rule is that anything inside double quotes counts as a single word. It doesn’t have to be an English word.*

---

### A Higher-Order Procedure for Sequencing

**How to print each element of a list?**

```scheme
(define (show-list lst)
  (if (null? lst)
      'done
      (begin (show (car lst))
             (show-list (cdr lst)))))

(show-list '((dig a pony) (doctor robert) (for you blue)))
; (DIG A PONY)
; (DOCTOR ROBERT)
; (FOR YOU BLUE)
; DONE
```

**How to abstract `show-list` into a higher order procedure? (We can’t call it a “higher-order function” because this one is for computations with side effects.)**

The procedure `for-each` is part of standard Scheme:

```scheme
(for-each show '((mean mr mustard) (no reply) (tell me why)))
; (MEAN MR MUSTARD)
; (NO REPLY)
; (TELL ME WHY)
```

The value returned by `for-each` is unspecified.

**Why is that we use `for-each` instead of `map` to print each element of a list?**

There are two reasons. One is just an efficiency issue: `map` constructs a list containing the values returned by each of its sub-computations; in this example, it would be a list of three instances of the unspecified value returned by `show`. But we aren’t going to use that list for anything, so there’s no point in constructing it.

The second reason is more serious. *In functional programming, the order of evaluation of subexpressions is unspecified.* For example, when we evaluate the expression

```scheme
(- (+ 4 5) (* 6 7))
```

we don’t know whether the addition or the multiplication happens first. Similarly, the order in which `map` computes the results for each element is unspecified. That’s okay as long as the ultimately returned list of results is in the right order. But when we are using side effects, we do care about the order of evaluation. In this case, we want to make sure that the elements of the argument list are printed from left to right. `for-each` guarantees this ordering.

---

### Tic-Tac-Toe Revisited

We’re working up toward playing a game of tic-tac-toe against the computer. But as a first step, let’s have the computer play against itself.

What we already have is `ttt`, a strategy function: one that takes a board position as argument (and also a letter x or o ) and returns the chosen next move.

**How to define `stupid-ttt` as an alternative strategy?**

```scheme
(define (stupid-ttt position letter)
  (location '_ position))

(define (location letter word)
  (if (equal? letter (first word))
      1
      (+ 1 (location letter (bf word)))))
```

**How to write a program `play-ttt` that takes two strategies as arguments and plays a game between them?**

```scheme
(define (play-ttt x-strat o-strat)
  (play-ttt-helper x-strat o-strat '_________ 'x))

(define (play-ttt-helper x-strat o-strat position whose -turn)
  (cond ((already-won? position (opponent whose -turn))
         (list (opponent whose -turn) 'wins!))
        ((tie-game? position) '(tie game))
        (else (let ((square (if (equal? whose -turn 'x)
                                (x-strat position 'x)
                                (o-strat position 'o))))
                (play-ttt-helper x-strat
                                 o-strat
                                 (add-move square whose -turn position)
                                 (opponent whose-turn))))))

(define (already-won? position who)
  (member? (word who who who) (find-triples position)))

(define (tie-game? position)
  (not (member? '_ position)))
```

**How to define `add-move`?**

The procedure `add-move` takes a square and an old position as arguments and returns the new position.

```scheme
(define (add-move square letter position)
  (if (= square 1)
      (word letter (bf position))
      (word (first position)
            (add-move (- square 1) letter (bf position)))))

(play-ttt ttt stupid-ttt)
; (X WINS!)

(play-ttt stupid-ttt ttt)
; (O WINS!)
```

---

### Accepting User Input

**How to define a strategy procedure `ask-user` that asks the user where to move?**

```scheme
(define (ask-user position letter)
  (print-position position)
  (display letter)
  (display "’s move: ")
  (read))

(define (print-position position)    ;; first version
  (show position))

(play-ttt ttt ask-user)
; ____X____
; O’S MOVE: 1
; O___XX___
; O’S MOVE: 4
; O__OXXX__
; O’S MOVE: 3
; OXOOXXX__
; O’S MOVE: 8
; (TIE GAME)
```

What the user typed is just the single digits shown in boldface at the ends of the lines.

**How does procedure `read` work?**

`read` waits for you to type a Scheme expression, and returns that expression. Don’t be confused: `read` does not evaluate what you type. It returns exactly the same expression that you type:

```scheme
(define (echo)
  (display "What? ")
  (let ((expr (read)))
    (if (equal? expr 'stop)
        'okay
        (begin
         (show expr)
         (echo)))))

(echo)
; What? hello
; HELLO
; What? (+ 2 3)
; (+ 2 3)
; What? (first (glass onion))
; (FIRST (GLASS ONION))
; What? stop
; OKAY
```

---

### Aesthetic Board Display

```scheme
(define (print-position position)
  (print-row (subword position 1 3))
  (show "-+-+-")
  (print-row (subword position 4 6))
  (show "-+-+-")
  (print-row (subword position 7 9))
  (newline))

(define (print-row row)
  (maybe-display (first row))
  (display "|")
  (maybe-display (first (bf row)))
  (display "|")
  (maybe-display (last row))
  (newline))

(define (maybe-display letter)
  (if (not (equal? letter ’ ))
      (display letter)
      (display " ")))

(define (subword wd start end)      ; higher-order version
  ((repeated bf (- start 1))
   ((repeated bl (- (count wd) end))
    wd)))

(define (subword wd start end)
  (cond ((> start 1) (subword (bf wd) (- start 1) (- end 1)))
        ((< end (count wd)) (subword (bl wd) start end))
        (else wd)))
```

```scheme
(print-position '_x_oo__xx)
;  |X|
; -+-+-
; O|O|
; -+-+-
;  |X|X
```
