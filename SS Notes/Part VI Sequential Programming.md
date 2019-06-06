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


