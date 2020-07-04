---
layout: post
title: "R - draw balloon plots with <em>ggballoonplot()</em> from <em>ggpubr</em>"
date: 2020-05-30
category: R
tags: R function ggplot2 visualization plot package
---

http://www.sthda.com/english/articles/32-r-graphics-essentials/129-visualizing-multivariate-categorical-data/#balloon-plot

Balloon plot is an alternative to bar plot for visualizing a large categorical data. We’ll use the function ggballoonplot() [in ggpubr], which draws a graphical matrix of a contingency table, where each cell contains a dot whose size reflects the relative magnitude of the corresponding component. 


```
ggballoonplot(housetasks, fill = "value")+
  scale_fill_viridis_c(option = "C")
```
