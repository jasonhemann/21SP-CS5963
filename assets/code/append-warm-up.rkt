#lang racket
(require minikanren)

(define number-of-years '(a whole bunch))

(define (fill-in-this-skeleton number-of-years)
  `(literal data ,number-of-years))

(define (foo data)
  (match data
    [`(,fst ,snd) `(this list of two elements has ,fst first and ,snd second)]
    [`(,a . ,d) `(the a is ,a and the d is ,d)]
    [else #f]))

#|
(cond
  ((empty? ls1) ...)
  ((cons? ls1) ...))
|#

;; implement append
;; /without/ cons car cdr
;; w/ match, and quasiquote aka ` and unquote aka ,

#| 
> (append '(a b c) '(d))
'(a b c d)
> (append '() '(d))
'(d)
|#

#| 
> (append '(a b c) '(d . e)) => '(a b c d . e)
                                        
> (append   '(b c) '(d . e)) =>   '(b c d . e)
|#

;; append takes a list and a r-exp and returns an r-exp
;; append returns the result of recursively consing the elements of the list onto the r-exp
(define (append ls r-exp)
  (match ls
    [`() r-exp]
    [`(,a . ,d) `(,a . ,(append d r-exp))]))


(define (append2 ls r-exp)
  (match ls
    [`() r-exp]
    [`(,a . ,d)
     (let ((result (append2 d r-exp)))
       `(,a . ,result))]))

