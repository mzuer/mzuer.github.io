---
layout: post
title: "R - use of <em>foreach()</em> for list comprehension"
date: 2018-01-21
category: R
tags: [R, function, parallelization, loop]
---

Use <em>foreach</em> and <em>%:%</em> similar to python list comprehension

```
x <- foreach(a=irnorm(1, count=10), .combine='c') %:% when(a >= 0) %do% sqrt(a)
```


