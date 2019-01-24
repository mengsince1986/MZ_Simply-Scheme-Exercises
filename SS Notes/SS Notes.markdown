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
  
### Chapter 5 Words and Sentences  
  
* How to use word "square" itself rather than the value of that word as an expression.  
      
    If you just type `square` into Scheme, you will find out that square is a procedure:   
      
    ```lisp  
    > square  
    <PROCEDURE>  
    ```  
      
    What you need is a way to say that you want to use the word “square” _itself,_ rather than the _value_ of that word, as an expression. The way to do this is to use `quote`:   
      
    ```lisp  
    > (quote square)   
    SQUARE   
      
    > (quote (tomorrow never knows))   
    (TOMORROW NEVER KNOWS)  
       
    > (quote (things we said today))   
    (THINGS WE SAID TODAY)   
    ```  
  
* How does special form `quote` work?  
      
    `Quote` is a special form, since **its argument isn’t evaluated**. Instead, **it just returns the argument as is**.  
  
    * What is the abbreviation for `quote`?  
          
        Scheme programmers use `quote` a lot, so there is an abbreviation for it:   
          
        ```lisp  
        > ’square   
        SQUARE  
           
        > ’(old brown shoe)   
        (old brown shoe)   
        ```  
          
        Since Scheme uses the apostrophe as an abbreviation for `quote`, you can’t use one as an ordinary punctuation mark in a sentence. That’s why we’ve been avoiding titles like (can’t buy me love). To Scheme this would mean (can (quote t) buy me love)!   
          
        Actually, **it _is_ possible to put punctuation inside words as long as the entire word is enclosed in double-quote marks**, like this:   
          
        > ’("can’t" buy me love)   
        ("can’t" BUY ME LOVE)  
           
        Words like that are called _**strings**._ We’re not going to use them in any examples until almost the end of the book. **Stay away from punctuation and you won’t get in trouble. However, question marks and exclamation points are okay.** (**Ordinary words, the ones that are neither strings nor numbers, are officially called _symbols._**)  
  
