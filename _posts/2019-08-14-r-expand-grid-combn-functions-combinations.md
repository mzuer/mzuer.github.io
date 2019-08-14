---
layout: post
title: "R - <em>combn()</em> and <em>expand.grid()</em> to generate combinations"
date: 2019-08-14
category: R
tags: R function combinations
---


* Permutations with repetitions can be performed with <em>expand.grid()</em> (create a data frame from all combinations of the supplied vectors or factors)


* Permutations without repetitions can be performed with <em>combn()</em> (generate all combinations of the elements of x taken m at a time)


```
P_wi <- expand.grid(rep(list(0:9), 3))
```


```
C_wo <- combn(1:49, 6)
```


See also:

<a href="https://www.r-bloggers.com/learning-r-permutations-and-combinations-with-base-r">https://www.r-bloggers.com/learning-r-permutations-and-combinations-with-base-r</a>
