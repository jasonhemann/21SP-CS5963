---
title: Class intro; Racket 101
date: 2020-12-29
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

(EDIT: We did not get to the next two. Maybe try them on your own and
	then look at our solutions)

```
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
    ((empty? ls1) '())
	((empty? ls2) '())
	(else (cons (cons (car ls1) (car ls2)) (zip (cdr ls1) (cdr ls2))))))
```

For this one, I really thought about it as though I was walking over
one piece of data: the two lists (at once) this is why I made my
sub-problem changing both lists at once. What's decreasing is their
total length. So I need two base cases, because both of the lists are
shrinking.

#### `map` 

This is another one to which we did not get. It is also more than we
will need to write miniKanren programs; it is the sort of thing we
might use when we write a miniKanren. `map` is a function that takes a
*function* as an argument. This is an example of what makes functional
programming really cool. If you want a more run-of-the-mill example,
consider this: in your calculus class ~integral~ was a mathematical
function that took another mathematical function as an argument, and
it produced yet *another* function as the value. Whoooa! ᕕ( ᐛ )ᕗ

```
;; map takes a one-argument function and a list and produces a list
;; map runs the function f on every element of the list in turn, and produces a list of the results.

;; > (map add1 '(2 3 4 5))
;; '(3 4 5 6)
;; > (map symbol? '(cat dog #f 2 3 4))
;; '(#t #t #f #f #f #f)
;; > (map y-after-x '(() (x) (x x) (a b y c y)))
;; '(() (x y) (x y x y) (a b y c y))

(define (map f ls)
  (cond
    ((empty? ls) '())
	(else (cons (f (car ls)) (map f (cdr ls))))))
```

## You'll do several examples.


#### `cons-every`

```
;; cons-every symbol and a list and produces a list
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

### `append`

```
> (append '(a b c) '(d))
'(a b c d)
> (append '() '(d))
'(d)
> (append '(a b c) '(d . e))
'(a b c d . e)
```

The following would be an error; you needn't concern yourself with
this case.

```
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
```

The following would be an error; you needn't concern yourself with
this case.

```
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

### Stretch example/problems

#### `powerset` 

```
;; powerset list to list 
;; given a set represented a list (a list with no duplicates), return
;; a list representing the powerset of the input: a list of list
;; representations of all subsets.

;; > (powerset '(3 2 1))
;; '((3 2 1) (3 2) (3 1) (3) (2 1) (2) (1) ())
;; > (powerset '())
;; '(())

;; Not order does not and should not matter here, so as long as you
;; get the correct elements, we'll be fine with any old order!
```

#### (generalized) Cartesian product 

Read over this summary of [Barron and Strachey's Cartesian product
function](http://ojs.statsbiblioteket.dk/index.php/brics/article/download/21934/19359)
(you might need to right-click "Save as") Note that they wrote this
code in ~1966!

#### You can also read about the amazing zoo of things you can do with the `foldr` function:

[`foldr` the magnificent](http://www.cs.nott.ac.uk/~pszgmh/fold.pdf)
