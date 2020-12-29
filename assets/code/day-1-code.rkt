#lang racket
(require minikanren)

#|

List of symbols = () or cons symbol onto a List of symbols

|#


;; y-after-x takes a list and returns a list
;; Add a y after every x in a list

;; (y-after-x '())
;; '()
;; (y-after-x '(x))
;; '(x y)
;; (y-after-x '(x x))
;; '(x y x y)
;; (y-after-x '(a b y c y))
;; '(a b y c y)

#|
(y-after-x '(y b x)) => '(y b x y)
(y-after-x   '(b x)) =>   '(b x y)
|#

;; L = () OR cons x L OR cons non-x L

(define (y-after-x ls)
  (cond ;; "conditional" i.e. "if-then-else"
    ((empty? ls) '())
    ((equal? (car ls) 'x)
     (cons 'x (cons 'y (y-after-x (cdr ls)))))
    ((not (equal? (car ls) 'x))
     (cons (car ls)
           (y-after-x (cdr ls))))))


;; cons-every symbol and a list
;; conses that symbol onto every element of the list

;; > (cons-every 'x '(a b c d))
;; '((x . a) (x . b) (x . c) (x . d))
;; > (cons-every 'y '())
;; '()
;; > (cons-every 'a '(d e f))
;; '((a . d) (a . e) (a . f))

(define (cons-every x ls)
  (cond
    ((empty? ls) '())
    (else (cons (cons x (car ls)) (cons-every x (cdr ls))))))



