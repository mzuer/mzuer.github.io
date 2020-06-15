---
layout: post
title: "R - draw distribution plots with <em>geom_density_ridges()</em> from <em>ggridges</em>"
date: 2020-05-30
category: R
tags: R visualization plots package ggplot2
---

https://cran.r-project.org/web/packages/ggridges/vignettes/gallery.html

http://www.sthda.com/english/articles/32-r-graphics-essentials/133-plot-one-variable-frequency-graph-density-distribution-and-more/#density-ridgeline-plots

```
library(ggplot2)
library(ggridges)
theme_set(theme_ridges())

#    Example 1: Simple distribution plots by groups. Distribution of Sepal.Length by Species using the iris data set. The grouping variable Species will be mapped to the y-axis:

ggplot(iris, aes(x = Sepal.Length, y = Species)) +
  geom_density_ridges(aes(fill = Species)) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))
```