* Selectors  
    * What are selectors?  
          
        So far all we’ve done with words and sentences is quote them. To do more interesting work, we need tools for two kinds of operations: We have to be able to take them apart, and we have to be able to put them together. We’ll start with **the take-apart tools; the technical term for them is _selectors._**  
  
    * How do procedures `first`, `last`, `butfirst` and `butlast` work?  
          
        ```lisp  
        > (first ’something)   
        S   
          
        > (first ’(eight days a week))   
        EIGHT   
          
        > (first 910)   
        9  
           
        > (last ’something)  
        G  
          
        > (last ’(eight days a week))  
        WEEK  
          
        > (last 910)   
        0   
          
        > (butfirst ’something)   
        OMETHING   
          
        > (butfirst ’(eight days a week))   
        (DAYS A WEEK)   
          
        > (butfirst 910)   
        10  
           
        > (butlast ’something)   
        SOMETHIN   
          
        > (butlast ’(eight days a week))   
        (EIGHT DAYS A)  
           
        > (butlast 910)   
        91   
        ```  
          
        > The procedures we’re about to show you are not part of standard, official Scheme. Scheme does provide ways to do these things, but the regular ways are somewhat more complicated and error-prone for beginners. We’ve provided a simpler way to do symbolic computing, using ideas developed as part of the Logo programming language.   
          
        Notice that **the `first` of a sentence is a word, while the `first` of a word is a letter.** (But there’s no separate data type called “letter”; a letter is the same as a one-letter word.) **The `butfirst` of a sentence is a sentence, and the `butfirst` of a word is a word. The corresponding rules hold for last and `butlast`**.   
          
        The names `butfirst` and `butlast` aren’t meant to describe ways to sled; they abbreviate “all but the first” and “all but the last.”  
  
    * How does selector `item` work?  
          
        There is, however, **a primitive selector `item` that takes two arguments, a number _n_ and a word or sentence, and returns the _n_th element of the second argument**.   
          
        ```lisp  
        > (item 4 ’(being for the benefit of mister kite!))   
        BENEFIT  
           
        > (item 4 ’benefit)   
        E   
        ```  
  
    * What is the difference between a sentence containing exactly one word and the word itself?  
          
        Don’t forget that a sentence containing exactly one word is different from the word itself, and selectors operate on the two differently:   
          
        ```lisp  
        > (first ’because)   
        B  
           
        > (first ’(because))  
        BECAUSE  
          
        > (butfirst ’because)   
        ECAUSE  
           
        > (butfirst ’(because))   
        ()   
          
        The value of that last expression is the _empty sentence._ You can tell it’s a sentence because of the parentheses, and you can tell it’s empty because there’s nothing between them.   
          
        ```lisp  
        > (butfirst ’a)   
        ""  
           
        > (butfirst 1024)   
        "024"  
        ```  
           
        As these examples show, sometimes `butfirst` returns a word that has to have double-quote marks around it. The first example shows the _empty word,_ while the second shows a number that’s not in its ordinary form. (Its numeric value is 24, but you don’t usually see a zero in front.)   
          
        ```lisp  
        > 024 24   
        > "024" "024"   
        ```  
          
        We’re going to try to avoid printing these funny words. But don’t be surprised if you see one as the return value from one of the selectors for words. (Notice that **you don’t have to put a single quote in front of the double quotes. Strings are self-evaluating, just as numbers are.**)  
  
    * What is the abbreviation of `butfirst` and `butlast`?  
          
        Since `butfirst` and `butlast` are so hard to type, there are abbreviations `bf` and `bl`.  
  
* Constructors  
    * What are constructors?  
          
        **Functions for putting things together are called _constructors._** For now, we just have two of them: `word` and `sentence`.  
  
    * How do `word` and `sentence` work?  
          
        **`Word` takes any number of words as arguments and joins them all together into one humongous word**:   
          
        ```lisp  
        > (word ’ses ’qui ’pe ’da ’lian ’ism)   
        SESQUIPEDALIANISM   
          
        > (word ’now ’here)  
        NOWHERE  
          
        > (word 35 893)   
        35893   
        ```  
          
        **`Sentence` is similar, but slightly different, since it can take both words and sentences as arguments**:   
          
        ```lisp  
        > (sentence ’carry ’that ’weight)   
        (CARRY THAT WEIGHT)  
           
        > (sentence ’(john paul) ’(george ringo))   
        (JOHN PAUL GEORGE RINGO)  
        ```  
           
        `Sentence` is also too hard to type, so there’s the abbreviation `se`.   
          
        ```lisp  
        > (se ’(one plus one) ’makes 2)   
        (ONE PLUS ONE MAKES 2)   
        ```  
          
        By the way, why did we have to quote makes in the last example, but not 2? It’s because numbers are **self-evaluating**, as we said in Chapter 3. **We have to quote `makes because otherwise Scheme would look for something named makes instead of using the word itself. But numbers can’t be the names of things; they represent themselves.** (In fact, you could quote the 2 and it wouldn’t make any difference)  
  
* First-Class Words and Sentences  
    * What are first-class words and sentences?  
          
        **A programming language should let you express your ideas in terms that match _your_ way of thinking, not the computer’s way**.  
          
        Technically, we say that words and sentences should be **_first-class data_** in our language. This means that **a sentence, for example, can be an argument to a procedure; it can be the value returned by a procedure; we can give it a name; and we can build aggregates whose elements are sentences**.  
  
