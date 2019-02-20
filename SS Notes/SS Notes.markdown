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
  
### Chapter 7 Variables  
  
* What is a variable?  
      
    A _**variable**_ is a connection between a name and a value.  
  
* Where does the name variable come from?  
      
    The name _**variable**_ comes from algebra. Many people are introduced to variables in high school algebra classes, where the emphasis is on solving equations. “If _x_ 3 − 8 = 0, what is the value of _x_?” In problems like these, although we call _x_ a variable, it’s really a _named constant!_ In this particular problem, _x_ has the value 2. **In any such problem, at first we don’t know the value of _x_, but we understand that it does have some particular value, and that value isn’t going to change in the middle of the problem**.  
  
* Is a formal parameter variable?  
      
    In functional programming, what we mean by “variable” is like a named constant in mathematics. Since a variable is the connection between a name and a value, **a formal parameter in a procedure definition isn’t a variable; it’s just a name. But when we invoke the procedure with a particular argument, that name is associated with a value, and a variable is created. If we invoke the procedure again, a _new_ variable is created, perhaps with a different value**.  
  
* What are the two possible sources of confusion about variables?  
      
    There are two possible sources of confusion about this. One is that **you may have programmed before in a programming language like BASIC or Pascal, in which a variable often _does_ get a new value, even after it’s already had a previous value assigned to it**. Programs in those languages tend to be full of things like “X = X + 1.” Back in Chapter 2 we told you that this book is about something called “functional programming,” but we haven’t yet explained exactly what that means. (Of course we _have_ introduced a lot of functions, and that is an important part of it.) Part of what we mean by functional programming is that once a variable exists, we aren’t going to _change_ the value of that variable.   
      
    The other possible source of confusion is that **in Scheme, unlike the situation in algebra, we may have more than one variable with the same name at the same time.** That’s because we may invoke one procedure, and the body of that procedure may invoke another procedure, and each of them might use the same formal parameter name. There might be one variable named x with the value 7, and another variable named x with the value 51, at the same time. The pitfall to avoid is thinking “x has changed its value from 7 to 51.”  
  
* How Little People Do Variables?  
    * Does the inner procedure know the values of the local variables that belong to the upper procedure?  
          
        Another important point about **the way little people do variables is that they can’t read each others’ minds. In particular, they don’t know about the values of the local variables that belong to the little people who hired them.** For example, the following attempt to compute the value 10 won’t work:   
          
        ```lisp  
        (define (f x)  
          (g 6))  
          
        (define (g y)  
          (+ x y))  
            
        (f 4)  
        ; ERROR -- VARIABLE X IS UNBOUND.   
        ```  
        We hire Franz to compute (f 4). He associates x with 4 and evaluates (g 6) by hiring Gloria. Gloria associates y with 6, but she doesn’t have any value for x, so she’s in trouble.   
          
        The solution is for Franz to tell Gloria that x is 4:   
          
        ```lisp  
        (define (f x)  
          (g x 6))  
          
        (define (g x y)  
          (+ x y))  
          
        (f 4) 10   
        ```  
  
* Global and Local Variables  
    * How to define a global variable?  
          
        Just as we’ve been using `define` to associate names with procedures globally, we can also use it for other kinds of data:   
          
        (define pi 3.141592654)  
          
        (+ pi 5) ;8.141592654  
          
        (define song ’(I am the walrus))  
           
        (last song) ;WALRUS  
           
        **Once defined, a global variable can be used anywhere**, just as a defined procedure can be used anywhere.   
          
        **When the name of a global variable appears in an expression, the corresponding value must be substituted, just as actual argument values are substituted for formal parameters.**   
          
        > (What if there is a global variable whose name happens to be used as a formal parameter in this procedure? Scheme’s rule is that the formal parameter takes precedence, but even though Scheme knows what to do, conflicts like this make your program harder to read.)  
  
    * What is a local variable?  
          
        The association of a formal parameter (a name) with an actual argument (a value) is called a _**local variable**._  
  
* The Truth about Substitution  
    * How does `let` work in Scheme?  
          
        We’re going to write a procedure that solves **quadratic equations**.   
          
        ![][11]  
          
        ```lisp  
        (define (roots a b c)  
          (se (/ (+ (- b) (sqrt (- (* b b) (* 4 a c))))   
                 (* 2 a))  
              (/ (- (- b) (sqrt (- (* b b) (* 4 a c))))   
                 (* 2 a))))   
        ```  
          
        One thing we can do is to compute the square root and use that as the actual argument to a helper procedure that does the rest of the job:   
          
        ```lisp  
        (define (roots a b c)  
          (roots1 a b c (sqrt (- (* b b) (* 4 a c)))))   
          
        (define (roots1 a b c discriminant)  
          (se (/ (+ (- b) discriminant) (* 2 a))   
              (/ (- (- b) discriminant) (* 2 a))))   
        ```  
          
        We’ve solved the problem we posed for ourselves initially: avoiding the redundant computation of the discriminant (the square-root part of the formula). The cost, though, is that we had to define an auxiliary procedure roots1 that doesn’t make much sense on its own. (That is, you’d never invoke roots1 for its own sake; only roots uses it.)   
          
        **Scheme provides a notation to express a computation of this kind more conveniently. It’s called `let`**:   
          
        ```lisp  
        (define (roots a b c)  
          (let ((discriminant (sqrt (- (* b b) (* 4 a c)))))   
            (se (/ (+ (- b) discriminant) (* 2 a))  
                (/ (- (- b) discriminant) (* 2 a)))))   
        ```  
          
        Our new program is just an abbreviation for the previous version: In effect, it creates a temporary procedure just like roots1, but without a name, and invokes it with the specified argument value. But the let notation rearranges things so that we can say, in the right order, “let the variable discriminant have the value (sqrt. . .) and, using that variable, compute the body.”   
          
        **`Let` is a special form that takes two arguments. The first is a sequence of name-value pairs enclosed in parentheses. (In this example, there is only one name-value pair.) The second argument, the _body_ of the let, is the expression to evaluate.**   
          
        Now that we have this notation, we can use it with more than one name-value connection to eliminate even more redundant computation:  
          
        ```lisp   
        (define (roots a b c)  
          (let ((discriminant (sqrt (- (* b b) (* 4 a c))))   
                (minus-b (- b))   
                (two-a (* 2 a)))  
            (se (/ (+ minus-b discriminant) two-a)   
                (/ (- minus-b discriminant) two-a))))  
        ```  
          
        In this example, the first argument to `let` includes three name-value pairs. It’s as if we’d defined and invoked a procedure like the following:   
          
        ```lisp  
        (define (roots1 discriminant minus-b two-a) ...)   
        ```  
          
        Like `cond`, **`let` uses parentheses both with the usual meaning (invoking a procedure) and to group sub-arguments that belong together. This grouping happens in two ways. Parentheses are used to group a name and the expression that provides its value. Also, an additional pair of parentheses surrounds the entire collection of name-value pairs.**  
  
* Pitfalls  
      
    * ⇒ If you’ve programmed before in other languages, you may be accustomed to a style of programming in which you _change_ the value of a variable by assigning it a new value. You may be tempted to write   
    ```lisp  
    > (define x (+ x 3)) ;; no-no  
    ```   
    Although some versions of Scheme do allow such redefinitions, so that you can correct errors in your procedures, they’re not strictly legal. **A definition is meant to be _permanent_ in functional programming**.   
      
    * **When you create more than one temporary variable at once using let, all of the expressions that provide the values are computed before any of the variables are created. Therefore, you can’t have one expression depend on another**:   
    ```lisp  
    (let ((a (+ 4 7))  ;; wrong!   
            (b (* a 5)))   
        (+ a b))  
    ```  
    Don’t think that `a` gets the value 11 and therefore `b` gets the value 55. That `let` expression is equivalent to defining a helper procedure   
      
    ```lisp  
    (define (helper a b)  
      (+ a b))  
    ```  
    and then invoking it:  
    ```lisp  
    (helper (+ 4 7) (* a 5))  
    ```  
    **The argument expressions, as always, are evaluated _before_ the function is invoked.** The expression (* a 5) will be evaluated using the _global_ value of a, if there is one. If not, an error will result. If you want to use a in computing b, you must say   
    ```lisp  
    (let ((a (+ 4 7)))  
      (let ((b (* a 5)))  
        (+ a b)))   
    ;66  
    ```   
      
    * `**Let**`’s notation is tricky because, like `**cond**`, it uses parentheses that don’t mean procedure invocation. Don’t teach yourself magic formulas like “two open parentheses before the let variable and three close parentheses at the end of its value.” Instead, think about the overall structure:   
      
    >(let variables body)  
      
    `**Let**` takes exactly two arguments. The first argument to `**let**` is one or more name-value groupings, all in parentheses:   
      
    >((name1 value1) (name2 value2) (name3 value3) . . .)   
      
    **Each name is a single word; each value can be any expression, usually a procedure invocation**. If it’s a procedure invocation, then parentheses are used with their usual meaning.   
      
    **The second argument to `let` is the expression to be evaluated using those variables**.   
      
    Now put all the pieces together:   
      
    > (let ((name1 (fn1 arg1))  
            (name2 (fn2 arg2))   
            (name3 (fn3 arg3)))   
        body)  
  
