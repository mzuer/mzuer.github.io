---
layout: post
title: "R - <em>rle()</em>: vector run length encoding"
date: 2017-08-26
category: R
tags: [R, function, vector]
---

Compute the lengths and values of runs of equal values in a vector – or the reverse operation.


```
x <- c(1,1,2,3,4,4,5)
rle(x)
# Run Length Encoding
#   lengths: int [1:5] 2 1 1 2 1
#   values : num [1:5] 1 2 3 4 5

inverse.rle(rle(x))
# [1] 1 1 2 3 4 4 5
```

