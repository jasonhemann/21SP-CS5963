#lang racket
(require minikanren)

;; run
;; ==
;; fresh
;; conde

(define (direct-flight from to)
  (conde
   ((== from 'boston) (== to 'seattle))
   ((== from 'portland) (== to 'las-vegas))
   ((== from 'dallas) (== to 'omaha))
   ((== from 'atlanta) (== to 'miami))
   ((== from 'philadelphia) (== to 'atlanta))
   ((== from 'new-york) (== to 'philadelphia))
   ((== from 'boston) (== to 'philadelphia))
   ((== from 'atlanta) (== to 'savannah))
   ((== from 'las-vegas) (== to 'chicago))
   ((== from 'chicago) (== to 'philadelphia))))

(define (route from to)
  (conde
    ((direct-flight from to))
    ((fresh (layover)
       (direct-flight from layover)
       (route layover to)))))

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

'((() (a b c 1 2 3))
  ((a) (b c 1 2 3))
  ((a b) (c 1 2 3))
  ((a b c) (1 2 3))
  ((a b c 1) (2 3))
  ((a b c 1 2) (3))
  ((a b c 1 2 3) ()))

