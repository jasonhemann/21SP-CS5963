---
title: more miniKanren
date: 2021-01-07
---

## Practicing implementing miniKanren programming

### `reverseo`


### `stuttero`


## miniKanren numbers




## Tricky bits

miniKanren *relations* cannot be called within `==`. You cannot nest
calls to `==` or to any other constraints.

These can be only *sequenced* or *alternates*

## More detailed guides

# Project
I don't want anyone getting scared or worried about this. I also don't
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


