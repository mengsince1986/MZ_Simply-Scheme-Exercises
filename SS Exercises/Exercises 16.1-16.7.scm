; Exercises 16.1-16.7

; 16.1 Design and test a pattern that matches any sentence containing the word C three times (not necessarily next to each other).

; solution:
'(* C * C * C *)

; **********************************************************

; 16.2 Design and test a pattern that matches a sentence consisting of two copies of a smaller sentence, such as (a b a b).

; solution:
'(*duplicate *duplicate)

; **********************************************************

; 16.3 Design and test a pattern that matches any sentence of no more than three words.

; solution:
'(?wd-1 ?wd-2 ?wd-3)

; **********************************************************

; 16.4  Design and test a pattern that matches any sentence of at least three words.

; solution:
'(!wd-1 !wd-2 !wd-3 *over-3)

; **********************************************************

; 16.5 Show sentences of length 2, 3, and 4 that match the pattern

; (*x *y *y *x)

; For each length, if no sentence can match the pattern, explain why not.

; solution:

; the pattern matches all the sentences that has two identical symbols (sentences/words/void) placed at the beginning and end and two identical symbols (sentences/words/void) in the middle.

; length 2
'(symbol-1 symbol-1)

; length 3
; no sentence of length 3 can match the pattern, because the patten needs two pairs of symbols.

; length 4
'(symbol-1 symbol-2 symbol-2 symbol-1)

; **********************************************************

; 16.6 Show sentences of length 2, 3 and 5 that match the pattern

'(*x *y &y &x)

; For each length, if no sentence can match the pattern, explain why not.

; solution:

; the pattern match any sentence with two identical symbols (not including void) at the beginning and end and two identical symbols (not including void) in the middle.

; no sentence of length 2/3/5 will match the pattern, because the pattern needs exactly two pairs of identical symbols and each symbol at least contain 1 word.

; **********************************************************



