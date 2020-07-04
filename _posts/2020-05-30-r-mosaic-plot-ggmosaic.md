---
layout: post
title: "R - draw mosaic plots with <em>geom_mosaic()</em> from <em>ggmosaic</em> package"
date: 2020-05-30
category: R
tags: R function visualization plot package ggplot2
---

http://www.sthda.com/english/articles/32-r-graphics-essentials/129-visualizing-multivariate-categorical-data/#mosaic-plot

A mosaic plot is basically an area-proportional visualization of observed frequencies, composed of tiles (corresponding to the cells) created by recursive vertical and horizontal splits of a rectangle. The area of each tile is proportional to the corresponding cell entry, given the dimensions of previous splits. 

https://cran.r-project.org/web/packages/ggmosaic/vignettes/ggmosaic.html

```
 ggplot(data = fly) +
   geom_mosaic(aes(x = product(RudeToRecline), fill=RudeToRecline), na.rm=TRUE) +
   labs(x="Is it rude recline? ", title='f(RudeToRecline)') 
```
