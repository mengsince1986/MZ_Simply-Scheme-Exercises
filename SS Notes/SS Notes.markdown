# Simply Scheme  
  
## Authors  
  
### Brian Harvey  
  
### Matthew Wright  
  
## Preface  
  
### What are the two schools of thought about teaching computer science?  
  
There are two schools of thought about teaching computer science. We might caricature the two views this way:   
  
* **The conservative view:** Computer programs have become too large and complex to encompass in a human mind. Therefore, the job of computer science education is to teach people how to discipline their work in such a way that 500 mediocre programmers can join together and produce a program that correctly meets its specification.   
  
* **The radical view:** Computer programs have become too large and complex to encompass in a human mind. Therefore, the job of computer science education is to teach people how to expand their minds so that the programs _can_ fit, by learning to think in a vocabulary of larger, more powerful, more flexible ideas than the obvious ones. Each unit of programming thought must have a big payoff in the capabilities of the program.  
  
## How to Read this book?  
  
**Do the exercises!** Whenever we teach programming, we always get students who say, “When I read the book it all makes sense, but on the exams, when you ask me to write a program, I never know where to start.”   
  
**_Computer science is two things: a bunch of big ideas, as we’ve been saying, and also a skill. You can’t learn the skill by watching._**  
  
## Part I Introduction: Functions  
  
### What is the goal of C01 an C02?  
  
In these first two chapters, our goal is to introduce the Scheme programming language and the idea of **using _functions_ as the building blocks of a computation**.  
  
### Chapter 1 Showing Off Scheme  
  
* What is Scheme?  
      
    **_Scheme_** is a dialect of Lisp, a family of computer programming languages invented for computing with words, sentences, and ideas instead of just numbers.  
  
* Talking to Scheme  
    * What does `>` mean in Scheme?  
          
        The `>` is a _**prompt**,_ Scheme’s way of telling you that it’s ready for you to type something.  
  
    * Why is Scheme an interactive programming language?  
          
        Scheme is an _**interactive**_ programming language. In other words, you type a request to Scheme, then Scheme prints the answer, and then you get another prompt.  
  
* Existing Scheme  
    * How to exist Scheme?  
          
        Although there’s no official standard way to exit Scheme, most versions use the notation   
          
        ```lisp  
        > (exit)   
        ```  
  
### Chapter 2 Functions  
  
* Domain and Range  
    * What is domain/range in a function?  
          
        The technical term for “_**the things that a function accepts as an argument**_” is the _**domain**_ of the function. The name for “**_the things that a function returns_**” is its _**range**._  
  
* Exercises 2.1-2.9  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 2.1-2.9.scm][1]  
  
    * What is commutative operator?  
          
        **2.8** An operator _f_ is _commutative_ if _f_ (_a_, _b_) = _f_ (_b_, _a_) for all possible arguments _a_ and _b_. For example, + is commutative, but word isn’t.  
  
    * What is associative operator?  
          
        **2.9** An operator _f_ is _associative_ if _f_ (_f_ (_a_, _b_), _c_) = _f_ (_a_, _f_ (_b_, _c_)) for all possible arguments _a_, _b_, and _c_. For example, * is associative, but not /.  
  
## Part II Composition of Functions  
  
### Chapter 3 Expressions  
  
* What is Scheme's "read-eval-print loop"?  
      
    The interaction between you and Scheme is called the “**_read-eval-print loop_**.” Scheme reads what you type, _evaluates_ it, and prints the answer, and then does the same thing over again. We’re emphasizing the word “evaluates” because the essence of understanding Scheme is knowing what it means to evaluate something.  
  
* What is an expression?  
      
    Each question you type is called an _**expression**._ **The expression can be a single value, such as 26, or something more complicated in parentheses, such as (+ 14 7).** The first kind of expression is called a**n _atom_ (or _atomic expression_)**, while the second kind of expression is called a **_compound expression,_** because it’s made out of the smaller expressions +, 14, and 7. The metaphor is from chemistry, where atoms of single elements are combined to form chemical compounds. We sometimes call the expressions within a compound expression its _**subexpressions**._  
  
    * What is the name when compound expressions tell Scheme to "do" a procedure?  
          
        **Compound expressions** tell Scheme to “do” a procedure. This idea is so important that it has a lot of names. You can **_call_ a procedure**; you can **_invoke_ a procedure**; or you can **_apply_ a procedure to some numbers or other values**. All of these mean the same thing.  
  
