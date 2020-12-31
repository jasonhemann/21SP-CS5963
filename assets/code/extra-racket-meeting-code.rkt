#lang racket


;; zip takes two lists of any contents, and returns a list

;; zip should pair together elements in turn from the two lists, ending whenever a list is empty.

;; > (zip '(a b c) '(d e f))
;; '((a . d) (b . e) (c . f))

;; > (zip '(a b) '())
;; '()

;; > (zip '(a b (c d)) '(d e f g))
;; '((a . d) (b . e) ((c d) . f))

;; We want to solve                 the answer should be 
;; (zip '(a b (c d)) '(d e f g)) => '((a . d) (b . e) ((c d) . f))
;;;                                                                how do we go from v to ^ 
;; we try to get ^ from this one    and we trust the answer is v 
;; (zip   '(b (c d))   '(e f g))     =>      '((b . e) ((c d) . f))

(define (zip ls1 ls2)
  (cond
    ((empty? ls1) '()) ;; we had two base cases!? 
    ((empty? ls2) '())
    (else
     
     (cons (cons (car ls1) (car ls2)) (zip (cdr ls1) (cdr ls2))))))

#|
> (append2 '(a b c) '(d))
'(a b c d)
> (append2 '() '(d))
'(d)
> (append2 '(a b c) '(d . e))
'(a b c d . e)
|#

(define (append2 ls1 ls2)
  (cond
    ((empty? ls1) ls2)
    (else (cons (car ls1) (append2 (cdr ls1) ls2)))))


;; reverse takes a list and returns a list
;; creates a list in the reverse order of the original list

;; > (reverse2 '())
;; '()
;; > (reverse2 '(a b c))
;; '(c b a)
;; > (reverse2 '(a))
;; '(a)
;; > (reverse2 '(a b (c d)))
;; '((c d) b a)


;; (reverse2 '(a b c))   => '(c b a)
;;                                       how do we go from v to ^
;; (reverse2   '(b c))   => '(c b)

(define (reverse2 ls)
  (cond
    ((empty? ls) '())
    (else (append2 (reverse2 (cdr ls))
                   (cons (car ls) '())))))


;; construct a list with ls as the prefix and (x) as the suffix or "tail" of the list
(define (rev-help x ls)
  (cond
    ((empty? ls) (cons x '()))
    (else (cons (car ls) (rev-help x (cdr ls))))))

(define (reverse3 ls)
  (cond
    ((empty? ls) '())
    (else (rev-help (car ls) (reverse3 (cdr ls))))))


;; map takes a 1-argument function and a list, and returns a list of the results of calling that function.

;; > (map add1 '(2 4 5))
;; '(3 5 6)
;; > (map reverse2 '((a b c) (d e f) (g h i)))
;; '((c b a) (f e d) (i h g))

(define (add1-to-every ls)
  (cond
    ((empty? ls) '())
    (else (cons (add1 (car ls)) (add1-to-every (cdr ls))))))

(define (rev2-every ls)
  (cond
    ((empty? ls) '())
    (else (cons (reverse2 (car ls)) (rev2-every (cdr ls))))))

(define (map op ls)
  (cond
    ((empty? ls) '())
    (else (cons (op (car ls)) (map op (cdr ls))))))