---
layout: post
title: "R - algorithm and code for circular permutation of a vector"
date: 2018-10-03
category: R
tags: R algorithm
---

Code for algorithm to permute a vector circularly:

```
# permute vector circularly (for jacard tad coexpr)

shifter <- function(x, n = 1) {
  # if (n == 0) x else c(tail(x, -n), head(x, n))
  if (n == 0) x else c(tail(x, n), head(x, -n))
}

shifter(c(1:10), n=0)
# [1]  1  2  3  4  5  6  7  8  9 10
shifter(c(1:10), n=1)
# [1] 10  1  2  3  4  5  6  7  8  9
shifter(c(1:10), n=2)
# [1]  9 10  1  2  3  4  5  6  7  8
```



