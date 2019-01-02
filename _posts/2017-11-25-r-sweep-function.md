---
layout: post
title: "R - <em>sweep()</em> function"
date: 2017-11-25
category: R
tags: [R, function]
---

<em>sweep()</em>: return an array obtained from an input array by sweeping out a summary statistic

=> convenient to apply different values to data in different columns/rows
(e.g. to subtract "3", "4", "5" from each value in the first, 2nd and 3rd column)

```
data <- matrix(seq(1,12),ncol=4,nrow=3,byrow=TRUE)
#      [,1] [,2] [,3] [,4]
# [1,]    1    2    3    4
# [2,]    5    6    7    8
# [3,]    9   10   11   12

sweep(data,2,c(3,4,5,6), "-")
#      [,1] [,2] [,3] [,4]
# [1,]   -2   -2   -2   -2
# [2,]    2    2    2    2
# [3,]    6    6    6    6

```

Useful e.g. for data standardization:


Calculate median expression for each gene,
then subtract the value and divide the results by median absolute deviation. 


=> <em>sweep()</em> can be used since median expression (which differs for each gene) is substracted.


```
standardize <- function(z) {
  rowmed <- apply(z, 1, median)
  rowmad <- apply(z, 1, mad)        # median absolute deviation
  rv <- sweep(z, 1, rowmed,"-")     #subtracting median expression
  rv <- sweep(rv, 1, rowmad, "/")   # dividing by median absolute deviation
  return(rv)
}
```



https://bioinfomagician.wordpress.com/2014/08/12/my-favorite-commands-part3-sweep-function-in-r/