* Pitfalls  
      
    * We’ve been avoiding **apostrophes** `'` in our words and sentences because they’re abbreviations for the quote special form. You must also avoid **periods** `.`, **commas** `,`, **semicolons** `;`, **quotation marks** `"`, **vertical bars** `|`, and, of course, **parentheses** `()`, since all of these have special meanings in Scheme. You may, however, use **question marks** `?` and **exclamation points** `!`.   
    * Although we’ve already mentioned the need to avoid names of primitives when choosing formal parameters, we want to remind you specifically about the names `word` and `sentence`. These are often very tempting formal parameters, because many procedures have words or sentences as their domains. We’ve been using `wd` and `sent` as formal parameters instead of `word` and `sentence`, and we recommend that practice.   
    * There’s a difference between a word and a single-word sentence. For example, people often fall into the trap of thinking that the `butfirst` of a two-word sentence such as (sexy sadie) is the second word, but it’s not. It’s a one-word-long sentence. For example, its count is one, not five.   
    * We mentioned earlier that sometimes Scheme has to put double-quote marks around words. Just ignore them; don’t get upset if your procedure returns `"6-of-hearts"` instead of just `6-of-hearts`.   
    * `Quote` doesn’t mean "print".   
    * If you see an error message like   
    ```lisp  
    > (+ 3 (bf 1075))   
    ERROR: INVALID ARGUMENT TO +: "075"  
    ```  
       
    try entering the expression   
      
    ```lisp  
    > (strings-are-numbers #t)   
    OKAY  
    ```  
       
    and try again. (The extension to Scheme that allows arithmetic operations to work on nonstandard numbers like "075" makes ordinary arithmetic slower than usual. So we’ve provided a way to turn the extension on and off. Invoking strings-are-numbers with the argument #f turns off the extension.)*  
  
* Exercises 5.1-5.12  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 5.1-5.12.scm][7]  
  
* Exercises 5.13-5.21  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 5.13-5.21.scm][8]  
  
### Chapter 6 True and False  
  
* What are the two values of Booleans in Scheme?  
      
    Scheme includes a special data type called _**Booleans**_ to represent true or false values. There are just two of them: `#t` for “true” and `#f` for “false.”  
  
* Predicates  
    * What is a **predicate**?  
          
        A function that returns either #t or #f is called a _**predicate**._   
          
        > Why is it called that? Think about an English sentence, such as “Ringo is a drummer.” As you may remember from elementary school, “Ringo” is the _subject_ of that sentence, and “is a drummer” is the _predicate._ That predicate could be truthfully attached to some subjects but not others. For example, it’s true of “Neil Peart” but not of “George Harrison.” So the predicate “is a drummer” can be thought of as a function whose value is true or false.  
  
    * Why are the names of predicates in Scheme end with a question mark?  
          
        It’s a convention in Scheme that the names of predicates end with a question mark, but that’s just a convention.  
  
    * Common Scheme predicates  
        * `equal?`  
              
            You’ve already seen the `equal?` predicate. It takes two arguments, which can be of any type, and returns #t if the two arguments are the same value, or #f if they’re different.  
  
        * `member?`  
              
            ```lisp  
            (member? ’mick ’(dave dee dozy beaky mick and tich))   
            T  
            (member? ’mick ’(john paul george ringo))  
            F   
            (member? ’e ’truly)   
            F   
            (member? ’y ’truly)   
            T  
            ```  
              
            `Member?` takes two arguments; it checks to see if the first one is a member of the second.  
  
        * `=`, `>`, `<`, `>=`, and `<=`  
              
            ```lisp  
            (= 3 4)  
            F   
            (= 67 67)  
            T  
            (> 98 97)  
            T  
            ```  
              
            The `=`, `>`, `<`, `>=`, and `<=` functions take two numbers as arguments and do the obvious comparisons. (By the way, these are exceptions to the convention about question marks.)  
  
        * `before?`  
              
            ```lisp  
            (before? ’zorn ’coleman)   
            F  
            (before? ’pete ’ringo)   
            T   
            ```  
              
            `Before?` is like `<`, but it compares two words alphabetically.  
  
        * `empty?`  
              
            ```lisp  
            (empty? ’(abbey road))  
            F  
            (empty? ’())  
            T  
            (empty? ’hi)  
            F  
            (empty? (bf (bf ’hi)))   
            T  
            (empty? "")  
            T  
            ```  
              
            `Empty?` checks to see if its argument is either the empty word or the empty sentence.  
  
        * predicates to test the type of their arguments  
            * `number?`  
                  
                ```lisp  
                (number? ’three)   
                F  
                (number? 74)  
                T   
                ```  
  
            * `boolean?`  
                  
                ```lisp  
                (boolean? #f)  
                T  
                (boolean? ’(the beatles))   
                F   
                (boolean? 234)   
                F  
                (boolean? #t)   
                T   
                ```  
  
            * `word?`  
                  
                ```lisp  
                (word? ’flying)   
                T  
                (word? ’(dig it))   
                F   
                (word? 87)  
                T  
                ```  
  
            * `sentence?`  
                  
                ```lisp  
                > (sentence? ’wait)  
                F  
                > (sentence? ’(what goes on))   
                T   
                ```  
  
        * define new predicates  
              
            ```lisp  
            (define (vowel? letter)   
                (member? letter ’aeiou))   
              
            (define (positive? number)   
                (> number 0))   
            ```  
  
    * What is the difference between `equal?` and `=` in Scheme?  
          
        Why do we have both `equal?` and `=` in Scheme? The first of these works on any kind of Scheme data, while the second is defined only for numbers. You could get away with always using `equal?`, but the more specific form makes your program more self-explanatory; people reading the program know right away that you’re comparing numbers.  
  
