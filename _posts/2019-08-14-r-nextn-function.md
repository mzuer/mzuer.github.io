---
layout: post
title: "R - <em>nextn()</em>: highly composite numbers"
date: 2019-08-14
category: R
tags: R function 
---


<em>nextn(n, factors)</em> returns the smallest integer, greater than or equal to <em>n</em>, which can be obtained as a product of powers of the values contained in <em>factors</em>.


NB: Discrete Fourier Transforms (DFT) algorithms are most efficient for "Highly Composite Numbers", specifically multiples of (2,3,5)

```
nextn(1001) # default: nextn(1001, factors=c(2,3,5))
#[1] 1024
```
