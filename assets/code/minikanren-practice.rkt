#lang racket
(require minikanren)

;; miniKanren Practice Problems


;; stuttero

;; Transform the below implementation of `stutter` into the miniKanren
;; relation `stuttero`. We implemented `stutter` with `match` in order
;; to simplify your task.


(define (stutter ls)
  (match ls
    (`() '())
    (`(,a . ,d)
     (let ((res (stutter d)))
       `(,a ,a . ,res)))))

;; cons-everyo

;; Take our implementation of `cons-every` from
;; https://pages.github.ccs.neu.edu/jhemann/21SP-CS5963/lec/lec1/#cons-every
;; and convert it to a miniKanren relation `cons-everyo`


;; Qs for thought further thought



;; 1. At the time we wrote `cons-everyo`, we could have just
;; implmented `cons-everyo` with `map`
;; https://pages.github.ccs.neu.edu/jhemann/21SP-CS5963/lec/lec1/#map
;; Why is it more convenient for miniKanren-izing to have the version
;; we do.


;; 2. Consider the behavior of Racket's `remove` function.

;; > (remove 'x '(a b x c d x))
;; '(a b c d x)
;; > (remove 'x '(a b))
;; '(a b)
;; > 

;; First, try to write your own implementation of `removeo` the
;; miniKanren version of Racket's `remove`.

;; Ii magine you will come up with something that doesn't work
;; entirely like you would expect.

;; > (run* (q) (removeo 'x '(a b x c d x)))

;; If so, what is causing this behavior? 
