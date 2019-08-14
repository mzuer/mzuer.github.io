---
layout: post
title: "R - <em>Reduce()</em>: combine values of vectors by applying a function"
date: 2019-08-14
category: R
tags: R function list
---

<em>Reduce()</em> uses a binary function to successively combine the elements of a given vector and a possibly given initial value. 


Example: <em>Reduce(f = "+", x)</em> is the same as <em>x[[[1]] + ... + x[[n]]</em>

```
mylist = list(c("a", "b", "c"), c("a", "z", "x"), c("y", "d", "a"))
Reduce(intersect, mylist)
# [1] "a"
```
