---
title: miniKanren, finally
date: 2021-01-05
---

# Warm-up `append` w/`quasiquote`s and `unquote`s + `let`

```
(define (append ls1 ls2)
  (match ls1
    [`() ls2]
	[`(,a . ,d) `(,a . ,(append d ls2))]))
```

## `let`

```
(define (append ls1 ls2)
  (match ls1
    [`() ls2]
	[`(,a . ,d) 
	 (let ((res (append d ls2)))
	   `(,a . ,res))]))
```

# miniKanren, Finally

## What is miniKanren

miniKanren is a *domain-specific* language for programming
*relationally*, with *structural constraints*. miniKanren is
*shallowly embedded* in more than 50 *host languages*

  1. ~domain specific~ -- intended for a particular narrow purpose (cf "GPPL")
  1. ~relationally~ -- programs describe and query relationships between data. Think the generalization of functions from 6th grade algebra. 
  1. ~structural constraints~ -- our constraints describe the "shape" of our data, or their composition from basic sorts (e.g. ~number~, ~symbol~)
  1. ~shallowly embedded~ -- meaning it sits inside another programming language, and looks much like a (e.g. Racket, Python, C#) library.
  1. ~host language~ -- the language in which it's written. If you are familiar with one of its host languages, you will likely understand its implementation.

## Diving in

```
#lang racket 
(require minikanren)
```

``` 
(run <max number of answers> (<one or more variables>) <query> )
```

```
(run 1 (q) (== q 'fish))
``` 

```
(run 1 (q w) (== q 'fish) (== w 'horse))
```

```
(run 1 (q w) (== q 'fish) (== w 'horse) (== w q))
```

```
(run 1 (q) (fresh (x) (== x 'tse) (== q (list x x 'fly))))
```

```
(run 1 (q) 
  (fresh (rival) 	
	(conde 
	  ((== q 'bulbasaur) (== rival 'charizard)) 
	  ((== q 'charizard) (== rival 'squirtle))
	  ((== q 'squirtle)  (== rival 'bulbasaur)))))
```

## Bigger Example

```
(define (direct-flight from to)
  (conde
    ((== from 'boston) (== to 'seattle))
	((== from 'portland) (== to 'las-vegas))
	((== from 'dallas) (== to 'omaha))
	((== from 'atlanta) (== to 'miami))
	((== from 'philadelphia) (== to 'atlanta))
	((== from 'new-york) (== to 'philadelphia))
	((== from 'boston) (== to 'philadelphia))
	((== from 'atlanta) (== to 'savannah))
	((== from 'las-vegas) (== to 'chicago))
	((== from 'chicago) (== to 'philadelphia))))
```

## The `appendo` example.


### From `append` to `appendo`


### The uses of `appendo`
