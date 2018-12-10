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
  
[1]: https://github.com/mengsince1986/simplyScheme/blob/master/SS%20Exercises/Exercises%202.1-2.9.scm  
