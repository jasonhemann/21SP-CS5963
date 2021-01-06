---
title: More Racketry, quasiquotes, commas, and patterns.
date: 2020-12-31
---

# Warm-Up

`stutter`

```
(define (stutter ls)
  (cond
    ((empty? ls) '())
	(else (cons (car ls) (cons (car ls) (stutter (cdr ls)))))))
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

```
(match '(a b c)
  (?????    'yes)
  (else     'no))
```

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

## You try

### `length`

### `drop-first`

## Hungry for more? 

With more firmly structured data we get more interesting
programs. Here comes a new type of data, `L`. We're going to get more
sophisticated here. Whenever I use `x` or `y` in the description of
`L`, that's supposed to be a symbol. When I use the word `lambda` I
mean it to be precisely that symbol---I'm using it as a
constant. Whenever I use `L`, `L1`, `L2`, these are recursive
positions. 

`L consists of x OR (lambda (x) L) OR (L1 L2)`

So these are in L:

  - `(a b)`
  - `z`
  - `(lambda (a) (lambda (z) a))`
  - `((f h) (g h))`
  - `(t (lambda (h) v))`
  - `(lambda (lambda) lambda)`

By contrast, these are not in L:

  - `(lambda (z))`
  - `(a b c)`
  - `(t)`
  - `(5 z)`
  - `(lambda () (a b))`
  
  
We want to write a function `lambda->gamma` that will take any L
expression, and replace all uses of `lambda` in that constant position
with `gamma`.

```
> (lambda->gamma '(lambda (a) (lambda (b) a)))
'(gamma (a) (gamma (b) a))
> (lambda->gamma '(b t))
'(b t)
> (lambda->gamma '((lambda (a) (a a)) (lambda (b) (b b))))
'((gamma (a) (a a)) (gamma (b) (b b)))
> (lambda->gamma '(lambda (lambda) lambda))
'(gamma (lambda) lambda)
> (lambda->gamma '(lambda lambda))
'(lambda  lambda)
```



### Just Dessert. 

This is not for the feint of heart or the uninitiated. If this stuff
is generally new to you, stop here. This is one of those grimoires
that are locked up in the Hogwarts library. But. Here we go.

You can nest quasiquoted expressions, of course. And you can mix them
in with quotes in between.

```
> (quasiquote (unquote . unquote))
'(unquote . unquote)

> (quasiquote             (unquote (quote (unquote (+ 2 3)))))
',(+ 2 3)

> (quasiquote      (quote (unquote (quote (unquote (+ 2 3))))))
'',(+ 2 3)

> (quasiquote (quasiquote (unquote (quote (unquote (+ 2 3))))))
'`,'5
```

Explain the behavior of the first of these, and explain the behavior
of the fourth in light of the second and the third.
