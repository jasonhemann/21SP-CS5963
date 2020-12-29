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

`y-after-x` 

`zip` 

`map`

`cons-every`

## You'll do several examples.

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


