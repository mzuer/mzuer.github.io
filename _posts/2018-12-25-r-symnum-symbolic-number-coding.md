---
layout: post
title: "R - symbolic number coding with <em>symnum</em>"
date: 2018-12-25
category: R
tags: R function string
---

Symbolic number coding with <em>symnum</em>.

Symbolically encode a given numeric or logical vector or array. 

Particularly useful for visualization of structured matrices, e.g., correlation, sparse, or logical ones.



```
ii
# 0 1 2 3 4 5 6 7 8 
# 0 1 2 3 4 5 6 7 8 
symnum(ii, cut =  2*(0:4), sym = c(".", "-", "+", "$"))
# 0 1 2 3 4 5 6 7 8 
# . . . - - + + $ $ 
# attr(,"legend")
# [1] 0 ‘.’ 2 ‘-’ 4 ‘+’ 6 ‘$’ 8

## Pascal's Triangle modulo 2 -- odd and even numbers:
N <- 38
pascal <- t(sapply(0:N, function(n) round(choose(n, 0:N - (N-n)%/%2))))
rownames(pascal) <- rep("", 1+N) # <-- to improve "graphic"
symnum(pascal %% 2, symbols = c(" ", "A"), numeric = FALSE)
```