* Exercises 7.1-7.2  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 7.1-7.2.scm][12]  
  
* Exercises 7.3-7.4  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 7.3-7.4.scm][13]  
  
## Part III Functions as Data  
  
### Chapter 8 Higher-Order Functions  
  
* `every`  
    * How does `every` work?  
          
        ```scheme  
        (define (first-letters sent)   
          (every first sent))   
          
        (first-letters ’(here comes the sun)) ;(H C T S)   
          
        (first-letters ’(lucy in the sky with diamonds)) ;(L I T S W D)   
        ```  
          
        **`every` takes two arguments. The second argument is a sentence, but the `first` is something new: a _procedure_ used as an argument to another procedure.** Notice that there are no parentheses around the word first in the body of first-letters! By now you’ve gotten accustomed to seeing parentheses whenever you see the name of a function. But **parentheses indicate an _invocation_ of a function, and we aren’t invoking `first` here. We’re using `first`, the procedure itself, as an argument to every**.  
  
    * What is **higher-order function/procedure**?  
          
        **A function that takes another function as one of its arguments, as `every` does, is called a _higher-order function._** If we focus our attention on procedures, the mechanism through which Scheme computes functions, we think of `every` as a procedure that takes another procedure as an argument—a **_higher-order procedure._**  
  
* `keep`  
    * How does `keep` work?  
          
        **The `keep` function takes a predicate and a sentence as arguments. It returns a sentence containing only the words of the argument sentence for which the predicate is true.**   
          
        ```scheme  
        (keep even? ’(1 2 3 4 5)) ;(2 4)   
        ```  
          
        `keep` will also accept a word as its second argument. In this case, it applies the predicate to every letter of the word and returns another word:   
          
        ```scheme  
        (keep number? ’zonk23hey9) ;239   
        ```  
  
* `accumulate`  
    * What is the difference between `accumulate` and `every`/`keep`?  
          
        **In `every` and `keep`, each element of the second argument contributes _independently_ to the overall result.** That is, `every` and `keep` apply a procedure to a single element at a time. The overall result is a collection of individual results, with no interaction between elements of the argument. This doesn’t let us say things like “Add up all the numbers in a sentence,” where the desired output is a function of the entire argument sentence taken as a whole. We can do this with a procedure named `accumulate`.  
  
    * How does `accumulate` work?  
          
        **`accumulate` takes a procedure and a sentence as its arguments. It applies that procedure to two of the words of the sentence. Then it applies the procedure to the result we got back and another element of the sentence, and so on. It ends when it’s combined all the words of the sentence into a single result.**   
          
        ```scheme  
        (accumulate + ’(6 3 4 -5 7 8 9)) ;32  
           
        (accumulate word ’(a c l u)) ;ACLU   
          
        (accumulate max ’(128 32 134 136)) ;136  
           
        (define (hyphenate word1 word2)   
          (word word1 ’- word2))   
          
        (accumulate hyphenate ’(ob la di ob la da)) ;OB-LA-DI-OB-LA-DA   
        ```  
          
        `accumulate` can also take a word as its second argument, using the letters as elements:   
          
        ```scheme  
        (accumulate + 781) ;16   
        (accumulate sentence ’colin) ;(C O L I N)   
        ```  
  
* Combining Higher-Order Functions  
    * How to use combined higher-order functions to add up all the numbers in a sentence?  
          
        What if we want to add up all the numbers in a sentence but ignore the words that aren’t numbers? First we `keep` the numbers in the sentence, then we `accumulate` the result with `+`. It’s easier to say in Scheme:   
          
        ```scheme  
        (define (add-numbers sent)   
          (accumulate + (keep number? sent)))   
          
        (add-numbers ’(4 calling birds 3 french hens 2 turtle doves)) ;9   
          
        (add-numbers ’(1 for the money 2 for the show 3 to get ready and 4 to go)) ;10   
        ```  
  
    * How to use combined higher-order functions to write a `count` procedure?  
          
        We also have enough tools to write a version of the `count` procedure, which finds the number of words in a sentence or the number of letters in a word.   
          
        First, we’ll define a procedure `always-one` that returns 1 no matter what its argument is. We’ll `every` `always-one` over our argument sentence, which will result in a sentence of as many ones as there were words in the original sentence. Then we can use `accumulate` with `+` to add up the ones.   
          
        ```lisp  
        (define (always-one arg)   
          
        (define (count sent)  
          (accumulate + (every always-one sent)))  
           
        (count ’(the continuing story of bungalow bill))   
        ;6   
        ```  
  
    * How to use combined higher-order functions to write an `acronym` procedure?  
          
        You can now understand the `acronym` procedure from Chapter 1:   
          
        ```scheme  
        (define (acronym phrase)   
          (accumulate word (every first (keep real-word? phrase))))   
          
        (acronym ’(reduced instruction set computer)) ;RISC  
           
        (acronym ’(structure and interpretation of computer programs)) ;SICP   
        ```  
  
* Choosing the Right Tool  
    * When to use `every`?  
          
        **`every` transforms each element of a word or sentence individually. The result sentence usually contains as many elements as the argument.**   
          
        > What we mean by “usually” is that `every` is most often used with an argument function that returns a single word. If the function returns a sentence whose length might not be one, then the number of words in the overall result could be anything!   
          
        ![][14]  
  
    * When to use `keep`?  
          
        **`keep` selects certain elements of a word or sentence and discards the others. The elements of the result are elements of the argument, without transformation, but the result may be smaller than the original.**   
          
        ![][15]  
  
    * When to use `accumulate`?  
          
        **`accumulate` transforms the entire word or sentence into a single result by combining all of the elements in some way.**   
          
        ![][16]  
  
    * What is the difference between `every`, `keep` and `accumulate`?  
          
        ![][17]  
  
* First-Class Functions and First-Class Sentences  
    * What are the two aspects of Scheme that permit the higher-order function expressions?  
          
        Two aspects of Scheme combine to permit this mode of expression.   
          
        One, which we’ve mentioned earlier, is that **sentences are first-class data. You can use an entire sentence as an argument to a procedure.** You can type a quoted sentence in, or you can compute a sentence by putting words together.   
          
        The second point is that **functions are also first-class. This lets us write a procedure like `pigl` that applies to a single word, and then combine that with every to translate an entire sentence to Pig Latin.** If Scheme didn’t have first-class functions, we couldn’t have general-purpose tools like `keep` and `every`, because we couldn’t say which function to extend to all of a sentence. You’ll see later that without every it would still be possible to write a specific `pigl-sent` procedure and separately write a `first-letters` procedure. But **the ability to use a procedure as argument to another procedure lets us _generalize_ the idea of “apply this function to every word of the sentence.**”  
  
* Repeated  
    * How does `repeated` work?  
          
        **The procedure `repeated` takes two arguments, a procedure and a number, and returns a new procedure. The returned procedure is one that invokes the original procedure repeatedly.**   
          
        For example, (repeated bf 3) returns a function that takes the `butfirst` of the `butfirst` of the `butfirst` of its argument.   
          
        Notice that all our examples start with two open parentheses. If we just invoked repeated at the Scheme prompt, we would get back a procedure, like this:   
        ```scheme  
        (repeated square 4)   
        ; #<PROCEDURE>   
        ```  
          
        The procedure that we get back isn’t very interesting by itself, so we invoke it, like this:   
        ```scheme  
        ((repeated square 4) 2)   
        ;65536  
        ```  
          
        All along we’ve been saying that you evaluate a compound expression in two steps: First, you evaluate all the subexpressions. Then you apply the first value, which has to be a procedure, to the rest of the values. But until now the first subexpression has always been just a single word, the name of a procedure. Now we see that **the first expression might be an invocation of a higher-order function, just as any of the argument subexpressions might be function invocations.**  
  
    * How to use `repeated` to define `item`?  
          
        We can use `repeated` to define `item`, which returns a particular element of a sentence:   
          
        ```scheme  
        (define (item n sent)  
         (first ((repeated bf (- n 1)) sent)))   
          
        (item 1 ’(a day in the life))  
        ;A  
          
        (item 4 ’(a day in the life))  
        ;THE  
        ```  
  
