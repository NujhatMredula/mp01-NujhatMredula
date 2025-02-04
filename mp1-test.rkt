#lang racket

(require rackunit
         "mp1.rkt")


(test-case "Integer exponentiation"
           (check-equal? (iexpt 100 0) 1)
           (check-equal? (iexpt 100 1) 100)
           (check-equal? (iexpt 5 2) 25)
           (check-equal? (iexpt 5 3) 125)
           (check-equal? (iexpt 2 10) 1024))

(test-case "Polynomial evaluation"
           (check-equal? (poly-eval '() 10) 0)
           (check-equal? (poly-eval '(100) 10) 100)
           (check-equal? (poly-eval '(100 10) 2) 120)
           (check-equal? (poly-eval '(8 4 3 2 1) 5)
                         (+ 8 (* 4 5) (* 3 25) (* 2 125) 625)))

(test-case "List concatenation"
           (define l1 '())
           (define l2 '(a b c))
           (define l3 '(d e f))
           (define l4 '(g (h (i) j) k))
           (check-equal? (concatenate l1 l1) '())
           (check-equal? (concatenate l2 l3) '(a b c d e f))
           (check-equal? (concatenate l2 l3 l4) '(a b c d e f g (h (i) j) k))
           (check-equal? (concatenate l1 l2 l1 l3 l1 l4 l1) '(a b c d e f g (h (i) j) k)))


(test-case "List ordered merging"
           (define l1 '())
           (define l2 '(1 3 5 7))
           (define l3 '(2 4 6 8))
           (define l4 '(1 8 100))
           (define l5 '(2 4 50 60 70))
           (check-equal? (merge l1 l2) '(1 3 5 7))
           (check-equal? (merge l2 l3) '(1 2 3 4 5 6 7 8))
           (check-equal? (merge l4 l5) '(1 2 4 8 50 60 70 100)))


(test-case "List ordered merging (tail-recursive)"
           (define l1 '())
           (define l2 '(1 3 5 7))
           (define l3 '(2 4 6 8))
           (define l4 '(1 8 100))
           (define l5 '(2 4 50 60 70))
           (check-equal? (merge-tail l1 l2) '(1 3 5 7))
           (check-equal? (merge-tail l2 l3) '(1 2 3 4 5 6 7 8))
           (check-equal? (merge-tail l4 l5) '(1 2 4 8 50 60 70 100)))

(test-case "List run-length encoding"
           (check-equal? (run-length-encode '()) '())
           (check-equal? (run-length-encode '(a)) '((a 1)))
           (check-equal? (run-length-encode '(a a a a a)) '((a 5)))
           (check-equal? (run-length-encode '(a b c)) '((a 1) (b 1) (c 1)))
           (check-equal? (run-length-encode '(a a a b b c d d d d d e e))
                         '((a 3) (b 2) (c 1) (d 5) (e 2))))


(test-case "List run-length decoding"
           (check-equal? (run-length-decode '((a 1))) '(a))
           (check-equal? (run-length-decode '((a 5))) '(a a a a a))
           (check-equal? (run-length-decode '((a 3) (b 2) (c 1))) '(a a a b b c)))


(test-case "List run-length encode/decode"
           (define l1 '(1 1 2 3 2 2 2 1 1 3 3 4 4 2 2 2 2 2 1 2 1 3))
           (define l2 '(j k j j k k k 1 1 2 2 j j j m m 3 3 2 1 1 1 1 k))
           (check-equal? (run-length-decode (run-length-encode l1)) l1)
           (check-equal? (run-length-decode (run-length-encode l2)) l2))


(test-case "Labeling sexps"
           (check-equal? (label-sexp 42)
                         '(int 42))
           (check-equal? (label-sexp 'x)
                         '(var x))
           (check-equal? (label-sexp 'foo)
                         '(var foo))
           (check-equal? (label-sexp '(+ 2 4))
                         '(arith (op +) (int 2) (int 4)))
           (check-equal? (label-sexp '(* x 100))
                         '(arith (op *) (var x) (int 100)))
           (check-equal? (label-sexp '(+ (* 2 3) (+ 1 8)))
                         '(arith (op +)
                                 (arith (op *) (int 2) (int 3))
                                 (arith (op +) (int 1) (int 8))))
           (check-equal? (label-sexp '(foo 42))
                         '(funcall (name foo) (int 42)))
           (check-equal? (label-sexp '(foo x))
                         '(funcall (name foo) (var x)))
           (check-equal? (label-sexp '(foo (+ x (bar 8))))
                         '(funcall (name foo)
                                   (arith (op +)
                                          (var x)
                                          (funcall (name bar)
                                                   (int 8))))))