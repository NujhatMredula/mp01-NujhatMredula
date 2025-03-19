#lang racket

(provide (all-defined-out)) ; export all top-level definitions for testing

(require racket/trace)

;; 1. Integer exponentiation
(define (iexpt n e)
  (if (= e 0)
      1
      (* n (iexpt n (- e 1)))))


;; 2. Polynomial evaluation
(define (poly-eval coeffs x)
  (foldl (lambda (coeff acc) (+ (* acc x) coeff)) 0 coeffs))


;; 3. List concatenation
(define (concatenate . lsts)
  (foldr append '() lsts))


;; 4. List ordered merging (non-tail-recursive)
(define (merge l1 l2)
  (cond [(null? l1) l2]
        [(null? l2) l1]
        [(<= (car l1) (car l2)) (cons (car l1) (merge (cdr l1) l2))]
        [else (cons (car l2) (merge l1 (cdr l2)))]))


;; 5. List ordered merging (tail-recursive)
(define (merge-tail l1 l2)
  (let merge-helper ([l1 l1] [l2 l2] [acc '()])
    (cond [(null? l1) (append (reverse acc) l2)]
          [(null? l2) (append (reverse acc) l1)]
          [(<= (car l1) (car l2)) (merge-helper (cdr l1) l2 (cons (car l1) acc))]
          [else (merge-helper l1 (cdr l2) (cons (car l2) acc))])))


;; 6. List run-length encoding
(define (run-length-encode lst)
  (if (null? lst)
      '()
      (let loop ([lst lst] [current (car lst)] [count 0] [acc '()])
        (cond [(null? lst) (reverse (cons (list current count) acc))]
              [(equal? (car lst) current) (loop (cdr lst) current (+ count 1) acc)]
              [else (loop (cdr lst) (car lst) 1 (cons (list current count) acc))]))))


;; 7. List run-length decoding
(define (run-length-decode lst)
  (apply append (map (lambda (pair) (make-list (cadr pair) (car pair))) lst)))


;; 8. Labeling sexps
(define (label-sexp sexp)
    (match sexp
      [(? integer?) `(int ,sexp)]
      [(? symbol?) `(var ,sexp)]
      [(list (and op (or '+ '* '/ '-)) lhs rhs)
       `(arith (op ,op) ,(label-sexp lhs) ,(label-sexp rhs))]
      [_ (error "Can't label!")]))