* Pitfalls  
    * Some people seem to fall in love with `every` and try to use it in all problems, even when `keep` or `accumulate` would be more appropriate.  
    * If you find yourself using a predicate function as the first argument to `every`, you almost certainly mean to use `keep` instead.  
          
        For example, we want to write a procedure that determines whether any of the words in its argument sentence are numbers:   
        ```scheme  
        (define (any-numbers? sent)   
          (accumulate or (every number? sent))) ;; wrong!    
        ```  
        This is wrong for two reasons. First, **since Boolean values aren’t words, they can’t be members of sentences**:   
          
        ```scheme  
        (sentence #T #F)  
        ERROR: ARGUMENT TO SENTENCE NOT A WORD OR SENTENCE: #F   
        (every number? ’(a b 2 c 6))  
        ERROR: ARGUMENT TO SENTENCE NOT A WORD OR SENTENCE: #T   
        ```  
        Second, even if you could have a sentence of Booleans, **Scheme doesn’t allow a special form, such as `or`, as the argument to a higher-order function.** Depending on your version of Scheme, the incorrect `any-numbers?` procedure might give an error message about either of these two problems.   
          
        > As we said in Chapter 4, special forms aren’t procedures, and aren’t first-class.   
          
        Instead of using `every`, select the numbers from the argument and count them:   
        ```scheme  
        (define (any-numbers? sent)   
          (not (empty? (keep number? sent))))   
        ```  
  
    * The `keep` function always returns a result of the same type as its second argument. `Every` always returns a sentence.  
          
        **The `keep` function always returns a result of the same type (i.e., word or sentence) as its second argument.** This makes sense because if you’re selecting a subset of the words of a sentence, you want to end up with a sentence; but if you’re selecting a subset of the letters of a word, you want a word.   
          
        **`Every`, on the other hand, always returns a sentence.** You might think that it would make more sense for every to return a word when its second argument is a word. Sometimes that _is_ what you want, but sometimes not. For example:   
        ```scheme  
        (define (spell-digit digit)   
          (item (+ 1 digit)   
                ’(zero one two three four five six seven eight nine)))   
          
        (every spell-digit 1971) ;(ONE NINE SEVEN ONE)   
        ```  
          
        In the cases where you do want a word, you can just `accumulate` `word` the sentence that `every` returns.  
  
    * `every` expects its first argument to be a function of just one argument.  
          
        If you invoke `every` with a function such as `quotient`, which expects two arguments, you will get an error message from `quotient`, complaining that it only got one argument and wanted to get two.   
          
        Some people try to get around this by saying things like   
          
        ```shceme  
        (every (quotient 6) ’(1 2 3)) ;; wrong!   
        ```  
          
        This is a sort of wishful thinking. The intent is that Scheme should interpret the first argument to `every` as a fill-in-the-blank template, so that every will compute the values of   
          
        ```scheme  
        (quotient 6 1)   
        (quotient 6 2)   
        (quotient 6 3)   
        ```  
          
        But of course **what Scheme really does is the same thing it always does: It evaluates the argument expressions, then invokes `every`.** So Scheme will try to compute (quotient 6) and will give an error message.   
          
        We picked `quotient` for this example because it requires exactly two arguments. Many Scheme primitives that ordinarily take two arguments, however, will accept only one. Attempting the same wishful thinking with one of these procedures is still wrong, but the error message is different. For example, suppose you try to add 3 to each of several numbers this way:   
          
        ```scheme  
        (every (+ 3) ’(1 2 3)) ;; wrong!   
        ```  
          
        The first argument to `every` in this case isn’t “the procedure that adds 3,” but the result returned by invoking `+` with the single argument 3. `(+ 3)` returns the number 3, which isn’t a procedure. So you will get an error message like “Attempt to apply non-procedure 3.”  
  
    * If `every`'s argument procedure returns **an empty sentence** it will disappear in the result while if **an empty word** it will appear in the result.  
          
        If the procedure you use as the argument to `every` returns an empty sentence, then you may be surprised by the results:   
          
        ```scheme  
        (define (beatle-number n)   
          (if (or (< n 1) (> n 4))   
              ’()  
              (item n ’(john paul george ringo))))   
          
        (beatle-number 3)  
        ; GEORGE  
          
        (beatle-number 5)  
        ; ()  
          
        (every beatle-number ’(2 8 4 0 1))   
        ; (PAUL RINGO JOHN)   
        ```  
          
        What happened to the 8 and the 0? Pretend that every didn’t exist, and you had to do it the hard way:   
          
        ```scheme  
        (se (beatle-number 2) (beatle-number 8) (beatle-number 4)   
            (beatle-number 0) (beatle-number 1))   
        ```  
          
        Using result replacement, we would get  
          
        ```scheme   
        (se ’paul ’() ’ringo ’() ’john)   
        ```  
        which is just (PAUL RINGO JOHN).   
          
        On the other hand, **if `every`’s argument procedure returns an empty _word,_ it will appear in the result**.   
          
        ```scheme  
        (every bf ’(i need you))  
        ; ("" EED OU)  
        ```  
          
        The sentence returned by `every` has three words in it: the empty word, eed, and ou.  
  
    * Don't confuse `first` with `every`  
          
        Don’t confuse  
        ```scheme  
        (first ’(one two three four))  
        ```  
        with  
        ```scheme   
        (every first ’(one two three four))  
        ```  
          
        In the first case, we’re applying the procedure `first` to a sentence; in the second, we’re applying `first` four separate times, to each of the four words separately.  
  
    * What happens if using a one-word sentence or one-letter word as argument to `accumulate`?  
          
        It returns that word or that letter, without even invoking the given procedure. This makes sense if you’re using something like `+` or `max` as the accumulator, but it’s disconcerting that  
          
        ```scheme  
        (accumulate se ’(one-word))   
        ```  
        returns the _word_ one-word.  
  
    * What happens if you give `accumulate` an empty sentence or word?  
          
        `accumulate` accepts empty arguments for some combiners, but not for others:   
          
        ```scheme  
        (accumulate + ’())   
        ; 0  
           
        (accumulate max ’())  
        ERROR: CAN’T ACCUMULATE EMPTY INPUT WITH THAT COMBINER  
        ```  
           
        **The combiners that can be used with an empty sentence or word are `+`,`*`, `word`, and `sentence`. `accumulate` checks specifically for one of these combiners.**   
          
        Why should these four procedures, and no others, be allowed to accumulate an empty sentence or word? The difference between these and other combiners is that you can invoke them with no arguments, whereas `max`, for example, requires at least one number:   
          
        ```scheme  
        (+)   
        ;0   
          
        (max)  
        ERROR: NOT ENOUGH ARGUMENTS TO #<PROCEDURE>.   
        ```  
          
        **`accumulate` actually invokes the combiner with no arguments in order to find out what value to return for an empty sentence or word.** We would have liked to implement accumulate so that _any_ procedure that can be invoked with no arguments would be accepted as a combiner to accumulate the empty sentence or word. Unfortunately, Scheme does not provide a way for a program to ask, “How many arguments will this procedure accept?” The best we could do was to build a particular set of zero-argument-okay combiners into the definition of accumulate.   
          
        Don’t think that the returned value for an empty argument is always zero or empty.   
        ```scheme  
        (accumulate * ’())   
        ;1  
        ```  
           
        The explanation for this behavior is that **any function that works with no arguments returns its _identity element_** in that case. What’s an identity element? The function `+` has the identity element 0 because (+ _anything_ 0) returns the _anything._ Similarly, the empty word is the identity element for word. In general, a **function’s identity element has the property that when you invoke the function with the identity element and something else as arguments, the return value is the something else. It’s a Scheme convention that a procedure with an identity element returns that element when invoked with no arguments.**   
          
        > PC Scheme returns zero for an invocation of `max` with no arguments, but that’s the wrong answer. If anything, the answer would have to be −∞.  
  
    * `repeated` isn’t a function of three arguments.  
          
        The use of two consecutive open parentheses to invoke the procedure returned by a procedure is a strange-looking notation:   
          
        ```scheme  
        ((repeated bf 3) 987654)  
        ```  
          
        Don’t confuse this with the similar-looking `cond` notation, in which the outer parentheses have a special meaning (delimiting a `cond` clause). Here, the parentheses have their usual meaning. The inner parentheses invoke the procedure repeated with arguments bf and 3. The value of that expression is a procedure. It doesn’t have a name, but for the purposes of this paragraph let’s pretend it’s called `bfthree`. Then the outer parentheses are basically saying (bfthree 987654); they apply the unnamed procedure to the argument 987654.   
        In other words, there are two sets of parentheses because there are two functions being invoked: `repeated` and the function returned by repeated. So don’t say   
        ```scheme  
        (repeated bf 3 987654) ;; wrong  
        ```  
        just because it looks more familiar. **`repeated` isn’t a function of three arguments**.  
  
