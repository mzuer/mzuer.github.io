---
layout: post
title: "<em>margin.table</em>:  compute margin  of a matrix"
date: 2017-08-26
category: R
tags: [R, function, matrix]
---

For a contingency table in array form, compute the sum of table entries for a given index. 

Equivalent to <code>apply(x, margin, sum)</code> except that it returns <code>sum(x)</code> if margin has length zero

```
m <- matrix(1:4, 2)
margin.table(m, 1)
margin.table(m, 2)
```


<small> viewed on http://www.rfunction.com </small>
