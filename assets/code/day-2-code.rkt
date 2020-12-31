#lang racket

;; `(the answer to ,a plus ,b is ,(+ a b))

;; (cons 'the (cons 'answer (cons 'to (cons a (cons 'plus ...)))))

(define (my-nursery-rhyme name size form)
  `(,name had a ,(cons 'very size) ,form))

;; come up with 5 patterns (skeletons) that will match this list pattern
;; come up with 5 skeletons for which '(a b c) is a filled-in version of that skeleton
(match '(a b c)
  (`(cons ,a (cons ,b (cons ,c '()))) 'yes-a-match)
  ;; (    'this-time-a-match)
  (else    'not-a-match))

(define cat 'meow)
(define a 'the-sun)
(define b 'come-out)
(define c 'tomorrow)
`(cons ,a (cons ,b (cons ,c '())))


;; C_a_R vs C_d_R 

(define (stutter ls)
  (match ls
    (`() '())
    (`(,a . ,d) `(,a . (,a . ,(stutter d))))))

;; length : takes a list and returns a number
;; length returns the number of elements in the list
;; > (length '(a b c))
;; 3
;; > (length '(a (b) c))
;; 3
;; > (length '())
;; 0
;; > (length '((a b c)))
;; 1

(define (length ls)
  (match ls
    (`() 0)
    (`(,a . ,d) (+ 1 (length d)))))

;; member? take an element and a list and return a boolean
;; member? decides if the element is in the list
;; > (member? 'x '(a b c))
;; #f
;; > (member? 'x '(a b x c x))
;; #t
;; > (member? 'x '(x b c))
;; #t
;; > (member? 'z '())
;; #f
;; > (member? 'x '(a b (c d x) z))
;; #f

(define (member? x ls)
  (match ls
    (`() #f)
    (`(,a . ,d)
     (cond
       ((equal? a x) #t)
       (else (member? x d))))))


;; Lists are () OR (cons element onto a List)
;; Match-lists are () OR (cons X onto a List) OR (cons a non-X onto a List) 


;; drop-first take an element and a list, and return a list
;; drop-first should remove the first occurrence of the element from the list (if it occurs)
;; > (drop-first 'x '(a b c))
;; '(a b c)
;; > (drop-first 'a '(c a b a d))
;; '(c b a d)
;; > (drop-first 'z '(z w x y))
;; '(w x y)
;; > (drop-first 'z '((z w x) z y))
;; '((z w x) y)

(define (drop-first x ls)
  (match ls
    (`() '()) 
    (`(,a . ,d)
     (cond
       ((equal? a x) d)
       (else `(,a . ,(drop-first x d)))))))