* Exercises 8.1-8.3  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 8.1-8.3.scm][18]  
  
* Exercises 8.4-8.14  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 8.4-8.14.scm][19]  
  
### Chapter 9 Lambda  
  
* What is `lambda`?  
      
    **`lambda` is the name of a special form that generates procedures**. It takes some information about the function you want to create as arguments and it returns the procedure.   
      
    ```scheme  
    (define (add-three-to-each sent)  
      (every (lambda (number) (+ number 3)) sent))   
      
    (add-three-to-each ’(1 9 9 2))   
    ; (4 12 12 5)   
    ```  
      
    **Don’t make the mistake of thinking that `lambda` is the argument to `every`. The argument is _the procedure returned by_ `lambda`.**   
      
    Creating a procedure by using `lambda` is very much like creating one with `define`, as we’ve done up to this point, except that we don’t specify a name. **When we create a procedure with `define`, we have to indicate the procedure’s name, the names of its arguments (i.e., the formal parameters), and the expression that it computes (its body). With `lambda` we still provide the last two of these three components.**   
      
    **As we said, `lambda` is a special form. This means that its arguments are not evaluated when you invoke it. The first argument is a sentence containing the formal parameters; the second argument is the body. What lambda returns is an unnamed procedure.**  
  
* Procedures that Return Procedures  
    * How to create a procedure that returns procedures?  
          
        **An even more powerful use of lambda is to provide the value returned by some procedure that you write.** Here’s the classic example:   
          
        ```scheme  
        (define (make-adder num)   
          (lambda (x) (+ x num)))   
          
        ((make-adder 4) 7)   
        ; 11   
          
        (every (make-adder 6) ’(2 4 8))   
        ; (8 10 14)   
        ```  
          
        The value of the expression `(make-adder 4)` is a _procedure,_ not a number. That unnamed procedure is the one that adds 4 to its argument.   
          
        Here’s a procedure whose argument is a procedure:   
          
        ```scheme  
        (define (same-arg-twice fn)   
          (lambda (arg) (fn arg arg)))   
          
        ((same-arg-twice word) ’hello)   
        ; HELLOHELLO   
          
        ((same-arg-twice *) 4)   
        ; 16   
        ```  
          
        When we evaluate `(same-arg-twice word)` we substitute the procedure word for the formal parameter `fn`, and the result is   
          
        >(lambda (arg) (word arg arg))  
  
* The Truth about `Define`  
    * What are the two activities combined in `define`?  
          
        The notation we’ve been using with `define` is an abbreviation that combines two activities: **creating a procedure and giving a name to something.**   
          
        When we say   
          
        ```scheme  
        (define (square x) (* x x))  
        ```  
          
        it’s actually an abbreviation for  
          
        ```scheme   
        (define square (lambda (x) (* x x)))  
        ```  
          
        In this example, the job of `lambda` is to create a procedure that multiplies its argument by itself; the job of `define` is to name that procedure square.  
  
    * What does `global` mean?  
          
        In the past, without quite saying so, we’ve talked as if the name of a procedure were understood differently from other names in a program. In thinking about an expression such as   
          
        ```scheme  
        (* x x)  
        ```  
          
        we’ve talked about substituting some actual value for the `x` but took the `*` for granted as meaning the multiplication function.   
          
        The truth is that we have to substitute a value for the `*` just as we do for the `x`. It just happens that `*` has been predefined to have the multiplication procedure as its value. This definition of `*` is _global_. **“Global” means that it’s not a formal parameter of a procedure, like x in square, but has a permanent value established by define.**  
  
    * How to use `define` in combination with the function-creating functions?  
          
        ```scheme  
        (define square (same-arg-twice *))  
          
        (square 7)  
        ; 49  
          
        (define fourth-power (repeated square 2))   
          
        (fourth-power 5)  
        ; 625  
        ```  
  
* The Truth about `Let`  
    * What is the mechanism under `let`?  
          
        In Chapter 7 we introduced `let` as an abbreviation for the situation in which we would otherwise define a helper procedure in order to give names to commonly-used values in a calculation.  
          
        ```scheme  
        (define (roots a b c)  
          (let ((discriminant (sqrt (- (* b b) (* 4 a c)))))   
            (se (/ (+ (- b) discriminant) (* 2 a))  
                (/ (- (- b) discriminant) (* 2 a)))))   
        ```  
          
        now that we know about unnamed procedures, we can see that **`let` is merely an abbreviation for creating and invoking an anonymous procedure**:   
          
        > (define (roots a b c)   
          **(**(lambda (discriminant)   
                 (se (/ (+ (- b) discriminant) (* 2 a)) (/ (- (- b) discriminant) (* 2 a))))   
             **(sqrt(-(*** **bb)(*** **4ac))))**)  
          
        What’s shown in boldface above is the part that invokes the procedure created by the `lambda`, including the actual argument expression.   
          
        Just as the notation to define a procedure with parentheses around its name is an abbreviation for a `define` and a `lambda`, **the `let` notation is an abbreviation for a `lambda` and an invocation.**  
  
* Name Conflicts  
      
    When a procedure is created inside another procedure, what happens if you use the same formal parameter name in both?   
      
    ```scheme  
    (define (f x)  
      (lambda (x) (+ x 3)))  
    ```  
      
    Answer: Don’t do it.   
      
    What actually happens is that the inner x wins; that’s the one that is substituted into the body. But if you find yourself in this situation, you are almost certainly doing something wrong, such as using non-descriptive names like x for your variables.  
  
* Named and Unnamed Functions  
    * When to name a function and when not?  
          
        **If we’re going to use a procedure more than once, and if there’s a meaningful name for it that will help clarify the program, then we define the procedure with `define` and give it a name.**   
          
        ```scheme  
        (define (square x) (* x x))  
        ```  
          
        `square` deserves a name both because we use it often and because there is a good traditional name for it that everyone understands. More important, **by giving `square` a name, we are shifting attention from the process by which it works (invoking the multiplication procedure) to its _purpose,_ computing the square of a number. From now on we can think about squaring as though it were a Scheme primitive. This idea of naming something and forgetting the details of its implementation is what we’ve been calling “abstraction.”**  
  