* Using Predicates  
    * How to write a procedure that returns the absolute value of a number?  
          
        Here’s a procedure that returns the absolute value of a number:   
          
        ```lisp  
        (define (abs num)   
          (if (< num 0)   
              (- num)   
              num))  
        ```   
          
        (**If you call `-` with just one argument, it returns the negative of that argument**.) Scheme actually provides `abs` as a primitive procedure, but we can redefine it.  
  
    * How to write a buzz game procedure?  
          
        Do you remember how to play buzz? You’re all sitting around the campfire and you go around the circle counting up from one. Each person **says a number**. If your number is **divisible by seven or if one of its digits is a seven**, then instead of calling out your number, you **say "buzz"**.   
          
        ```lisp  
        (define (buzz num)  
          (if (or (divisible? num 7) (member? 7 num))   
              ’buzz   
               num))   
          
        (define (divisible? big little)   
          (= (remainder big little) 0))   
        ```  
  
        * How does `or` work?  
              
            **`Or`** can take any number of arguments, each of which must be true or false. It returns true if any of its arguments are true, that is, if the first argument is true _or_ the second argument is true _or_. . .  
  
        * What are the 3 functions in Scheme that combine true or false values to produce another true or false value?  
              
            **`Or`** is one of _**three functions in Scheme that combine true or false values to produce another true or false value**_. **`And`** returns true if all of its arguments are true, that is, the first _and_ second _and_. . . Finally, there’s a function **`not`** that takes exactly one argument, returning true if that argument is false and vice versa.  
  
        * How does procedure `remainder` work?  
              
            **`Remainder`**, as you know, takes two integers and tells you what the remainder is when you divide the first by the second. If the remainder is zero, the first number is divisible by the second.  
  
        * What is a **helper procedure**?  
              
            In the last example, the procedure we really wanted to write was `buzz`, but we found it useful to define `divisible?` also. It’s quite common that the easiest way to solve some problem is to write a _**helper procedure**_ to do part of the work. In this case the helper procedure computes a function that’s meaningful in itself, but sometimes you’ll want to write procedures with names like **_buzz-helper_** that are useful only in the context of one particular problem.  
  
    * How to write a `plural` procedure that returns the plural of a word?  
          
        Let’s write a program that takes a word as its argument and returns the plural of that word. Our first version will just put an “s” on the end:   
          
        ```lisp  
        (define (plural wd)  
          (word wd ’s))  
          
        (plural ’beatle)   
        ; BEATLES   
          
        (plural ’computer)   
        ; COMPUTERS   
          
        (plural ’fly)   
        ; FLYS   
        ```  
          
        This works for most words, but not those that end in “y.” Here’s version two:   
          
        ```lisp  
        (define (plural wd)  
          (if (equal? (last wd) ’y)   
              (word (bl wd) ’ies)   
              (word wd ’s)))   
        ```  
          
        This isn’t exactly right either; it thinks that the plural of “boy” is “boies.” We’ll ask you to add some more rules in Exercise 6.12.  
  
