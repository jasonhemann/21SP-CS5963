#lang racket
(require "mk.rkt")

(define (lookup env y o)
  (fresh (x a res)
    (== `((,x . ,a) . ,res) env)
    (conde
      ((== y x) a)
      ((=/= y x) (lookup res y o)))))

(define (valsof args env o)
  (conde
    [(== args `()) (== o '())]
    [(fresh (expr res)
       (== args `(,expr . ,res))
       (fresh (v vs)
         (== `(,v . ,vs) o)
         (valof expr env v)
         (valsof res env vs)))]))

;; Eval :: Expression -> Env -> Value 
(define (valof expr env o)
  (conde
    [(numbero expr) (== expr o)]
    [(symbolo expr) (lookup env expr o)]
    [(fresh (x b)
       (symbolo x)
       (== expr `(lambda (,x) ,b))
       (== `(closure ,x ,b ,env) o))]
    [(== expr `(quote ,o))]
    [(fresh (args)
       (== expr `(list . ,args))
       (valsof args env o))]
    [(fresh (rator rand)
       (== expr `(,rator ,rand))
       (fresh (x b env^ a)
         (valof rator env `(closure ,x ,b ,env^))    
         (valof rand env a)
         (valof b `((,x . ,a) . ,env^) o)))]))

