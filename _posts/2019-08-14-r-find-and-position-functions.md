---
layout: post
title: "R - <em>Find()</em> and <em>Position()</em> give the first or last element and its position in the vector that gives true for the logical function"
date: 2019-08-14
category: R
tags: R function vector
---

<em>Find()</em> returns the actual value (1st element only; use <em>right=TRUE</em> to retrieve the last)

<em>Position()</em> returns its index



```
mylist3 <- c(runif(5))
mylist3
# [1] 0.8825526 0.8386051 0.8569615 0.5358881 0.2192216

Find(function(x) x>0.6, mylist3)
# [1] 0.8825526
Find(function(x) x>0.6, mylist3, right=TRUE)
# [1] 0.8569615


Position(function(x) x>0.6, mylist3)
# [1] 1
Position(function(x) x>0.6, mylist3, right=TRUE)
# [1] 3
```
