---
layout: post
title: "R - run length encoding with <em>rle()</em>"
date: 2021-02-10
category: R
tags: R function base
---


<em>rle()</em> from <em>base</em>

Run Length Encoding: 

Compute the lengths and values of runs of equal values in a vector – or the reverse operation.

```

x <- c(1,1,3,4,4,4,5,5,6)

rle(x)
# Run Length Encoding
#   lengths: int [1:5] 2 1 3 2 1
#   values : num [1:5] 1 3 4 5 6

rle(x)$lengths
# [1] 2 1 3 2 1
rle(x)$values
# [1] 1 3 4 5 6

```