* What are **self-evaluating** expressions?  
      
    It’s easy to understand an expression that just contains one number. Numbers are _**self-evaluating**;_ that is, when you evaluate a number, you just get the same number back.   
      
    Once you understand _numbers,_ you can understand _expressions that add up_ numbers. And once you understand _those_ expressions, you can use that knowledge to figure out _expressions that add up_ expressions-that-add-up-numbers. Then . . . and so on. In practice, you don’t usually think about all these levels of complexity separately. You just think, “I know what a number is, and I know what it means to add up _any_ expressions.”   
      
    So, for example, to understand the expression   
      
    >(+ (+ 2 3) (+ 4 5))   
      
    you must first understand 2 and 3 as self-evaluating numbers, then understand (+ 2 3) as an expression that adds those numbers, then understand how the sum, 5, contributes to the overall expression.  
  
* Are parentheses optional in Scheme?  
      
    In ordinary arithmetic you’ve gotten used to the idea that parentheses can be optional; 3 + 4 * 5 means the same as 3 + (4 * 5). But **in Scheme, parentheses are _never_ optional. Every procedure call must be enclosed in parentheses**.  
  
* Exercises 3.1-3.9  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 3.1-3.9.scm][2]  
  
### Chapter 4 Defining Your Own Procedures  
  
* How to Define a Procedure?  
    * What is a procedure?  
          
        A Scheme program consists of one or more _**procedures**._ **A procedure is a description of the process by which a computer can work out some result that we want.** Here’s how to define a procedure that returns the square of its argument:  
          
        ```lisp   
        (define (square x)  
          (* x x))  
        ```  
          
        (The value returned by define may differ depending on the version of Scheme you’re using. Many versions return the name of the procedure you’re defining, but others return something else. It doesn’t matter, because when you use define you aren’t interested in the returned value, but rather in the fact that Scheme remembers the new definition for later use.)  
  
    * What are the four parts in a procedure definition?  
          
        This procedure definition has **four parts**.   
        The first is **_the word `define`, which indicates that you are defining something_**.   
        The second and third come together inside parentheses: **the name that you want to give the procedure and the name(s) you want to use for its argument(s).** This arrangement was chosen by the designers of Scheme because it looks like the form in which the procedure will be invoked. That is, (square x) looks like (square 7).   
        The fourth part of the definition is **the _body:_ an expression whose value provides the function’s return value.**   
          
        ![][3]  
  
