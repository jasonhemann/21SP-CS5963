#lang racket

#| 

Here are some additional practice problems for students who want to do
some more. 


|#

;; cons-tree is (cons of cons-tree cons-tree) OR an atom
;; BTW, atom `atomic` means non-cons things, like symbols, numbers, booleans, or ().

;; count-conses: takes any cons-tree in our language, and returns a number
;; count-conses counts the number of conses it takes to construct the input tree
;; > (count-conses '(a b c d))
;; 4
;; > (count-conses '()
;; 0
;; > (count-conses 5)
;; 0
;; > (count-conses '(a . b))
;; 1
;; > (count-conses (cons 'a 'b))
;; 1
;; > (count-conses '(((a . b) . c) . d)
;; 3


;; nested-symbol-list is () OR (cons symbol nested-symbol-list) OR (cons nested-symbol-list nested-symbol-list)

;; flatten: takes any nested-symbol-list and returns a list
;; flatten returns a single, flat list of the elements of the nested list
;; > (flatten '(a (b) ((c d) e) f (g)))
;; '(a b c d e f g)
;; > (flatten '(((((a))))))
;; '(a)
;; > (flatten '(c a b))
;; '(c a b)


;; deep-remove-first: takes a symbol and a nested-symbol-list and returns a nested-symbol-list 
;; deep-remove-first returns a nested-symbol-list like the input list, but without the first occurrence of the input symbol
;; > (deep-remove-first 'g '(d (b) ((g d) e) f (g)))
;; '(d (b) ((d) e) f (g))
;; > (deep-remove-first 'b '(d (b) ((g d) e) f (g)))
;; '(d () ((g d) e) f (g))
;; > (deep-remove-first 'g '(c a b))
;; '(c a b)



