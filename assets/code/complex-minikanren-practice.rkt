#lang racket
(require minikanren)
(require "numbers.rkt")



#| 

**0.** ''count-occurrenceso''

|# 

;; "miniKanrenize" the following function counting the occurrences of
;; an element in a list. Remember to work in all modes, you'll want to
;; use relational numbers.


;; > (define (count-occurrences x ls)
;;     (match ls
;;       [`() 0]
;;       [`(,a . ,d)
;;         (cond 
;;           ((equal? a x)
;;            (let ((ct (count-occurrences x d)))
;;              (+ 1 ct)))
;;           ((not (equal? a x)) (count-occurrences x d)))]))

#| 

**1.** ''listo''

This is intended to operate similarly to racket's ''list?''

|# 

;; > (run 1 (q) (listo '(a b c d e)))
;; (_.0)

;; > (run 1 (q) (listo '(a b c d . e)))
;; ()

;; > (run 4 (q) (listo q))
;; (() (_.0) (_.0 _.1) (_.0 _.1 _.2))

;; > (run 4 (q) (listo `(a b ,q)))
;; (_.0)

#| 

**2.** ''facto'' Build a relation that holds between two backward-binary numbers whenever the second is the factorial of the first. Use the backwards-binary arithmetic primitives found in {{:miniKanren.scm}}, and described in chapters 7 & 8 of //The// //Reasoned// //Schemer//.

|# 

;; > (run 1 (q) (facto  q '(0 0 0 1 1 1 1)))
;; ((1 0 1))

;; > (run 1 (q) (facto (build-num 5) q))
;; ((0 0 0 1 1 1 1))

;; > (run 6 (q) (fresh (n1 n2) (facto n1 n2) (== `(,n1 ,n2) q)))
;; ((() (1))
;;  ((1) (1))
;;  ((0 1) (0 1))
;;  ((1 1) (0 1 1))
;;  ((0 0 1) (0 0 0 1 1))
;;  ((1 0 1) (0 0 0 1 1 1 1)))

#| 

**3.** ''fibs'' Plain old fibonacci has had its day. Let's do something more fun. And in the process, learn a technique sometimes of use when building miniKanren relations. Here, we're going to take a function ''fibs'' which takes one input and returns two values, and make a three-place relation ''fibso''. Check out the definition of ''fibs'':

|# 

;; > (define fibs
;;     (lambda (n)
;;       (cond
;;         ((eqv? n 0) (values 1 1))
;;         (else
;;          (let ((n- (- n 1)))
;;            (let-values (((u v) (fibs n-)))
;;              (let ((u+v (+ u v)))
;;                (values v u+v))))))))
;; > (fibs 0)
;; 1
;; 1
;; > (fibs 1)
;; 1
;; 2
;; > (fibs 2)
;; 2
;; 3
;; > (fibs 3)
;; 3
;; 5


;; We use ''values'', which allows a Racket function to return
;; multiple output values. This function returns the nth and n+1th
;; fibonacci number. Since ''fibs'' returns two values, we need to use
;; ''let-values'' when let binding the recursive call. Here, the first
;; answer is bound to ''u'' and the second is bound to ''v''. When
;; writing ''fibso'' you will need to use two "output variables" in
;; your relation, rather than just one like we usually do.


;; > (run 4 (q)
;;     (fresh (n o1 o2)
;;       (== q `(,n ,o1 ,o2))
;;       (fibso n o1 o2)))
;; ((() (1) (1))
;;  ((1) (1) (0 1))
;;  ((0 1) (0 1) (1 1))
;;  ((1 1) (1 1) (1 0 1)))
;; > (run 1 (q)
;;     (fresh (n o1)
;;       (== q `(,n ,o1))
;;       (fibso n o1 (build-num 5))))
;; (((1 1) (1 1)))
;; > (run 1 (q)
;;     (fresh (n o2)
;;       (== q `(,n ,o2))
;;       (fibso n (build-num 5) o2)))
;; (((0 0 1) (0 0 0 1)))

