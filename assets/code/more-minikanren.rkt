#lang racket
(require minikanren)
(require "numbers.rkt")

(define (append ls1 ls2)
  (match ls1
    [`() ls2]
    [`(,a . ,d) 
     (let ((res (append d ls2)))
       `(,a . ,res))]))

(define (appendo ls r-exp o)
  (conde
    ((== ls '())  (== r-exp o))
    ((fresh (a d)
       (== ls `(,a . ,d))
       (fresh (result)
         (== o `(,a . ,result))
         (appendo d r-exp result))))))

;; 1. implement reverse w/match & quasiquote and comma

(define (reverse ls)
  (match ls
    [`() `()]
    [`(,a . ,d)
     (let ((res (reverse d)))
       ;; guess what to do here.
       )]))

;; (reverse '(a b c d)) => '(d c b a)
;;                                  how do I go from v to ^
;; (reverse   '(b c d)) => '(d c b)




;; reverseo list <-> list
;; the latter has the elements of the former in the opposite order

;; 2. implement reverseo, the miniKanren relation.

;; > (run 1 (q) (reverseo '(a b c d e) '(e d c b a)))
;; '(_.0)

;; > (run 1 (q) (reverseo '(a b c d e) '(e d c b)))
;; '()

;; > (run* (q) (reverseo '(a b c d e) '(e d c b a)))
;; '(_.0)

;; > (run 1 (q) (reverseo '(a b c d e) q))
;; '((e d c b a))

;; > (run 1 (q) (reverseo q '(a b c d e)))
;; '((e d c b a))