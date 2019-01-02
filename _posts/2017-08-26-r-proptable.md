---
layout: post
title: "R - <em>prop.table()</em>:  compute proportion table"
date: 2017-08-26
category: R
tags: [R, function, matrix]
---

equivalent to <code>sweep(x, margin, margin.table(x, margin), "/")</code> except that it returns <code> gets x/sum(x) </code> if margin has length zero

```
m <- matrix(1:4, 2)
prop.table(m, 1)
```


<small> viewed on http//www.rfunction.com </small>

