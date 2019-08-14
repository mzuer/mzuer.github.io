---
layout: post
title: "R - <em>choose()</em>: number of combinations"
date: 2019-08-14
category: R
tags: R function combinations
---

Use <em>choose()</em> to calculate the number of combinations (binomial coefficients)


```
choose(3,2)
#[1] 3

choose(3,1)
#[1] 3

choose(3,3)
#[1] 1
```


For k ≥ 1 it is defined as n(n-1)…(n-k+1) / k!, as 1 for k = 0 and as 0 for negative k.


See also:

<a href="https://www.r-bloggers.com/learning-r-permutations-and-combinations-with-base-r">https://www.r-bloggers.com/learning-r-permutations-and-combinations-with-base-r</a>
