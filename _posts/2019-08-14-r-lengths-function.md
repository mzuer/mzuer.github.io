---
layout: post
title: "R - <em>lengths()</em>: get length of element of a list efficiently"
date: 2019-08-14
category: R
tags: R function list
---


Get the length of each element of a list or atomic vector (<em>is.atomic</em>) as an integer or numeric vector.


More efficient version of <em>sapply(x, length)</em> and similar <em>*apply</em> calls to length. 



```
xx <- list(rep(1,5), rep(4,8),rep(2,10))

lengths(xx)
# [1]  5  8 10
```
