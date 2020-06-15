---
layout: post
title: "R - draw hybrid ggplot2 plots with <em>gghalves</em>"
date: 2020-05-30
category: R
tags: R visualization plots package ggplot2 function
---

https://cran.r-project.org/web/packages/gghalves/vignettes/gghalves.html

The idea is that many geoms that aggregate data, such as geom_boxplot, geom_violin and geom_dotplot are (near) symmetric. Given that the space to display information is limited, we can make better use of it by cutting the geoms in half and displaying additional geoms that e.g. give information about the sample size.

```
ggplot() +
  
  geom_half_boxplot(
    data = iris %>% filter(Species=="setosa"), 
    aes(x = Species, y = Sepal.Length, fill = Species), outlier.color = NA) +
  
  ggbeeswarm::geom_beeswarm(
    data = iris %>% filter(Species=="setosa"),
    aes(x = Species, y = Sepal.Length, fill = Species, color = Species), beeswarmArgs=list(side=+1)
  ) +
  
  geom_half_violin(
    data = iris %>% filter(Species=="versicolor"), 
    aes(x = Species, y = Sepal.Length, fill = Species), side="r") +
  
  geom_half_dotplot(
    data = iris %>% filter(Species=="versicolor"), 
    aes(x = Species, y = Sepal.Length, fill = Species), method="histodot", stackdir="down") +
  
  geom_half_boxplot(
    data = iris %>% filter(Species=="virginica"), 
    aes(x = Species, y = Sepal.Length, fill = Species), side = "r", errorbar.draw = TRUE,
    outlier.color = NA) +
  
  geom_half_point(
    data = iris %>% filter(Species=="virginica"), 
    aes(x = Species, y = Sepal.Length, fill = Species, color = Species), side = "l") +
  
  scale_fill_manual(values = c("setosa" = "#cba1d2", "versicolor"="#7067CF","virginica"="#B7C0EE")) +
  scale_color_manual(values = c("setosa" = "#cba1d2", "versicolor"="#7067CF","virginica"="#B7C0EE")) +
  theme(legend.position = "none")
```