* Pitfalls  
    * Don't mix the two notations of `define`  
          
        It’s very convenient that `define` has an abbreviated form to define a procedure using a hidden `lambda`, but because there are two notations that differ only subtly—one has an extra set of parentheses—you could use the wrong one by mistake. If you say   
          
        ```scheme  
        (define (pi) 3.141592654)  
        ```  
          
        you’re not defining a variable whose value is a number. Instead the value of `pi` will be a _procedure._ It would then be an error to say (* 2 pi)  
  
    * When should the body of your procedure be a `lambda` expression?  
          
        When should the body of your procedure be a `lambda` expression? It’s easy to go overboard and say “I’m writing a procedure so I guess I need lambda” even when the procedure is supposed to return a word.   
          
        The secret is to remember the ideas of _domain_ and _range_ that we talked about in Chapter 2. **What is the range of the function you’re writing? Should it return a procedure? If so, its body might be a `lambda` expression. (It might instead be an invocation of a higher-order procedure, such as repeated, that returns a procedure.) If your procedure doesn’t return a procedure, its body won’t be a `lambda` expression. (Of course your procedure might still use a `lambda` expression as an argument to some _other_ procedure, such as every.)**  
           
        For example, here is a procedure to keep the words of a sentence that contain the letter h. The domain of the function is sentences, and its range is also sentences. (That is, it takes a sentence as argument and returns a sentence as its value.)   
          
        ```scheme  
        (define (keep-h sent)  
          (keep (lambda (wd) (member? ’h wd)) sent))   
        ```  
          
        By contrast, here is a function of a letter that returns a _procedure_ to keep words containing that letter.  
          
        ```scheme   
        (define (keeper letter)   
          (lambda (sent)   
            (keep (lambda (wd) (member? letter wd)) sent)))   
        ``  
          
        The procedure `keeper` has letters as its domain and procedures as its range. The procedure _returned by_ `keeper` has sentences as its domain and as its range, just as `keep-h` does. In fact, we can use `keeper` to define `keep-h`:   
          
        ```scheme  
        (define keep-h (keeper ’h))   
        ```  
  
    * Don’t confuse the **_creation_** of a procedure with the **_invocation_** of one.  
          
        **`Llambda` creates a procedure. The procedure is invoked in response to an expression whose first subexpression represents that procedure. That is, the first subexpression could be the _name_ of the procedure, or it could be a lambda expression if you want to create a procedure and invoke it right away**:   
          
        ```scheme  
        ((lambda (x) (+ x 3)) 6)   
        ```  
          
        **In particular, when you create a procedure, you specify its formal parameters—the _names_ for its arguments. When you invoke the procedure, you specify _values_ for those arguments.** (In this example, the lambda expression includes the formal parameter x, but the invocation provides the actual argument 6.)  
  
* Exercises 9.1-9.3  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 9.1-9.3.scm][20]  
  
* Exercises 9.4-9.17  
      
    [github.com/mengsince1986/simplyScheme/blob/master/SS Exercises/Exercises 9.4-9.17.scm][21]  
  
### Project: Scoring Bridge Hands  
  
[github.com/mengsince1986/simplyScheme/blob/master/SS Projects/scoring bridge hands.scm][22]  
  
### Chapter 10 Example: Tic-Tac-Toe  
  
* Technical Terms in Tic-Tac-Toe  
      
    We’ll number the squares of the board this way:   
      
    ![][23]  
      
      
    We’ll call a partially filled-in board a “**position**.”  
      
     ![][24]  
      
      
    To the computer, **the same position will be represented by the word**  _ _o_xox_x. The nine letters of the word correspond to squares one through nine of the board. (We’re thinking ahead to the possibility of using `item` to extract the _n_th square of a given position.)  
  
* Thinking about the Program Structure  
    * How to plan the overall structure of tic-tac-toe?  
          
        Let’s plan the computer’s strategy in English before we start writing a computer program. How do _you_ play tic-tac-toe? You have several strategy rules in your head, some of which are more urgent than others. For example, **if you can win on this move, then you just do it without thinking about anything else. But if there isn’t anything that immediate, you consider less urgent questions, such as how this move might affect what happens two moves later.**   
          
        So we’ll represent this set of rules by a giant `cond` expression:   
          
        ```scheme  
        (define (ttt position me)          ;; first version  
          (cond ((i-can-win?)  
                 (choose-winning-move))   
                ((opponent-can-win?)   
                 (block-opponent-win))   
                ((i-can-win-next-time?)   
                 (prepare-win))   
                (else (whatever))))   
        ```  
          
        We’re imagining many helper procedures. **`I-can-win?` will look at the board and tell if the computer has an immediate winning move.** If so, **`choose-winning-move` will find that particular move.** **`Opponent-can-win?` returns true if the human player has an immediate winning move.** **`Block-opponent-win` will return a move that prevents the computer’s opponent from winning, and so on.**  
           
        **We didn’t actually start by writing this definition of `ttt`. The particular names of helper procedures are just guesses, because we haven’t yet planned the tic-tac-toe strategy in detail. But we did know that this would be the overall structure of our program. This big picture doesn’t automatically tell us what to do next; different programmers might fill in the details differently. But it’s a framework to keep in mind during the rest of the job.**  
  
    * What is the first practical step?  
          
        Our first practical step was to think about the _**data structures**_ in our program. **A data structure is a way of organizing several pieces of information into a big chunk.** For example, a sentence is a data structure that combines several words in a sequence (that is, in left-to-right order).   
          
        In the first, handwavy version of `ttt`, the strategy procedures like `i-can-win?` are called with no arguments, but of course we knew they would need some information about the board position. We began by thinking about how to represent that information within the program.  
  
* The First Step: Triples  
    * What matters most in tic-tac-toe?  
          
        A person looking at a tic-tac-toe board looks at the rows, columns, and diagonals. The question “**do I have a winning move?**” is equivalent to the question “**are there three squares in a line such that two of them are mine and the last one is blank?”** In fact, nothing else matters about the game besides these potential winning combinations.  
  
        * How many potential winning combinations are there in tic-tac-toe?  
              
            **There are eight potential winning combinations: three rows, three columns, and two diagonals.** Consider the combination containing the three squares 1, 5, and 9. If it contains both an x and an o then nobody can win with this combination and there’s nothing to think about. But if it contains two xs and a free square, we’re very interested in the combination. **What we want to know in particular is which square is free, since we want to move in that square to win or block.**   
              
            More generally, the only squares whose _numbers_ we care about are the ones we might want to move into, namely, the free ones. **So the only interesting information about a square is whether it has an x or an o, and if not, what its number is**.  
  
    * How to convert a board position of tic-tac-toe into "**triple**" data?  
          
        The information that 1, 5, 9 is a potential winning combination and the information that square 1 contains an x, square 5 is empty, and square 9 contains another x can be combined into the single word x5x. Looking at this word we can see immediately that there are two xs in this “triple” and that the free square is square 5. So when we want to know about a three-square combination, we will turn it into a triple of that form.   
          
        Here’s a sample board position:   
          
        ![][25]  
          
        and here is a sentence of all of its triples:   
          
        ```scheme  
        (1xo 4x6 o89 14o xx8 o69 1x9 oxo)   
        ```  
          
        Take a minute to convince yourself that this sentence really does tell you everything you need to know about the corresponding board position. **Once our strategy procedure finds the triples for a board position, it’s never going to look at the original position again**.  
          
        This technique of converting data from one form to another so that it can be manipulated more easily is an important idea in computer science.  
  
    * What are the three representations of a board position of tic-tac-toe?  
          
        **There are really three representations of the same thing. There’s this picture:**   
          
        ![][26]  
          
        **as well as the word `_xo_x_o__` and the sentence (1xo 4x6 o89 14o xx8 o69 1x9 oxo).**   
          
        All three of these formats have the same information but are convenient in different ways. **The pictorial form is convenient because it makes sense to the person who’s playing tic-tac-toe.** Unfortunately, you can’t type that picture into a computer, so we need a different format, **the word `_xo_x_o__`, which contains the _contents_ of the nine squares in the picture, but without the lines separating the squares and without the two-dimensional shape**.   
          
        **The third format, the sentence, is quite _inconvenient_ for human beings. You’d never want to think about a tic-tac-toe board that way yourself, because the sentence doesn’t have the visual simplicity that lets you take in a tic-tac-toe position at a glance. But the sentence of triples is the most convenient representation for our program.** `Ttt` will have to answer questions like “can x win on the next move?” To do that, it will have to consider an equivalent but more detailed question: “For each of the eight possible winning combinations, can x complete that combination on the next move?” **It doesn’t really matter whether a combination is a row or a column; what does matter is that each of the eight combinations be readily available for inspection by the program**. **The sentence-of-triples representation obscures part of the available information (which combination is where) to emphasize another part (making the eight combinations explicit, instead of implicit in the nine boxes of the diagram).**   
          
        The representation of fractions as “mixed numerals,” such as 2 1/3 , and as “improper fractions,” such as 7/3 , is a non-programming example of this idea about multiple representations. A mixed numeral makes it easier for a person to tell how big the number is, but an improper fraction makes arithmetic easier.  
  
* Finding the Triples  
    * What is the first task to combine the current board position with the triples?  
          
        We said that we would **combine the current board position with the numbers of the squares in the eight potential winning combinations in order to compute the things we’re calling triples**. That was our first task in writing the program.   
          
        Our program will start with this sentence of all the winning combinations:   
          
        ```scheme  
        (123 456 789 147 258 369 159 357)   
        ```  
          
        and a position word such as `_xo_x_o__`; it will return a sentence of triples such as   
          
        ```scheme  
        (1xo 4x6 o89 14o xx8 o69 1x9 oxo)   
        ```  
  
    * How to structure procedure `find-triples` to interpret the board position to triples?  
          
        All that’s necessary is to replace some of the numbers with xs and os. This kind of word-by-word translation in a sentence is a good job for `every`.   
          
        ```scheme  
        (define (find-triples position)                                 ;; first version   
          (every substitute-triple ’(123 456 789 147 258 369 159 357)))   
        ```  
  
    * How to structure procedure `substitute-triple` to interpret a three-digit combination into a triple?  
          
        We’ve made up a name `substitute-triple` for a procedure we haven’t written yet. This is perfectly OK, as long as we write it before we try to invoke `find-triples`. **The `substitute-triple` function will take three digits, such as 258, and return a triple, such as 2x8**:  
          
        ```scheme  
        (define (substitute-triple combination)                         ;; first version   
          (every substitute-letter combination))   
        ```   
          
        This procedure uses `every` to call `substitute-letter` on all three letters.   
          
        There’s a small problem, though. `every` always returns a sentence, and we want our triple to be a word. For example, we want to turn the potential winning combination 258 into the word 2x8,but `every` would return the sentence (2 x 8). So here’s our next version of `substitute-triple`:   
          
        ```scheme  
        (define (substitute-triple combination)                          ;; second version   
          (accumulate word (every substitute-letter combination)))   
        ```  
  
    * How to structure procedure `substitute-letter` to interpret a square into its corresponding content in the position?  
          
        `Substitute-letter` knows that letter number 3 of the word that represents the board corresponds to the contents of square 3 of the board. This means that it can just call `item` with the given square number and the board to find out what’s in that square. If it’s empty, we return the square number itself; otherwise we return the contents of the square.   
          
        ```scheme  
        (define (substitute-letter square)              ;; first version  
          (if (equal? ’_ (item square position))   
              square  
              (item square position)))   
        ```  
          
        Whoops! Do you see the problem?   
          
        ```scheme  
        (substitute-letter 5)  
        ERROR: Variable POSITION is unbound.   
        ```  
  
* Using `every` with Two-Argument Procedures  
    * How does the real `substitute-letter` work?  
          
        Our procedure only takes one argument, `square`, but it needs to know the position so it can find out what’s in the given square. So here’s the real `substitute-letter`:   
          
        ```scheme  
        (define (substitute-letter square position)   
          (if (equal? '_ (item square position))   
              square  
              (item square position)))   
          
        (substitute-letter 5 ’_xo_x_o__)   
        ;X   
          
        (substitute-letter 8 ’_xo_x_o__)   
        ;8   
        ```  
  
    * How to modify `substitute-triple` to invoke `substitute-letter` with two arguments?  
          
        Now `substitute-letter` can do its job, since it has access to the position. But we’ll have to modify `substitute-triple` to invoke `substitute-letter` with two arguments.   
          
        This is a little tricky. Let’s look again at the way we’re using `substitute-letter` inside `substitute-triple`:  
          
        ```scheme   
        (define (substitute-triple combination)                          ;; second version again   
          (accumulate word (every substitute-letter combination)))   
        ```  
          
        By giving `substitute-letter` another argument, we have made this formerly correct procedure incorrect. **The first argument to `every` must be a function of one argument, not two. This is exactly the kind of situation in which `lambda` can help us: We have a function of two arguments, and we need a function of one argument that does the same thing, but with one of the arguments fixed.**   
          
          The procedure returned by   
          
        ```scheme  
        (lambda (square) (substitute-letter square position))   
        ```  
          
          does exactly the right thing; it takes a square as its argument and returns the contents of the position at that square.   
          
        Here’s the final version of substitute-triple:   
          
        ```scheme  
        (define (substitute-triple combination position)   
          (accumulate word   
                      (every (lambda (square)  
                               (substitute-letter square position))   
                             combination)))   
          
        (substitute-triple 456 ’_xo_x_o__)    
        ; "4x6"   
          
        (substitute-triple 147 ’_xo_x_o__)  
        ; "14O"   
          
        (substitute-triple 357 ’_xo_x_o__)  
        ; oxo   
        ```  
          
        As you can see, Scheme prints some of these words with double-quote marks. The rule is that **a word that isn’t a number but begins with a digit must be double-quoted**. But in the finished program we’re not going to print such words at all; we’re just showing you the working of a helper procedure. Similarly, in this chapter we’ll show direct invocations of helper procedures in which some of the arguments are strings, but a user of the overall program won’t have to use this notation.  
  
    * How to modify `find-triples` to invoke `substitute-triple` with two arguments?  
          
        We’ve fixed the `substitute-letter` problem by giving `substitute-triple` an extra argument, so we’re going to have to go through the same process with `find-triples`. Here’s the right version:   
          
        ```scheme  
        (define (find-triples position)  
          (every (lambda (comb) (substitute-triple comb position))   
                 '(123 456 789 147 258 369 159 357)))  
        ```  
          
        It’s the same trick. **`substitute-triple` is a procedure of two arguments. We use `lambda` to transform it into a procedure of one argument for use with `every`.**  
          
        We’ve now finished `find-triples`, one of the most important procedures in the game.   
          
        ```scheme  
        (find-triples ’_xo_x_o__)  
        ; ("1XO" "4X6" O89 "14O" XX8 O69 "1X9" OXO)   
          
        (find-triples ’x_____oxo)  
        ; (X23 456 OXO X4O "25X" "36O" X5O "35O")   
        ```  
  
    * The summary of `substitute-letter`, `substitute-triple` and `find-triples`  
          
        Here again are the jobs of all three procedures we’ve written so far:   
          
        `substitute-letter`  **finds the letter in a single square.**  
        `substitute-triple`  **finds all three letters corresponding to three squares.**  
        `find-triples`       **finds all the letters in all eight winning combinations.**  
          
             
          We’ve done all this because we think that the rest of the program can use the triples we’ve computed as data. So we’ll just compute the triples once for all the other procedures to use:   
          
        ```scheme  
        (define (ttt position me)  
          (ttt-choose (find-triples position) me))   
          
        (define (ttt-choose triples me)                         ;; first version  
          (cond ((i-can-win? triples me)   
                 (choose-winning-move triples me))   
                ((opponent-can-win? triples me)   
                 (block-opponent-win triples me))   
                ...))   
        ```  
  
* Can the Computer Win on This Move?  
    * What does `i-can-win?` do?  
          
        The obvious next step is to write `i-can-win?`, **a procedure that should return #t if the computer can win on the current move—that is, if the computer already has two squares of a triple whose third square is empty.** The triples x6x and oo7 are examples.  
  
    * How to define `my-pair?` to check if one triple can win in the next move?  
          
        So we need a function that takes a word and a letter as arguments and counts how many times that letter appears in the word. The `appearances` primitive that we used in Chapter 2 (and that you re-implemented in Exercise 9.10) will do the job:   
          
        ```scheme  
        (appearances 'o 'oo7)   
        ; 2   
          
        (appearances 'x 'oo7)   
        ; 0   
        ```  
          
        **The computer “owns” a triple if the computer’s letter appears twice and the opponent’s letter doesn’t appear at all.** (The second condition is necessary to exclude cases like xxo.)   
          
        ```scheme  
        (define (my-pair? triple me)  
          (and (= (appearances me triple) 2)   
               (= (appearances (opponent me) triple) 0)))  
        ```  
          
          
        Notice that we need a function `opponent` that returns the opposite letter from ours.   
          
        ```scheme  
        (define (opponent letter)  
          (if (equal? letter ’x) ’o ’x))   
          
        (opponent 'x) ;O   
          
        (opponent 'o) ;X   
          
        (my-pair? 'oo7 'o) ; #T   
          
        (my-pair? 'xo7 'o) ; #F   
          
        (my-pair? 'oox 'o) ; #F   
        ```  
  
    * How to define `i-can-win?` with `my-pair?`?  
          
        Finally, the computer can win if it owns any of the triples:   
          
        ```scheme  
        (define (i-can-win? triples me)                             ;; first version   
          (not (empty?   
                (keep (lambda (triple) (my-pair? triple me))   
                              triples))))   
          
        (i-can-win? ’("1xo" "4x6" o89 "14o" xx8 o69 "1x9" oxo) ’x)   
        ; #T   
          
        (i-can-win? ’("1xo" "4x6" o89 "14o" xx8 o69 "1x9" oxo) ’o)   
        ; #F   
        ```  
          
        By now you’re accustomed to this trick with `lambda`. `My-pair?` takes a triple and the computer’s letter as arguments, but we want a function of one argument for use with `keep`.  
  
* If So, in Which Square?  
    * How to define `choose-winning-move`?  
          
        Suppose `i-can-win?` returns `#t`. We then have to find the particular square that will win the game for us. This will involve a repetition of some of the same work we’ve already done:   
          
        ```scheme  
        (define (choose-winning-move triples me)                     ;; not really part of game   
          (keep number? (first (keep (lambda (triple) (my-pair? triple me))   
                                     triples))))  
        ```  
          
        We again use `keep` to find the triples with two of the computer’s letter, but this time we extract the number from the first such winning triple.   
          
        We’d like to avoid this inefficiency. As it turns out, generations of Lisp programmers have been in just this bind in the past, and so they’ve invented a "kludge" to get around it.   
          
        > **A kludge is a programming trick that doesn’t follow the rules but works anyway somehow.** It doesn’t rhyme with “sludge”; it’s more like “clue” followed by “j” as in “Jim.”  
  
    * How to use semipredicate in Scheme to combine `i-can-win?` and `choose-winning-move`?  
          
        Remember we told you that **everything other than `#f` counts as true**? We’ll take advantage of that by having a single procedure that returns the number of a winning square if one is available, or `#f` otherwise. In Chapter 6 we called such a procedure a “**semipredicate**.”   
          
        **The kludgy part is that `cond` accepts a clause containing a single expression instead of the usual two expressions; if the expression has any true value, then cond returns that value.** So we can say   
          
        ```scheme  
        (define (ttt-choose triples me)                        ;; second version   
          (cond ((i-can-win? triples me))   
                ((opponent-can-win? triples me))   
                ...))   
        ```  
          
        where each `cond` clause invokes a semipredicate. We then modify `i-can-win?` to have the desired behavior:   
          
        ```scheme  
        (define (i-can-win? triples me)   
          (choose-win   
           (keep (lambda (triple) (my-pair? triple me))   
           triples)))   
        ```  
          
        ```scheme  
        (define (choose-win winning-triples)   
          (if (empty? winning-triples)   
        f  
              (keep number? (first winning-triples))))   
          
        (i-can-win? ’("1xo" "4x6" o89 "14o" xx8 o69 "1x9" oxo) ’x)   
        ; 8   
          
        (i-can-win? ’("1xo" "4x6" o89 "14o" xx8 o69 "1x9" oxo) ’o)   
        ; #F   
        ```  
  
    * How to structure the overall program based on `i-can-win?`?  
          
        By this point, we’re starting to see the structure of the overall program. There will be several procedures, similar to `i-can-win?`, that will try to choose the next move. `i-can-win?` checks to see if the computer can win on this turn, another procedure will check to see if the computer should block the opponent’s win next turn, and other procedures will check for other possibilities. Each of these procedures will be what we’ve been calling “semipredicates.” That is to say, each will return the number of the square where the computer should move next, or `#f` if it can’t decide. All that’s left is to figure out the rest of the computer’s strategy and write more procedures like i-can-win?.  
  
* Second Verse, Same as the First  
    * How to define `opponent-can-win?`?  
          
        Now it’s time to deal with the second possible strategy case: **The computer can’t win on this move, but the opponent can win unless we block a triple right now**.   
          
        (What if the computer and the opponent both have immediate winning triples? In that case, we’ve already noticed the computer’s win, and by winning the game we avoid having to think about blocking the opponent.)   
          
        Once again, we have to go through the complicated business of finding triples that have two of the opponent’s letter and none of the computer’s letter—but it’s already done!   
          
        ```scheme  
        (define (opponent-can-win? triples me)   
         (i-can-win? triples (opponent me)))   
          
        (opponent-can-win? '("1xo" "4x6" o89 "14o" xx8 o69 "1x9" oxo) ’x)   
        ; #F   
          
        (opponent-can-win? '("1xo" "4x6" o89 "14o" xx8 o69 "1x9" oxo) ’o)   
        ; 8   
        ```  
  
* Now the Strategy Gets Complicated  
    * What is the strategy after `i-can-win?` and `opponet-can-win?`?  
          
        The third step, after we check to see if either player can win on the next move, is to look for **a situation in which a move that we make now will give rise to _two_ winning triples next time**. Here’s an example:   
          
        ![][27]  
          
        Neither x nor o can win on this move. But if the computer is playing x, moving in square 4 or square 7 will produce a situation with two winning triples. For example, here’s what happens if we move in square 7:   
          
        ![][28]  
          
        From this position, x can win by moving either in square 3 or in square 4. It’s o’s turn, but o can block only one of these two possibilities. By contrast, if (in the earlier position) x moves in square 3 or square 6, that would create a single winning triple for next time, but o could block it.   
          
        In other words, **we want to find _two_ triples in which one square is taken by the computer and the other two are free, with one free square shared between the two triples.** (In this example, we might find the two triples x47 and 3x7; that would lead us to move in square 7, the one that these triples have in common.) We’ll call a situation like this a “fork,” and we’ll call the common square the “pivot.” This isn’t standard terminology; we just made up these terms to make it easier to talk about the strategy.  
  
    * How to structure `i-can-fork?`?  
          
        In order to write the strategy procedure `i-can-fork?` we assume that we’ll need a procedure `pivots` that returns a sentence of all pivots of forks currently available to the computer. In this board, 4 and 7 are the pivots, so the `pivots` procedure would return the sentence (4 7). If we assume `pivots`, then writing `i-can-fork?` is straightforward:   
          
        ```define  
        (define (i-can-fork? triples me)   
          (first-if-any (pivots triples me)))   
          
        (define (first-if-any sent)   
          (if (empty? sent)   
        f  
              (first sent)))   
        ```  
  
* Finding the Pivots  
    * What does `pivots` do?  
          
        `pivots` should return a sentence containing the pivot numbers. Here’s the plan. We’ll start with the triples:   
          
        >(xo3 4x6 78o x47 ox8 36o xxo 3x7)   
          
        We keep the ones that have an x and two numbers:   
          
        >(4x6 x47 3x7)   
          
        We mash these into one huge word:   
          
        >4x6x473x7   
          
        We sort the digits from this word into nine “buckets,” one for each digit:   
          
        >("" "" 3 44 "" 6 77 "" "")   
          
        We see that there are no ones or twos, one three, two fours, and so on. Now we can easily see that four and seven are the pivot squares.  
  
    * How to structure `pivots` and define `my-single?`?  
          
        Let’s write the procedures to carry out that plan. **`pivots` has to find all the triples with one computer-owned square and two free squares, and then it has to extract the square numbers that appear in more than one triple**.   
          
        ```scheme  
        (define (pivots triples me)  
          (repeated-numbers (keep (lambda (triple) (my-single? triple me))    
                                  triples)))  
           
        (define (my-single? triple me)  
          (and (= (appearances me triple) 1)   
               (= (appearances (opponent me) triple) 0)))   
          
        (my-single? "4x6" ’x)   
        ; #T  
          
        (my-single? ’xo3 ’x)   
        ; #F   
          
        (keep (lambda (triple) (my-single? triple ’x))   
              (find-triples ’xo__x___o))   
        ; ("4X6" X47 "3X7")  
        ```  
          
        `My-single?` is just like `my-pair?` except that it looks for one appearance of the letter instead of two.  
  
    * How to structure and define `repeated-numbers`?  
          
        **`repeated-numbers` takes a sentence of triples as its argument and has to return a sentence of all the numbers that appear in more than one triple**.   
          
        ```scheme  
        (define (repeated-numbers sent)   
          (every first   
                 (keep (lambda (wd) (>= (count wd) 2))   
                       (sort-digits (accumulate word sent)))))   
        ```  
  
        * Why to `accumulate` `word` the triple sentence?  
              
            We’re going to read this procedure inside-out, starting with the `accumulate` and working outward.   
              
            Why is it okay to `accumulate` `word` the sentence? **Suppose that a number appears in two triples. All we need to know is that number, not the particular triples through which we found it. Therefore, instead of writing a program to look through several triples separately, we can just as well combine the triples into one long word, keep only the digits of that word, and simply look for the ones that appear more than once.**   
              
            ```scheme  
            (accumulate word ’("4x6" x47 "3x7"))   
            ; "4X6X473X7"  
            ```  
  
        * How to structure `sort-digits`?  
            * How to define `extract-digit`?  
                  
                We now have one long word, and we’re looking for repeated digits. Since this is a hard problem, let’s start with the subproblem of finding all the copies of a particular digit.   
                  
                ```scheme  
                (define (extract-digit desired-digit wd)  
                  (keep (lambda (wd-digit) (equal? wd-digit desired-digit)) wd))   
                  
                (extract-digit 7 "4x6x473x7")   
                ; 77   
                  
                (extract-digit 2 "4x6x473x7")   
                ; ""   
                ```  
  
            * How to define `sort-digits`?  
                  
                Now we want a sentence where the first word is all the 1s, the second word is all the 2s, etc. We could do it like this:   
                  
                ```scheme  
                (se (extract-digit 1 "4x6x473x7")   
                    (extract-digit 2 "4x6x473x7")   
                    (extract-digit 3 "4x6x473x7") ...)   
                ```  
                  
                but that wouldn’t be taking advantage of the power of computers to do that sort of repetitious work for us. Instead, we’ll use `every`:   
                  
                ```scheme  
                (define (sort-digits number-word)  
                  (every (lambda (digit) (extract-digit digit number-word))   
                         '(1 2 3 4 5 6 7 8 9)))  
                ```  
                  
                `sort-digits` takes a word full of numbers and returns a sentence whose first word is all the ones, second word is all the twos, etc.  
                  
                ```scheme  
                (sort-digits 123456789147258369159357)   
                ; (111 22 333 44 5555 66 777 88 999)   
                  
                (sort-digits "4x6x473x7")   
                ;("" "" 3 44 "" 6 77 "" "")   
                ```  
  
        * review of `repeated-numbers`  
              
            Let’s look at repeated-numbers again:   
              
            ```scheme  
            (define (repeated-numbers sent)   
             (every first   
                    (keep (lambda (wd) (>= (count wd) 2))   
                          (sort-digits (accumulate word sent)))))   
              
            (repeated-numbers ’("4x6" x47 "3x7"))   
            ; (4 7)   
              
            (keep (lambda (wd) (>= (count wd) 2))   
                  '("" "" 3 44 "" 6 77 "" ""))   
            ; (44 77)   
              
            (every first ’(44 77))   
            ; (4 7)   
            ```  
              
            This concludes the explanation of `pivots`. Remember that `i-can-fork?` chooses the first pivot, if any, as the computer’s move.  
  
* Taking the Offensive  
    * What is the final version of `ttt-choose` with all the clauses shown?  
          
        Here’s the final version of `ttt-choose` with all the clauses shown:   
          
        ```scheme  
        (define (ttt-choose triples me)   
          (cond ((i-can-win? triples me))   
                ((opponent-can-win? triples me))   
                ((i-can-fork? triples me))   
                ((i-can-advance? triples me))  
                (else (best-free-square triples))))   
        ```  
  
    * What is the strategy after `i-can-advance`?  
          
        Just as the second possibility was the “mirror image” of the first (blocking an opponent’s move of the same sort the computer just attempted), it would make sense for the fourth possibility to be blocking the creation of a fork by the opponent. That would be easy to do:   
          
        ```scheme  
        (define (opponent-can-fork? triples me)                     ;; not really part of game   
          (i-can-fork? triples (opponent me)))   
        ```  
          
        Unfortunately, although the programming works, the strategy doesn’t. Maybe the opponent has _two_ potential forks; we can block only one of them. (Why isn’t that a concern when blocking the opponent’s wins? It _is_ a concern, but if we’ve allowed the situation to reach the point where there are two ways the opponent can win on the next move, it’s too late to do anything about it.)   
          
        Instead, **our strategy is to go on the offensive. If we can get two in a row on this move, then our opponent will be forced to block on the next move, instead of making a fork. However, we want to make sure that we don’t accidentally force the opponent _into_ making a fork.**   
          
        Let’s look at this board position again, but from o’s point of view:   
          
        ![][29]  
          
        X’s pivots are 4 and 7, as we discussed earlier; o couldn’t take both those squares. Instead, look at the triples 369 and 789, both of which are singles that belong to o. So o should move in one of the squares 3, 6, 7, or 8, forcing x to block instead of setting up the fork. But o _shouldn’t_ move in square 8, like this:   
          
        ![][30]  
          
        because that would force x to block in square 7, setting up a fork!  
          
        ![][31]  
  
    * What is the structure of `i-can-advance`?  
          
        **The structure of the algorithm is much like that of the other strategy possibilities. We use `keep` to find the appropriate triples, take the first such triple if any, and then decide which of the two empty squares in that triple to move into**.  
          
        ```scheme  
        (define (i-can-advance? triples me)  
          (best-move (keep (lambda (triple) (my-single? triple me)) triples)   
                     triples   
                     me))   
        ```  
  
        * How to define `best-move`?  
              
            ```scheme  
            (define (best-move my-triples all-triples me)   
              (if (empty? my-triples)   
            f  
                 (best-square (first my-triples) all-triples me)))   
            ```  
              
            `best-move` does the same job as first-if-any, which we saw earlier, except that it also invokes `best-square` on the first triple if there is one.  
  
        * How to define `best-square`?  
              
            Since we’ve already chosen the relevant triples before we get to `best-move`, you may be wondering why it needs _all_ the triples as an additional argument. The answer is that `best-square` is going to look at the board position from the opponent’s point of view to look for forks.   
              
            ```scheme  
            (define (best-square my-triple triples me)   
              (best-square-helper (pivots triples (opponent me))   
                                  (keep number? my-triple)))   
              
            (define (best-square-helper opponent-pivots pair)   
              (if (member? (first pair) opponent-pivots)   
                  (first pair)   
                  (last pair)))   
            ```  
              
            We `keep` the two numbers of the triple that we’ve already selected. We also select the opponent’s possible pivots from among all the triples. If one of our two possible moves is a potential pivot for the opponent, that’s the one we should move into, to block the fork. Otherwise, we arbitrarily pick the second (`last`) free square.   
              
            ```scheme  
            (best-square "78o" (find-triples ’xo x o) ’o)   
            ; 7   
              
            (best-square "36o" (find-triples ’xo x o) ’o)   
            ; 6   
              
            (best-move ’("78o" "36o") (find-triples ’xo x o) ’o)   
            ; 7   
              
            (i-can-advance? (find-triples ’xo x o) ’o)   
            ; 7   
            ```  
  
            * What if both of the candidate squares are pivots for the opponent?  
                  
                What if _both_ of the candidate squares are pivots for the opponent? In that case, we’ve picked a bad triple; moving in either square will make us lose. As it turns out, this can occur only in a situation like the following:   
                  
                ![][32]  
                  
                If we chose the triple 3o7, then either move will force the opponent to set up a fork, so that we lose two moves later. Luckily, though, we can instead choose a triple like 2o8. We can move in either of those squares and the game will end up a tie.   
                  
                In principle, we should analyze a candidate triple to see if both free squares create forks for the opponent. But since we happen to know that this situation arises only on the diagonals, we can be lazier. We just list the diagonals _last_ in the procedure `find-triples`. Since we take the first available triple, this ensures that we won’t take a diagonal if there are any other choices.  
  
* Leftovers  
    * What is the strategy of `best-free-square`?  
          
        If all else fails, we just pick a square. However, some squares are better than others. The center square is part of four triples, the corner squares are each part of three, and the edge squares each a mere two. So **we pick the center if it’s free, then a corner, then an edge**.  
  
    * How to structure `best-free-square`?  
          
        ```scheme  
        (define (best-free-square triples)   
          (first-choice (accumulate word triples)   
                        ’(5 1 3 7 9 2 4 6 8)))  
        ```  
  
    * How to define `first-choice`?  
          
        ```scheme  
        (define (first-choice possibilities preferences)  
          (first (keep (lambda (square) (member? square possibilities))   
                       preferences)))   
          
        (first-choice 123456789147258369159357 '(5 1 3 7 9 2 4 6 8))   
        ; 5   
          
        (first-choice "1xo4x6o8914oxx8o691x9oxo" '(5 1 3 7 9 2 4 6 8))   
        ; 1   
          
        (best-free-square (find-triples '_________))   
        ; 5   
          
        (best-free-square (find-triples '____x____))   
        ; 1   
        ```  
  
* Complete Program Listing  
      
    [github.com/mengsince1986/simplyScheme-mindmap-exercises/blob/master/SS Examples/C10-Complete Program Listing.scm][33]  
  
* Exercises 10.1-10.4  
      
    [github.com/mengsince1986/simplyScheme-mindmap-exercises/blob/master/SS Exercises/Exercises 10.1-10.4.scm][34]  
  
# …  
  
  
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
[11]: asy.png  
[12]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%207.1-7.2.scm  
[13]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%207.3-7.4.scm  
[14]: tvp.png  
[15]: dgq.png  
[16]: pbb.png  
[17]: mld.png  
[18]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%208.1-8.3.scm  
[19]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%208.4-8.14.scm  
[20]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%209.1-9.3.scm  
[21]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%209.4-9.17.scm  
[22]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Projects/scoring%20bridge%20hands.scm  
[23]: irp.png  
[24]: ysa.png  
[25]: ntk.png  
[26]: dpk.png  
[27]: ptn.png  
[28]: xul.png  
[29]: mgr.png  
[30]: aqc.png  
[31]: pxk.png  
[32]: ftx.png  
[33]: https://github.com/mengsince1986/simplyScheme-mindmap-exercises/blob/master/SS%20Examples/C10-Complete%20Program%20Listing.scm  
[34]: https://github.com/mengsince1986/simplyScheme-mindmap-exercises/blob/master/SS%20Exercises/Exercises%2010.1-10.4.scm  
