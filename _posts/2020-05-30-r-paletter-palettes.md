---
layout: post
title: "R - <em>paletteer</em>: package for color palettes"
date: 2020-05-30
category: R
tags: R ggplot2 colors palettes plot package visualization
---

<em>paletteer</em>: nice package for creating color palettes in R


https://paulvanderlaken.com/2020/03/17/paletteer-hundreds-of-color-palettes-in-r/


```
install.packages("paletteer")
library(paletteer)

install.packages("ggplot2")
library(ggplot2)

ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point() +
  scale_color_paletteer_d("nord::aurora")
```


