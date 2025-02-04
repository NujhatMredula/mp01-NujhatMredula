# CS 440 MP1

In this first machine problem you will be implementing a number of different
Racket functions that make use of recursion (tail and non-tail), manipulate
lists, and perform pattern matching.

All the code you write for this machine problem will go into the "mp1.rkt" file,
found in the private source repository created when you accepted my GitHub
invitation. In that file you will find stubs for each of the programming
exercises described below.

## Exercises

Each exercise below requires you to implement a single function. Unless
explicitly mentioned, you should not use any built-in functions or special forms
not yet covered in class. If you wish, however, you may implement additional
helper functions on top of the required ones.

Note that some exercises specify whether your solution should be tail-recursive
(or not). If unspecified, you may do either.

Each exercise is worth 5 points, for a total of 40 possible points.

1.  `iexpt`: Performs integer exponentiation (assuming positive, integer
    arguments). Given arguments `n` and `e`, computes `n`<sup>`e`</sup>. E.g.,

         > (iexpt 2 10)
         1024

         > (iexpt 5 3)
         125

2.  `poly-eval`: Given `coeffs` and `x`, where `coeffs` is a list of integer
    coefficients (_a_, _b_, _c_, ...) and `x` is an integer, computes the value
    of the polynomial _ax<sup>0</sup> + bx<sup>1</sup> + cx<sup>2</sup> + ..._
    E.g.,

         > (poly-eval '(2 3 4) 2)
         24

         > (poly-eval '() 10)
         0

         > (poly-eval '(8 4 2 1) 4)
         120

    Your implementation should be tail-recursive. You may use `iexpt` from the
    previous exercise.

3.  `concatenate`: Given zero or more list arguments, concatenates all the
    elements of the argument lists into a single list. E.g.,

         > (concatenate '(1 2 3) '(hi bye) '(4 5 6))
         '(1 2 3 hi bye 4 5 6)

         > (concatenate '(a (b) c) '() '((d) (42 43)))
         '(a (b) c (d) (42 43))

    Your implementation should be tail-recursive. Additionally, when building
    your result list, you should only use `cons`, and your implementation should
    have linear runtime w.r.t. the total number of elements. Hint: it might be
    helpful to use `reverse` at some point in your implementation!

4.  `merge`: Takes two argument lists, both of which contain only integers and
    are in ascending order. Returns a single list containing all the integers,
    sorted in ascending order. E.g.,

         > (merge '(1 4 8 10) '(2 3 7 13))
         '(1 2 3 4 7 8 10 13)

    Your implementation should _not_ be tail-recursive (we'll do that next).

5.  `merge-tail`: re-implement the previous function, but this time your
    implementation should be tail-recursive. As with your implementation of
    `concatenate`, you may only use the `cons` function to build your result
    list, and it should have linear runtime w.r.t. the total number of integers.

6.  `run-length-encode`: returns a run-length encoding of the argument list.
    Run-length encoding stores each value together with the number of times it
    appears (contiguously) — in this way, a value that is repeated multiple
    times can be more efficiently represented. E.g.,

         > (run-length-encode '(a a a a a b b b))
         '((a 5) (b 3))

         > (run-length-encode '(a a a b a a c c c b b))
         '((a 3) (b 1) (a 2) (c 3) (b 2))

    Your implementation should be tail recursive. You may assume that adjacent
    elements can be compared for equality using `equal?`.

7.  `run-length-decode`: given a run-length encoded list argument, returns the
    original list. E.g.,

         > (run-length-decode '((a 5) (b 3)))
         '(a a a a a b b b)

         > (run-length-decode '((5 3) (12 2)))
         '(5 5 5 12 12)

8.  `label-sexp`: returns a "labeled" version of the argument sexp. The labeling
    is based on a simplified understanding of the Racket language, where a sexp
    is one of:

    - an integer atom; e.g., `42`
    - a symbol atom (which is interpreted as a variable name); e.g., `x`, `num`
    - an arithmetic expression, which is a list starting with `+`, `*`, `/`, or
      `-`, and followed by two argument sexps; e.g., `(+ 4 5)`, `(* x (+ 1 2))`
    - a function call, which is a list that starts with a symbol and is followed
      by a single argument sexp; e.g., `(foo 42)`, `(bar (+ 5 (foo 10)))`

    The labeled version of a sexp will enclose each of the original components
    within a list with a label, which is one of `int`, `var`, `arith`, `op`,
    `funcall`, or `name`. E.g., (indentation added for clarity)

         > (label-sexp 42)
         '(int 42)

         > (label-sexp 'x)
         '(var x)

         > (label-sexp '(+ 1 2))
         '(arith (op +) (int 1) (int 2))

         > (label-sexp '(+ 1 (* x 2)))
         '(arith (op +)
                 (int 1)
                 (arith (op *)
                        (var x)
                        (int 2)))

         > (label-sexp '(foo 42))
         '(funcall (name foo) (int 42))

         > (label-sexp '(foo (+ 5 (foo 10))))
         '(funcall (name foo)
                   (arith (op +)
                          (int 5)
                          (funcall (name foo) (int 10))))

    You may find it quite helpful to use `match` and quasiquoting (to construct
    your labeled expressions). We've provided you with a bit of starter code.

## Testing

We've provided you with tests for every exercise in the "mp1-tests.rkt" source
file. If you open the file you'll find that there are a bunch of definitions
that looks like this:

    (test-case "Integer exponentiation"
               (check-equal? (iexpt 100 0) 1)
               (check-equal? (iexpt 100 1) 100)
               (check-equal? (iexpt 5 2) 25)
               (check-equal? (iexpt 5 3) 125)
               (check-equal? (iexpt 2 10) 1024))

This defines a test case (here, for the `iexpt` function). The `check-equal?`
calls are assertions. If they fail, they will produce errors that looks like
this:

    --------------------
    Integer exponentiation
    . FAILURE
    name:       check-equal?
    location:   mp1-test.rkt:8:11
    actual:     2
    expected:   1
    --------------------

You can run the tests by loading the file in DrRacket and evaluating it. Note
that while passing all the tests is a good indication that your solutions are on
the right track, we don't guarantee exhaustive test coverage, nor that passing
all tests will results in 100% on the assignment! (E.g., we will be checking for
tail-recursive implementations manually).

## Submission

First, be sure to complete the "REPORT.md" file. It is worth 5 points!

When you are done with your work, simply commit your changes and push them to
our shared private GitHub repository. Remember that you can check if your submission was successful by simply viewing your GitHub repository page.
