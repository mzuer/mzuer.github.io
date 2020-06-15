---
layout: post
title: "R - usage of <em>cut()</em>, <em>hist()</em> and <em>findInterval()</em>"
date: 2020-05-30
category: R
tags: R function
---



Instead of <em>table(cut(x, br))</em>, <em>hist(x, br, plot = FALSE)</em> is more efficient and less memory hungry. 

Instead of <em>cut(*, labels = FALSE)</em>, <em>findInterval()</em> is more efficient.


<em>findInterval(x, vec)</em>: given a vector of non-decreasing breakpoints in vec, find the interval containing each element of x;


```
x <- 2:18
v <- c(5, 10, 15) # create two bins [5,10) and [10,15)
cbind(x,findInterval(x,v))
#       x  
# [1,]  2 0
# [2,]  3 0
# [3,]  4 0
# [4,]  5 1
# [5,]  6 1
# [6,]  7 1
# [7,]  8 1
# [8,]  9 1
# [9,] 10 2
#[10,] 11 2
#[11,] 12 2
#[12,] 13 2
#[13,] 14 2
#[14,] 15 3
#[15,] 16 3
#[16,] 17 3
#[17,] 18 3
```
