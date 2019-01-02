---
layout: post
title: "R - convert matrix wide to long format with <em>as.table()</em> or <em>melt()</em>"
date: 2018-06-03
category: R
tags: R function matrix data_frame
---

Two ways to convert a matrix from wide to long format:


```
# Way 1: convert matrix (wide format) into long format (Var1 Var2 Freq)
as.data.frame(as.table(matrix))

# Way 2: using reshape2::melt
library(reshape2)
colnames(mymatrix) <- rownames(mymatrix) <- 1:ncol(mymatrix)
mymatrixLong <- melt(mymatrix)
```
