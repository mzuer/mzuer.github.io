---
layout: post
title: "R - 3 functions to plot scatterplot matrices"
date: 2018-12-25
category: R
tags: R plot ggplot2 lattice visualization
---

Different functions to plot scatterplot matrices (pair plots):


```
# Base
pairs(iris[1:4], 
      main = "Anderson's Iris Data -- 3 species",
      pch = 21, 
      bg = c("#1b9e77", "#d95f02", "#7570b3")[unclass(iris$Species)])


# ggplot2
library(ggplot2)
library(GGally)
ggpairs(iris, columns=1:4, aes(color=Species)) + 
  ggtitle("Anderson's Iris Data -- 3 species")


# lattice
library(lattice)
splom(iris[1:4], 
      groups=iris$Species, 
      main="Anderson's Iris Data -- 3 species")

```
