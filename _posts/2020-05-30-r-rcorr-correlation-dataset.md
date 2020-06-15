---
layout: post
title: "R - <em>rcorr()</em>: correlations for whole dataset"
date: 2020-05-30
category: R
tags: R function data_frame statistics
---

Correlation tests for whole dataset with <em>rcorr()</em> from <em>Hmisc</em> package


```
# correlation tests for whole dataset
library(Hmisc)
res <- rcorr(as.matrix(dat)) # rcorr() accepts matrices only

# display p-values (rounded to 3 decimals)
round(res$P, 3)

```


