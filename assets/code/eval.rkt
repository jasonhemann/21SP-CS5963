#lang racket


(define (lookup env y)
  (match-let ((`((,x . ,a) . ,res) env))
    (cond
      ((equal? y x) a)
      ((not (equal? y x)) (lookup res y)))))

(define (valsof args env)
  (match args
    [`() '()]
    [`(,expr . ,res)
     (let ((v (valof expr env))
           (vs (valsof res env)))
       `(,v . ,vs))]))

;; Eval :: Expression -> Env -> Value 
(define (valof expr env)
  (match expr
    [`,n #:when (number? n) n]
    ;; the variables line
    [`,y #:when (symbol? y) (lookup env y)]
    [`(lambda (,x) ,b) `(closure ,x ,b ,env)]
    [`(quote ,data) data]
    [`(list . ,args) (valsof args env)]
;;    [`(+ ,e1 ,e2) (+ (valof e1 env) (valof e2 env))]
    [`(,rator ,rand)
     (match-let ((`(closure ,x ,b ,env^) (valof rator env))    
                 (a (valof rand env)))
       (valof b `((,x . ,a) . ,env^)))]))