* `If` is a special form  
    * How does `if` work?  
          
        **`if`** is a special form. Remember that we’re going to need the value of only one of its last two arguments. It would be wasteful for Scheme to evaluate the other one. So if you say   
          
        ```lisp  
        (if (= 3 3)  
            ’sure  
            (factorial 1000))  
        ```  
          
        `if` won’t compute the factorial of 1000 before returning _sure_.  
           
        **The rule is that `if` always evaluates its first argument. If the value of that argument is true, then `if` evaluates its second argument and returns its value. If the value of the first argument is false, then if evaluates its third argument and returns that value.**  
  
* So Are `and` and `or`  
    * How does `and` and `or` work?  
          
        **`And` and `or` are also special forms**. They evaluate their arguments in order from left to right and stop as soon as they can. For `or`, this means returning true as soon as any of the arguments is true. `And` returns false as soon as any argument is false.  
  
    * How does `and` work in procedure `num-divisible-by-4?`?  
          
        ```lisp  
        (define (divisible? big small)   
          (= (remainder big small) 0))   
          
        (define (num-divisible-by-4? x)  
          (and (number? x) (divisible? x 4)))   
          
        (num-divisible-by-4? 16) ;T  
          
        (num-divisible-by-4? 6) ;F   
          
        (num-divisible-by-4? ’aardvark) ;F   
          
        (divisible? ’aardvark 4) ;ERROR: AARDVARK IS NOT A NUMBER   
        ```  
          
        We want to see if x is a number, and, if so, if it’s divisible by 4. It would be an error to apply `divisible?` to a non number. If `and` were an ordinary procedure, the two tests (`number?` and `divisible?`) would both be evaluated before we would have a chance to pay attention to the result of the first one. Instead, if x turns out not to be a number, our procedure will return `#f` without trying to divide it by 4.  
  
* Everything That Isn't False Is True  
    * What are semipredicates?  
          
        **#T isn’t the only true value. In fact, _every_ value is considered true except for #f.**   
          
        ```lisp  
        (if (+ 3 4) ’yes ’no)   
        ; YES   
        ```  
          
        This allows us to have **_semipredicates_** that give slightly more information than just true or false.   
          
        For example, we can write an integer quotient procedure. That is to say, our procedure will divide its first argument by the second, but only if the first is evenly divisible by the second. If not, our procedure will return #f.   
          
        ```lisp  
        (define (integer-quotient big little)   
          (if (divisible? big little)   
              (/ big little)  
        f))  
          
        (integer-quotient 27 3) ;9   
          
        (integer-quotient 12 5) ;#F   
          
        ```  
  
    * Why `and` and `or` are also semipredicates  
          
        **`and` and `or` are also semipredicates.**  
          
        We’ve already explained that `or` returns a true result as soon as it evaluates a true argument. **The particular true value that `or` returns is the value of that first true argument**:   
          
        ```lisp  
        (or #f 3 #f 4) ;3   
        ```  
          
        **`and` returns a true value only if all of its arguments are true. In that case, it returns the value of the last argument**:   
          
        ```lisp  
        (and 1 2 3 4 5) ;5   
        ```  
          
        As an example in which this behavior is useful, we can rewrite integer-quotient more tersely:  
          
        ```lisp   
        (define (integer-quotient big little)       ;; alternate version   
          (and (divisible? big little)   
               (/ big little)))   
        ```  
  