* Special Forms  
    * What is the specialness of *special form*?  
          
        Define is a _**special form**,_ an exception to the evaluation rule we’ve been going on about.   
          
        > Technically, the entire expression `(define (square x) . . .)` is the special form; the word define itself is called a _**keyword**_. But in fact Lispians are almost always loose about this distinction and say “defineis a special form,” just as we’ve done here. The word “form” is an archaic synonym for “expression,” so “special form” just means “special expression.”   
          
        Usually, an expression represents a procedure invocation, so the general rule is that Scheme first evaluates all the subexpressions, and then applies the resulting procedure to the resulting argument values. **The specialness of special forms is that Scheme _doesn’t_ evaluate all the subexpressions. Instead, each special form has its own particular evaluation rule.** For example, when we defined square, no part of the definition was evaluated: not square, not x, and not (* x x). It wouldn’t make sense to evaluate (square x) because you can’t invoke the square procedure before you define it!  
  
    * How to describe special forms?  
          
        It would be possible to describe special forms using the following model: “**Certain procedures want their arguments unevaluated, and Scheme recognizes them. After refraining from evaluating define’s arguments, for example, Scheme invokes the `define` procedure with those unevaluated arguments.**”   
          
        But in fact the designers of Scheme chose to think about it differently. The entire special form that starts with `define` is just a completely different kind of thing from a procedure call. In Scheme there is no procedure named `define`. In fact, `define` is not the name of anything at all:   
          
        ```lisp  
        >+  
        <PRIMITIVE PROCEDURE +>   
        > define  
        ERROR -- INVALID CONTEXT FOR KEYWORD DEFINE   
        lisp  
  
* Functions and Procedures  
    * What is a function?  
          
        Throughout most of this book, our procedures will describe processes that compute _**functions**._   
          
        **A _function_ is a connection between some values you already know and a new value you want to find out.**   
          
        For example, the _square_ function takes a number, such as 8, as its input value and returns another number, 64 in this case, as its output value.   
          
        The _plural_ function takes a noun, such as “computer,” and returns another word, “computers” in this example.   
          
        **The technical term for the function’s input value is its _argument._**   
          
        **A function may take more than one argument**; for example, the remainder function takes two arguments, such as 12 and 5. It returns one value, the remainder on dividing the first argument by the second (in this case, 2).  
  
    * What is the difference between procedures and functions?  
          
        We said earlier that **_a procedure_** is “**a description of the process by which a computer can work out some result that we want**.” What do we mean by _process_? Consider these two definitions:   
          
        >f(x) = 3x + 12   
        >g(x) = 3(x + 4)   
          
        The two definitions call for different arithmetic operations. For example, to compute _f_ (8) we’d multiply 8 by 3, then add 12 to the result. To compute _g_ (8), we’d add 4 to 8, then multiply the result by 3. But we get the same answer, 36, either way. **These two equations describe different _processes,_ but they compute the same _function._** **The function is just the association between the starting value(s) and the resulting value, no matter how that result is computed.** In Scheme we could say   
          
        ```lisp  
        (define (f x)  
          (+ (* 3 x) 12))  
        (define (g x)  
          (* 3 (+ x 4)))  
        ```  
          
        and we’d say that **`f` and `g` are two _procedures_ that represent the same _function_**.  
  
    * What are the other ways to represent functions?  
          
        In real life, functions are not always represented by procedures. We could **represent a function by a _table_** showing all its possible values, like this:   
          
        ![][4]  
          
          
        This table represents the State Capital function; we haven’t shown all the lines of the complete table, but we could. There are only a finite number of U.S. states. **Numeric functions can also be represented by _graphs,_** as you probably learned in high school algebra. In this book our focus is on the representation of functions by procedures. The only reason for showing you this table example is to clarify what we mean when we say that **a function _is represented by_ a procedure, rather than that a function _is_ the procedure**.  
  
    * What is the difference between "the procedure f" and "the function f"?  
          
        We’ll **say “_the procedure f_” when we want to discuss the operations we’re telling Scheme to carry out**.   
        We’ll **say “_the function represented by f_” when our attention is focused on the value returned, rather than on the mechanism. (But we’ll often abbreviate that lengthy second phrase with “_the function f_” unless the context is especially confusing.**)  
          
        > Also, we’ll sometimes use the terms “**_domain_**” and “**_range_**” when we’re talking about procedures, although technically, only functions have domains and ranges.  
  
* Argument Names versus Argument Values  
    * What is the difference between argument names and argument values?  
          
        Notice that when we _defined_ the square procedure we gave a _name,_ x, for its argument. By contrast, when we _invoked_ square we provided a _value_ for the argument (e.g., 7). The word x is a “place holder” in the definition that stands for whatever value you use when you call the procedure. So you can read the definition of square as saying, “In order to square a number, multiply _that number_ by _that number._” The name x holds the place of the particular number that you mean.  
  
    * What is **formal parameter**?  
          
        **The name for the name of an argument (whew!) is _formal parameter._** In our square example, x is the formal parameter. (You may hear people say either “formal” alone or “parameter” alone when they’re feeling lazy.) **The technical term for the actual value of the argument is the _actual argument._** In a case like   
          
        ```lisp  
        (square (+ 5 9))  
        ```  
          
        you may want to distinguish the _**actual argument expression**_ `(+ 5 9)` from the _**actual argument value**_ 14. Most of the time it’s perfectly clear what you mean, and you just say “argument” for all of these things, but right now when you’re learning these ideas it’s important to be able to talk more precisely.  
  
* Procedure as Generalization  
    * What is generalization?  
          
        What’s the average of 17 and 25? To answer this question you could add the two numbers, getting 42, and divide that by two, getting 21. You could ask Scheme to do this for you:   
          
        ```lisp  
        > (/ (+ 17 25) 2) 21   
        ```  
          
        What’s the average of 14 and 68?   
          
        ```lisp  
        > (/ (+ 14 68) 2) 41   
        ```  
          
        Once you understand the technique, you could answer any such question by typing an expression of the form   
          
        ```lisp  
        (/ (+ ___ ___) 2)   
        ```  
          
        to Scheme.  
          
          
        But if you’re going to be faced with more such problems, an obvious next step is to _**generalize**_ the technique by defining a procedure:   
          
        ```lisp  
        (define (average a b)  
          (/ (+ a b) 2))  
        ```  
          
        With this definition, **you can think about the next problem that comes along in terms of the problem itself, rather than in terms of the steps required for its solution**:   
          
        ```lisp  
        > (average 27 4) 15.5   
        ```  
          
        This naming process is more important than it sounds, because **once we have a name for some idea, we can use that idea without thinking about its pieces**.  
  
* Composability  
    * What is composition of functions?  
          
        We’ve suggested that a procedure you define, such as `average`, is essentially similar to one that’s built into Scheme, such as `+`. In particular, **the rules for building expressions are the same whether the building blocks are primitive procedures or defined procedures**.   
          
        ```lisp  
        > (average (+ 10 8) (* 3 5))   
        16.5   
          
        > (average (average 2 3) (average 4 5))   
        3.5  
           
        > (sqrt (average 143 145))  
        12  
        ```  
          
        Any return value can be used as an end in itself, as the return value from `sqrt` was used in the last of these examples, or it can provide an argument to another procedure, as the return value from was used in the first of these examples.  
           
        These small examples may seem arbitrary, but the same idea, **_composition of functions_**, **is the basis for all Scheme programming**.  
  
* The Substitution Model  
    * What is a model?  
          
        A _**model**_ is a story that has just enough detail to help you understand whatever it’s trying to explain but not so much detail that you can’t see the forest for the trees.  
  
    * How does substitution model work?  
          
        Today’s story is about the _**substitution**_ model. When a procedure is invoked, the goal is to carry out the computation described in its body. The problem is that the body is written in terms of the formal parameters, while the computation has to use the actual argument values. So what Scheme needs is a way to associate actual argument values with formal parameters. It does this by **making a new copy of the body of the procedure, in which it substitutes the argument values for every appearance of the formal parameters, and then evaluating the resulting expression**. So, if you’ve defined `square` with   
          
        ```lisp  
        (define (square x)  
          (* x x))  
        ```  
          
        then the body of `square` is `(* x x)`. When you want to know the square of a particular number, as in (square 5), Scheme substitutes the 5 for x everywhere in the body of square and evaluates the expression. In other words, Scheme takes   
          
        ```lisp  
        (* x x)   
        ```  
          
        then does the substitution, getting   
          
        ```lisp  
        (* 5 5)  
        ```  
           
        and then evaluates that expression, getting 25.   
          
        If you just type `(* x x)` into Scheme, you will get an error message complaining that x doesn’t mean anything. Only after the substitution does this become a meaningful expression.   
          
        By the way, **when we talk about “substituting into the body,” we don’t mean that the procedure’s definition is changed in any permanent way. The body of the procedure doesn’t change; what happens, as we said before, is that Scheme constructs a new expression that looks like the body, except for the substitutions**.  
  
* Pitfalls  
      
    * a function can have only _one_ return value  
    * a procedure call doesn't change the value of a parameter  
    * A very common pitfall in Scheme comes from choosing the name of a procedure as a parameter. It isn’t a problem if the formal parameter is the name of a procedure that you don’t use inside the body. The problem arises when you try to use the same name with two meanings within a single procedure. But special forms are an exception; _**you can never use the name of a special form as a parameter**_.   
    * A similar problem about name conflicts comes up if you try to use a keyword (the name of a special form, such as define) as some other kind of name—either a formal parameter or the name of a procedure you’re defining.   
    * Formal parameters _must_ be words. The job of the procedure definition is only to provide a _name_ for the argument. The _actual_ argument isn’t pinned down until you invoke the procedure.  
* Exercises 4.1-4.3  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 4.1-4.3.scm][5]  
  
* Exercises 4.4-4.10  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 4.4-4.10.scm][6]  
  
[1]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%202.1-2.9.scm  
[2]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%203.1-3.9.scm  
[3]: dnd.png  
[4]: otc.png  
[5]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%204.1-4.3.scm  
[6]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%204.4-4.10.scm  
