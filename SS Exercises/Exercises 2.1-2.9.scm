; Exercises 2.1-2.9

; 2.2 What is the domain of the vowel? function?

; answer: everything

; *********************************************************

; 2.3 One of the functions you can use is called appearances. Experiment with it, and then describe fully its domain and range, and what it does. (Make sure to try lots of cases. Hint: Think about its name.)

; answer: the first argument of function appearances is a single letter or nonnegative interger and its second argument is a letter/word/sentence/positive number. its range is an integer.

; the appearances function return the appearance times of its first argument in its second argument.

; *********************************************************

; 2.4 One of the functions you can use is called item. Experiment with it, and then describe fully its domain and range, and what it does.

; answer: the first argument of function item is an positive integer, and its second argument is a word or sentence.

; Set the first argument as n. the item function returns the nth item of its second argument.

; *********************************************************

; The following exercises ask for functions that meet certain criteria. For your conve- nience, here are the functions in this chapter: +, -, /, <=, <, =, >=, >, and, appearances, butfirst, butlast, cos, count, equal?, every, even?, expt, first, if, item, keep, last, max, member?, not, number?, number-of-arguments, odd?, or, quotient, random, remainder, round, sentence, sqrt, vowel?, and word.

; 2.5 List the one-argument functions in this chapter for which the type of the return value is always different from the type of the argument.

; answer:
#|
even?
odd?
|#

; *********************************************************

; 2.6 List the one-argument functions in this chapter for which the type of the return value is sometimes different from the type of the argument. 

; answer:
#|
butfirst
butlast
count
first
last
number?
vowel?
|#

; *********************************************************

; 2.7 Mathematicians sometimes use the term “operator” to mean a function of two arguments, both of the same type, that returns a result of the same type. Which of the functions you’ve seen in this chapter satisfy that definition?

; answer:
#|
+
-
/
and
expt
or
quotient
remainder
word
|#

; *********************************************************

; 2.8 An operator f is commutative if f (a, b) = f (b, a) for all possible arguments a and b. For example, + is commutative, but word isn’t. Which of the operators from Exercise 2.7 are commutative?

; answer:
#|
+
and
or
|#

; *********************************************************

; 2.9 An operator f is associative if f (f (a, b), c) = f (a, f (b, c)) for all possible arguments a, b, and c. For example, * is associative, but not /. Which of the operators from Exercise 2.7 are associative?

; answer:
#|
+
and
or
word
|#