* Decisions, Decisions, Decisions  
    * When is `cond` used?  
          
        `if` is great for an either-or choice. But sometimes there are several possibilities to consider:   
          
        ```lisp  
        (define (roman-value letter)   
          (if (equal? letter ’i)   
              1  
              (if (equal? letter ’v)  
                  5  
                  (if (equal? letter ’x)   
                      10  
                      (if (equal? letter ’l)   
                          50  
                          (if (equal? letter ’c)   
                              100  
                              (if (equal? letter ’d)   
                                  500  
                                  (if (equal? letter ’m)  
                                      1000  
                                      ’huh?))))))))  
        ```  
          
        That’s pretty hideous. Scheme provides a shorthand notation for situations like this in which you have to choose from among several possibilities: the special form `cond`.   
          
        ```lisp  
        (define (roman-value letter)   
          (cond ((equal? letter ’i) 1)   
                ((equal? letter ’v) 5)   
                ((equal? letter ’x) 10)   
                ((equal? letter ’l) 50)   
                ((equal? letter ’c) 100)   
                ((equal? letter ’d) 500)   
                ((equal? letter ’m) 1000)   
                (else ’huh?)))   
        ```  
          
        **The tricky thing about `cond` is that it doesn’t use parentheses in quite the same way as the rest of Scheme. Ordinarily, parentheses mean procedure invocation. In `cond`, _most_ of the parentheses still mean that, but _some_ of them are used to group pairs of tests and results**.  
  
    * How does `cond` work?  
          
        `cond` takes any number of arguments, each of which is _**two expressions**_ inside a pair of parentheses. Each argument is called a _**cond clause**._ In the example above, one typical clause is   
          
        > **(**(equal? letter ’l) 50 **)**   
          
        The outermost parentheses on that line enclose two expressions. The first of the two expressions (the _**condition**_) is taken as true or false, just like the first argument to `if`. The second expression of each pair (the _consequent_) is a candidate for the return value of the entire `cond` invocation.   
          
        `cond` examines its arguments from left to right. Remember that **since `cond` is a special form, its arguments are not evaluated ahead of time. For each argument, `cond` evaluates the first of the two expressions within the argument. If that value turns out to be true, then `cond` evaluates the second expression in the same argument, and returns that value without examining any further arguments. But if the value is false, then `cond` does _not_ evaluate the second expression; instead, it goes on to the next argument.**  
          
        > Conditions are mutually exclusive if only one of them can be true at a time.   
          
        When a `cond` tests several possible conditions, they might not be mutually exclusive. This can be either a source of error or an advantage in writing efficient programs. The trick is to make the _**most restrictive**_ test first. For example, it would be an error to say   
          
        ```lisp  
        (cond ((number? (first sent)) ...)    ;; wrong   
              ((empty? sent) ...)   
        ...)  
        ```  
        because the first test only makes sense once you’ve already established that there _is_ a first word of the sentence. On the other hand, you don’t have to say   
          
        ```lisp  
        (cond ((empty? sent) ...)  
              ((and (not (empty? sent)) (number? (first sent))) ...)   
              ...)   
        ```  
        because you’ve already established that the sentence is nonempty if you get as far as the second clause.  
  
    * How to use `else`?  
          
        By convention, the last argument always starts with the word `else` instead of an expression. You can think of this as representing a true value, but **`else` doesn’t mean true in any other context; you’re only allowed to use it as the condition of the last clause of a `cond`**.   
          
        > What if you don’t use an `else` clause at all? If none of the clauses has a true condition, then the return value is unspecified. In other words, **always use `else`**.   
           
          
        **Don’t get into bad habits of thinking about the appearance of `cond` clauses in terms of “two parentheses in a row.”** That’s often the case, but not always. For example, here is a procedure that translates Scheme true or false values (`#t` and `#f`) into more human-readable words true and false.   
          
        ```lisp  
        (define (truefalse value)   
          (cond (value ’true)   
          (else ’false)))   
          
        (truefalse (= 2 (+ 1 1))) ;TRUE  
           
        (truefalse (= 5 (+ 2 2))) ;FALSE   
        ```  
  
