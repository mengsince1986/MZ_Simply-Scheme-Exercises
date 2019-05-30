; Exercises 18.1-18.6

; -------------------- tree constructor/selectors/predicates
(define (make-node datum children)
  (cons datum children))

(define (leaf datum)
  (make-node datum '()))

(define (leaf? node)
  (null? (children node)))

(define (datum node)
  (car node))

(define (children node)
  (cdr node))

; --------------------

; 18.1 What does

((SAN FRANCISCO))

; mean in the printout of world-tree? Why two sets of parentheses?

; answer: In the world-tree ((SAN FRANCISCO)) is the leaf node (city) of (CALIFORNIA). SAN FRANCISCO requires two sets of parentheses to make it the leaf node, otherwise, it becomes a tree with SAN as its datum and FRANCISCO as its child.

; **********************************************************

; 18.2 Suppose we change the definition of the tree constructor so that it uses list instead of cons :

(define (make-node datum children)
  (list datum children))

; How do we have to change the selectors so that everything still works?

; solution:

; it's not necessary to change datum function
(define (datum node)
  (car node))

(define (children node)
  (cadr node))

; **********************************************************


; 18.3 Write depth, a procedure that takes a tree as argument and returns the largest number of nodes connected through parent-child links. That is, a leaf node has depth 1; a tree in which all the children of the root node are leaves has depth 2. Our world tree has depth 4 (because the longest path from the root to a leaf is, for example, world, country, state, city).

; solution:
(define (depth tree)
  (if (null? tree)
      0
      (depth-helper (children tree))))

(define (depth-helper tree-children)
  (if (null? tree-children)
      1
      (+ (depth (car tree-children))
         (depth-helper (cdr tree-children)))))

; **********************************************************

; 18.4 Write count-nodes, a procedure that takes a tree as argument and returns the total number of nodes in the tree. (Earlier we counted the number of leaf nodes.)

; solution:
(define (count-nodes tree)
  (let ((tree-children (children tree)))
    (if (null? tree-children)
        1
        (+ 1 (count-nodes-in-forest tree-children)))))

(define (count-nodes-in-forest forest)
  (if (null? forest)
      0
      (+ (count-nodes (car forest))
         (count-nodes-in-forest (cdr forest)))))

; **********************************************************

; 18.5 Write prune, a procedure that takes a tree as argument and returns a copy of the tree, but with all the leaf nodes of the original tree removed. (If the argument to prune is a one-node tree, in which the root node has no children, then prune should return #f because the result of removing the root node wouldn’t be a tree.)

; solution:

(define (prune tree)
  (if (null? (children tree))
      #f
      (cons (car tree)
            (prune-forest (cdr tree)))))

(define (prune-forest forest)
  (if (null? forest)
      '()
      (let ((tree-nodes (prune (car forest)))
            (forest-nodes (prune-forest (cdr forest))))
        (if tree-nodes
            (cons tree-nodes forest-nodes)
            forest-nodes))))

; **********************************************************

; 18.6 Write a program parse-scheme that parses a Scheme arithmetic expression into the same kind of tree that parse produces for infix expressions. Assume that all procedure invocations in the Scheme expression have two arguments.

; The resulting tree should be a valid argument to compute :

(compute (parse-scheme '(* (+ 4 3) 2)))
; 14

; (You can solve this problem without the restriction to two-argument invocations if you rewrite compute so that it doesn’t assume every branch node has two children.)

; solution:

(define (parse-scheme expr)
  (cons (car expr)
        (parse-operands (cdr expr))))

(define (parse-operands operands)
  (cond ((null? operands) '())
        ((number? (car operands))
         (cons (list (car operands))
               (parse-operands (cdr operands))))
        (else (cons (parse-scheme (car operands))
                    (parse-operands (cdr operands))))))

; extra:

(define (compute tree)
  (if (< (length tree) 4)
      (if (number? (datum tree))
          (datum tree)
          ((function-named-by (datum tree))
           (compute (car (children tree)))
           (compute (cadr (children tree)))))
      ((function-named-by (datum tree))
       (compute (car (children tree)))
       (compute (cons (datum tree) (cddr tree))))))

(define (function-named-by oper)
  (cond ((equal? oper '+) +)
        ((equal? oper '-) -)
        ((equal? oper '*) *)
        ((equal? oper '/) /)
        (else (error "no such operator as" oper))))
