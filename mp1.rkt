#lang racket

(provide (all-defined-out)) ; export all top-level definitions for testing

(require racket/trace)


;; 1. Integer exponentiation
(define (iexpt n e)
  (void))


;; 2. Polynomial evaluation
(define (poly-eval coeffs x)
  (void))


;; 3. List concatenation
(define (concatenate . lsts)
  (void))


;; 4. List ordered merging (non-tail-recursive)
(define (merge l1 l2)
  (void))


;; 5. List ordered merging (tail-recursive)
(define (merge-tail l1 l2)
  (void))


;; 6. List run-length encoding
(define (run-length-encode lst)
  (void))


;; 7. List run-length decoding
(define (run-length-decode lst)
  (void))
                 

;; 8. Labeling sexps
(define (label-sexp sexp)
    (match sexp
      [(? integer?)
       `(int ,sexp)]

      [(? symbol?)
       `(var ,sexp)]

      [(list (and op (or '+ '* '/ '-)) lhs rhs)
       `(arith (op ,op) ,lhs ,rhs)]


      [_ (error "Can't label!")]))
      