* `if` is composable  
    * How to write a `greet` function with composable `if` functions?  
          
        Suppose we want to write a greet procedure that works like this:   
          
        ```lisp  
        (greet ’(brian epstein))  
        ; (PLEASED TO MEET YOU BRIAN -- HOW ARE YOU?)   
          
        (greet ’(professor donald knuth))  
        ; (PLEASED TO MEET YOU PROFESSOR KNUTH -- HOW ARE YOU?)   
        ```  
          
        The response of the program in these two cases is almost the same; the only difference is in the form of the person’s name.   
          
        This procedure could be written in two ways:   
          
        ```lisp  
        (define (greet name)  
          (if (equal? (first name) ’professor)   
              (se ’(pleased to meet you)   
                   ’professor   
                   (last name)   
                   ’(-- how are you?))   
              (se ’(pleased to meet you)   
                  (first name)  
                  ’(-- how are you?))))  
          
        (define (greet name)  
          (se ’(pleased to meet you)   
              (if (equal? (first name) ’professor)   
                  (se ’professor (last name))   
                  (first name))   
              ’(-- how are you?)))  
        ```  
          
        The second version avoids repeating the common parts of the response by using `if` within a larger expression.  
  
    * Are All the functions in Scheme composable?  
          
        Some people find it counterintuitive to use `if` as we did in the second version. Perhaps the reason is that in some other programming languages, `if` is a “command” instead of a function like any other. A mechanism that selects one part of a program to run, and leaves out another part, may seem too important to be a mere argument subexpression. But **in Scheme, the value returned by _every_ function can be used as part of a larger expression**.   
          
        > Strictly speaking, since the argument expressions to a special form aren’t evaluated, `if` is a function whose domain is expressions, not their values. But many special forms, including `if`, `and`, and `or`, are designed to act as if they were ordinary functions, the kind whose arguments Scheme evaluates in advance. The only difference is that it is sometimes possible for Scheme to figure out the correct return value after evaluating only some of the arguments. Most of the time we’ll just talk about the domains and ranges of these special forms as if they were ordinary functions.  
  
* Pitfalls  
      
    * The biggest pitfall in this chapter is the unusual notation of `cond`. **Keeping track of the parentheses that mean function invocation, as usual, and the parentheses that just group the parts of a `cond` clause** is tricky until you get accustomed to it.   
    * Many people also have trouble with the asymmetry of the `member?` predicate. The first argument is something small; the second is something big. (The order of arguments is the same as the order of a typical English sentence about membership: “Is Mick a member of the Beatles?”)   
    * Many people try to use and and or with the full flexibility of the corresponding English words. Alas, Scheme is not English. For example, suppose you want to know whether the argument to a procedure is either the word yes or the word no. You can’t say   
      
    ```lisp  
    (equal? argument (or ’yes ’no)) ; wrong!   
    ```  
    This sounds promising: “Is the argument equal to the word yes or the word no?” But **the arguments to `or` must be true-or-false values, not things you want to check for equality with something else**. You have to make two separate equality tests:   
      
    ```lisp  
    (or (equal? argument ’yes) (equal? argument ’no))   
    ```  
    In this particular case, you could also solve the problem by saying   
      
    ```lisp  
    (member? argument ’(yes no))  
    ```  
      
    but the question of trying to use `or` as if it were English comes up in other cases for which `member?` won’t help.  
      
    * This isn’t exactly a pitfall, because it won’t stop your program from working, but programs like   
      
    ```lisp  
    (define (odd? n)  
      (if (not (even? n)) #t #f))  
    ```  
    are redundant. Instead, you could just say   
      
    ```lisp  
    (define (odd? n)  
      (not (even? n)))  
    ```  
      
    since the value of (not (even? n)) is already #t or #f.  
  
* Exercises 6.1-6.4  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 6.1-6.4.scm][9]  
  
* Exercises 6.5-6.14  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 6.5-6.14.scm][10]  
  
[1]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%202.1-2.9.scm  
[2]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%203.1-3.9.scm  
[3]: dnd.png  
[4]: otc.png  
[5]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%204.1-4.3.scm  
[6]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%204.4-4.10.scm  
[7]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%205.1-5.12.scm  
[8]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%205.13-5.21.scm  
[9]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%206.1-6.4.scm  
[10]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%206.5-6.14.scm  
