---
layout: post
title: "R - set vector length with <em>length()</em>"
date: 2021-02-10
category: R
tags: R function base
---


<em>rle()</em> from <em>base</em>

Run Length Encoding: 

Compute the lengths and values of runs of equal values in a vector – or the reverse operation.

```
xx <- c(1,2,3,4)
xx
# [1] 1 2 3 4

length(xx) <- 5
xx
# [1]  1  2  3  4 NA

length(xx) <- 2
xx
# [1] 1 2
```

