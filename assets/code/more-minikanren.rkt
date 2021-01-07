#lang racket
(require minikanren)
(require racket/trace)
(require rackunit)
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

(trace-define (reverse ls)
  (match ls
    [`() `()]
    [`(,a . ,d)
     (let ((res (reverse d)))
       (append res `(,a)))]))

(trace-define (reverse2 ls acc)
  (match ls
    [`() acc]
    [`(,a . ,d) (reverse2 d `(,a . ,acc))]))

;; (reverse '(a b c d)) => '(d c b a)
;;                                  how do I go from v to ^
;; (reverse   '(b c d)) => '(d c b)

;; reverseo list <-> list
;; the latter has the elements of the former in the opposite order

(define (reverseo ls o)
  (conde
    [(== ls `()) (== o `())]
    [(fresh (a d)
       (== ls `(,a . ,d))
       (fresh (res)
         (reverseo d res)
         (appendo res `(,a) o)))]))

;; 2. implement reverseo, the miniKanren relation.

(check-equal? (run 1 (q) (reverseo '(a b c d e) '(e d c b a))) '(_.0))

(check-equal? (run 1 (q) (reverseo '(a b c d e) '(e d c b)))
'())

(check-equal? (run* (q) (reverseo '(a b c d e) '(e d c b a)))
 '(_.0))

(check-equal? (run 1 (q) (reverseo '(a b c d e) q))
'((e d c b a)))

(check-equal? (run 1 (q) (reverseo q '(a b c d e)))
 '((e d c b a)))

;; "the remove relation"
;; miniKanren numbers
;; project

(define (remove x ls)
  (match ls
    [`() `()]
    [`(,a . ,d)
     (cond
       ((equal? x a) d)
       ((not (equal? x a)) (let ((res (remove x d)))
                             `(,a . ,res))))]))
        
(define (removeo x ls o)
  (conde
    ((== ls '()) (== o '()))
    ((fresh (a d)
       (== ls `(,a . ,d))
       (conde
         ((== x a) (== d o))
         ((=/= x a)
          (fresh (res)
            (== `(,a . ,res) o)                    
            (removeo x d res))))))))

;; miniKanren numbers

;; ones twos fours eights sixteens ...
;; (1   1     0     0    1)
;;  1 + 2 + 16

;; start big -> go to the smaller bits
;; start small go toward the larger bits***

