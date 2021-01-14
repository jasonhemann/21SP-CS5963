#lang racket


;; Our variables are Racket's numbers
(define (var n) n)
(define (var? n) (number? n))

#|

An atomic term is one of:
 | symbol
 | variable
 | boolean
 | () 

A term is one of:
 | atomic term
 | cons term term

|#


#|
An association is a (cons var term)

A substitution is a Listof associations
without any cycles
|#

(define my-subst '((3 . cat) (2 . turtle) (4 . fish) (1 . (sea . 2))))

;; var and a subst and returns a term
(define (walk x s)
  (let ((pr (assv x s)))
    (if pr (walk (cdr pr) s) x)))

(define my-new-subst '((1 . turtle) (2 . 1) (3 . 2) (4 . 3)))

(define a-terrible-subst '((2 . 1) (1 . 2) (3 . 3) (4 . (turtle . 4))))

;; var and term and subst and returns a boolean
;; determines if x is present in v wrt substitution s
(define (occurs? x v s)
  (cond
    ((var? v) (eqv? x v))
    ((cons? v)
     (or (occurs? x (walk (car v) s) s)
         (occurs? x (walk (cdr v) s) s)))
    (else #f)))

;; var and a term and a subst and returns (maybe) a subst
;; extends the subst w (x . v) unless x occurs in v; then it fails (returns #f)
(define (ext-s x v s)
  (cond
    ((occurs? x v s) #f)
    (else `((,x . ,v) . ,s))))

;; takes two terms and a substitution, and retuns (maybe) a substitution showing
;; how to make u and v equal wrt all the equations we already have in the substiution
;; fails if the two terms cannot be equal wrt s.

(define (unify u v s)
  (let ((u (walk u s))
        (v (walk v s)))
    (cond
      ((eqv? u v) s) ;; are they the same var already?
      ((var? u) (ext-s u v s)) ;; if they are not already the same, and the first is a var, try to
                               ;; make them the same
      ((var? v) (ext-s v u s)) ;; same deal, but if v is a variable
      ((and (cons? u) (cons? v))
       (let ((new-s (unify (car u) (car v) s)))
         (and new-s (unify (cdr u) (cdr v) new-s))))
      (else #f))))

;; a goal is a function that takes an state and returns a list of states
;; a state is a pair of a subst and a next variable counter

;; takes two terms and returns a goal
(define ((== u v) st)
  (let ((s (car st))
        (var-ct (cdr st)))
    (let ((new-s (unify u v s)))
      (if new-s (list `(,new-s . ,var-ct)) '()))))

;; spoiler alert--we'll need to change a few things.
;; takes a goal and returns a list of states
(define (fake-run g)
  (g '(() . 0)))

#|

(fake-run
  (call/fresh
    (lambda (x)
      (== 'cat x))))

|#


(define (f x)
  (+ 2 x))

(define f2
  (lambda (x) (+ 2 x)))

;; f is a function that eats a variable and returns a goal
;; (lambda (x) (== x 'cat))
(define ((call/fresh f) state)
  (let ((s (car state))
        (c (cdr state)))
    ((f (var c)) ;; this expression is a goal
     `(,s . ,(add1 c)))))


(fake-run
 (call/fresh
   (lambda (x)
     (call/fresh
       (lambda (y)
         (== x `(fish . ,y)))))))


;; ==
;; (fresh (x y ...) ...)

;; disj is a goal constructor
;; which is my fancy way of saying it eats two goals and returns a goal
(define (disj g1 g2)
  (lambda (state)
    ($app (g1 state) (g2 state))))

;; conj is a goal constructor
;; which is my fancy way of saying it eats two goals and returns a goal
(define (conj g1 g2)
  (lambda (state)
   ($app-map (g1 state) g2)))

(define ($app $1 $2)
  (cond
    ((empty? $1) $2)
    ((cons? $1) (cons (car $1) ($app (cdr $1) $2)))
    ((procedure? $1) (lambda () ($app $2 ($1))))))

(define ($app-map $ g)
  (cond
    ((empty? $) '())
    ((cons? $)
     ($app (g (car $)) ($app-map (cdr $) g)))
    ((procedure? $)
     (lambda () ($app-map ($) g)))))

;; ==
;; fresh
;; conj
;; disj
;; ~ run

(define (turtles x)
  (lambda (state)
    (lambda ()
      ((disj
        (== x 'turtle)
        (turtles x))
       state))))

(define (cats x)
  (lambda (state)
    (lambda ()
      ((disj
        (== x 'cat)
        (cats x))
       state))))


(define (pull $)
  (if (procedure? $) (pull ($)) $))

(define (take n $)
  (cond
    ((zero? n) '())
    ((empty? $) '())
    ((equal? n 1) (list (car (pull $))))
    (else
     (let ((p$ (pull $)))
       (cons (car p$) (take (sub1 n) (cdr p$)))))))

(define (run n g)
  (take n (fake-run g)))


;; conj
;; disj
;; ==
;; fesh
;; run
;; interleaving search
;; w/recursions
;; w/max #s of answers