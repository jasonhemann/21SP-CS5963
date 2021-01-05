---
title: miniKanren, finally
date: 2021-1-5
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



## Tricky bits

miniKanren *relations* cannot be called within `==`. You cannot nest
calls to `==` or to any other constraints.

These can be only *sequenced* or *alternates*

## More detailed guides

# Project
(== to '
I) don't want anyone getting scared or worried about this. I also don't
want anyone feeling like "... *gulp*!!". So I want to get this out of
the way now.

## Implement a short language-as-a-library

<https://github.com/jasonhemann/microKanren/blob/master/microKanren.scm> 

## Implement *and understand* a short language-as-a-library

<https://github.com/jasonhemann/microKanren/blob/master/microKanren.scm> 

We can simplify away a bunch of this, too. Have to think about it.

## Implement and understand the more sophisticated version 

<https://github.com/jasonhemann/microKanren-DLS-16/blob/master/mk.rkt>

This has slightly more, fancier Racket than most of you are aware

## Implement a version in the language of your own choice 

*Transferrence*! Plus it might feel more familiar to you on your home turf.


## Additions! 

You might want to try adding auxiliary constraints or nicer surface
syntax, etc.

## Uses!! 

You might instead want to try using this for something cool. I have
several examples and many more ideas. 


# Go find a partner (if you wish!)


