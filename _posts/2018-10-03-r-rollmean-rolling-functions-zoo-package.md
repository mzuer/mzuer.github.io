---
layout: post
title: "R - <em>rollmean()</em> and other rolling functions from <em>zoo</em> package"
date: 2018-10-03
category: R
tags: R package function
---


Useful functions for computing rolling means, maximums, medians, and sums of ordered observations.

Compute means/medians/... for values in a given window (moving averages/medians/...)

```
library(zoo)

rollmean(y,3)
#[1] 1.000000 1.333333 1.666667 2.000000
```
