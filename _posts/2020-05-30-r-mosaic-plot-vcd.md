---
layout: post
title: "R - draw mosaic plots with <em>mosaic()</em> from <em>vcd</em> package"
date: 2020-05-30
category: R
tags: R function visualization plots package
---

http://www.sthda.com/english/articles/32-r-graphics-essentials/129-visualizing-multivariate-categorical-data/#mosaic-plot

A mosaic plot is basically an area-proportional visualization of observed frequencies, composed of tiles (corresponding to the cells) created by recursive vertical and horizontal splits of a rectangle. The area of each tile is proportional to the corresponding cell entry, given the dimensions of previous splits. 

Read more about <em>vcd</em> package and Visualizing Multi-way Contingency Tables: 

https://cran.r-project.org/web/packages/vcd/vignettes/strucplot.pdf

```
library(vcd)
mosaic(HairEyeColor, shade = TRUE, legend = TRUE) 
```
