---
title: More Racketry, quasiquotes, commas, and patterns.
date: 2021-12-31
---

# Warm-Up

`length`

```
(define (length ls)
  (cond
    ((empty? ls) 0)
	(else (add1 (length (cdr ls))))))
```

# Quotes, vs. Quasi-quotes

## A Quote

I was reading [an article on
combinators](https://writings.stephenwolfram.com/2020/12/where-did-combinators-come-from-hunting-the-story-of-moses-schonfinkel/). Just
a faaascinating story.

> "So what traces are there of Moses Schönfinkel in Ekaterinoslav (AKA
> Dnipro) today? 132 years later it wasn’t so easy to find (especially
> during a pandemic)… but here’s a record of his birth: a certificate
> from the Ekaterinoslav Public Rabbi stating that entry 272 of the
> Birth Register for Jews from 1888 records that on September 7, 1888,
> a son Moses was born to the Ekaterinoslav citizen Ilya Schönfinkel
> and his wife Masha:"

> - Stephen Wolfram "Where Did Combinators Come From? Hunting the
>   Story of Moses Schönfinkel"

Remember that we Racketeers don't need the closing quote. Why? Because
'( ... ) the matching close parenthesis tells us where the quote ends.

## Quasiquotes and commas and patterns and pattern matching

"[H]ere’s a record of his birth:" an excited Wolfram writes, "a son
 Moses was born to the Ekaterinoslav citizen Ilya Schönfinkel and his
 wife Masha."

This is not a quotation. Parts of it are the same, but there are some
adjustments. The reporter (me) changed some parts of the original
writing. So it's sort-of a quotation. Or a quasi-quotation - "quasi"
(approx) synonymous prefixes: pseudo, semi, demi.

### Think of it as like a general "skeleton", and we fill in the pieces.

We give the general skeleton, and fill in the particular pieces. 

### Why would we use it? It's nice to see the structure, to *see* the shape of the data.


## `match` -- like `cond`, but w/patterns.

(match '(a b c)
  (?????    'yes)
  (else     'no))

### Why? Because the structure is sometimes very nice. 

```
'(define (length ls)
   (cond
     ((empty? ls) 0)
 	 (else (add1 (length (cdr ls))))))
```	

```
(match expr
  (`(define (,name ,arg1) ,body) 'a-function) ;; I invite you to try this with `car`s and `cdr`s
  (else 'not-a-function))
```

## The same kinds of programs, but differently. 

### `stutter` 

```
(define (stutter ls)
  (match ls
    ('() '())
	(`(,a . ,d) `(,a ,a . ,(stutter d)))))
```	

### `length`

```
(define (length ls)
  (match ls
    (`() 0)
	(`(,_ . ,d) (add1 (length d)))
```	

### `drop-first`

```
(define (drop-first x ls)
  (match ls
    ('() '())
	(`(,a . ,d)
	  (cond
	    ((equal? a x) d)
		(else `(,a . ,(drop-first d)))))))
```		
	  
	  
### `member?`

```
(define (member? x ls)
  (match ls
    ('() #f)
	(`(,a . ,d)
	  (cond
	    ((equal? a x) #t)
		(else (member? x d))))))
```

