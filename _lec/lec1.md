---
title: About the course
layout: single
liquid: enabled
date: 2021-12-29
---

# Headlines

  - Orientation
  - Course Website
  - Piazza 
  - Project
  - Plan

## About Your Instructor: 

   - Jason Hemann
   - Doctorate in Computer Science, Indiana University
   - Concentration in Logic
   - Philosophy undergraduate
   - Dance and run and talk software and how it helps people

## What is this class about, and why? 

   - Declarative programming
   - Logical programming
   - Implementations and applications
   - "Low floor, high ceiling"
   
### My hopes 

   - Show you some amazing stuff.
   - Give you opportunities to do some pretty awesome stuff
   - Leave no man behind. 
   
## Goals in a nutshell

   - Learn about and use this style of programming from the ground up. 
   - Fun, low stakes
   - Exploratory

# All the Racket you need to know


## Download and (re-)install DrRacket

Go to `https://download.racket-lang.org/`, and you can download and
install Racket and the DrRacket IDE for your platform. If you have
used DrRacket in a previous course, you should upgrade to the latest
version.

We will go ahead and install a handful of additional plugins. There
are for right now a couple of different tweaks and toggles we can hit.

Via the package manager (on OSX `File>Package manager`) , install
`faster-minikanren`.

We will use these at the appropriate time. 


## I'll do several examples.

## We will go over them together and then take a break with each other. 

#### `y-after-x` 

```
;; y-after-x takes a list and returns a list
;; Add a y after every x in a list

;; (y-after-x '())
;; '()
;; (y-after-x '(x))
;; '(x y)
;; (y-after-x '(x x))
;; '(x y x y)
;; (y-after-x '(a b y c y))
;; '(a b y c y)

#|
(y-after-x '(y b x)) => '(y b x y)
(y-after-x   '(b x)) =>   '(b x y)
|#

;; L = () OR cons x L OR cons non-x L

(define (y-after-x ls)
  (cond ;; "conditional" i.e. "if-then-else"
    ((empty? ls) '())
    ((equal? (car ls) 'x)
     (cons 'x (cons 'y (y-after-x (cdr ls)))))
    ((not (equal? (car ls) 'x))
     (cons (car ls)
           (y-after-x (cdr ls))))))
```

#### `zip` 

(EDIT: We did not get to. Maybe try it on your own and then look at
our solution)

````
;; zip : takes a List and List and returns a List
;; Returns a list of pairs of the constituent elements of the first and second list. 
;; If the lists are of different lengths, drop the remainder of the longer list.
;; > (zip '(a b c) '(e f g))
;; '((a . e) (b . f) (c . g))
;; > (zip '(a) '(e f g))
;; '((a . e))
;; > (zip '(a bx c) '(e f))
;; '((a . e) (bx . f))
;; > (zip '(a b) '())
;; '()

(define (zip ls1 ls2)
  (cond 
    ((or (empty? ls1) (empty ls2)) '())
	(else (cons (cons (car ls1) (car ls2)) (zip (cdr ls1) (cdr ls2))))))

````




## You'll do several examples.


#### `cons-every`

```
;; cons-every symbol and a list
;; conses that symbol onto every element of the list

;; > (cons-every 'x '(a b c d))
;; '((x . a) (x . b) (x . c) (x . d))
;; > (cons-every 'y '())
;; '()
;; > (cons-every 'a '(d e f))
;; '((a . d) (a . e) (a . f))

(define (cons-every x ls)
  (cond
    ((empty? ls) '())
    (else (cons (cons x (car ls)) (cons-every x (cdr ls))))))
```

`zip` 

`map`

### `append`

```
> (append '(a b c) '(d))
'(a b c d)
> (append '() '(d))
'(d)
> (append '(a b c) '(d . e))
'(a b c d . e)
> (append '(a b c . d) '(e))
#error
```

### `reverse` 

```
> (reverse '(a b c))
'(c b a)
> (reverse '())
'()
> (reverse '(a)
'(a)
> (reverse '(a b c . d))
#error
```

### `foldr`

```
> (foldr cons '() '(a b c d))
'(a b c d)
> (foldr + 0 '(1 2 3 4 5))
15
```

### Stretch example/problem. 

#### Cartesian product

Read over this summary of Barron and Strachey's Cartesian product
function (note: they wrote this code in ~1966!)

http://ojs.statsbiblioteket.dk/index.php/brics/article/download/21934/19359


### After break


#### Quasiquotes and commas and patterns and pattern matching


#### `match`

#### The same programs, but differently. 


