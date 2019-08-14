---
layout: post
title: "R - <em>Filter()</em> extract elements matching a logical function"
date: 2019-08-14
category: R
tags: R function vector
---

<em>Filter()</em> extracts the elements of a vector for which a predicate (logical) function gives TRUE


```
mylist3 <- c(runif(5))
mylist3
# [1] 0.8825526 0.8386051 0.8569615 0.5358881 0.2192216

Filter(function(x) x > 0.6, mylist3)
# [1] 0.8825526 0.8386051 0.8569615
```
