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

      )))
