---
layout: post
title: "R - matrix visualization with <em>paintmap()</em> function and package"
date: 2019-12-09
category: R
tags: R plot matrix heatmap
---



```
sim_matrix <- matrix(runif(n=25, min=0, max=1), ncol=5)
colnames(sim_matrix) <- rownames(sim_matrix) <- paste0("data", 1:5)
library(paintmap)
paintmap(colour_matrix(sim_matrix))
```

