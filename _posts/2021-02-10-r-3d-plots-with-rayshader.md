---
layout: post
title: "R - 3D plots with <em>rayshader</em> package"
date: 2021-02-10
category: R
tags: R plot ggplot2 function package
---

<a href="https://www.business-science.io/code-tools/2021/01/12/3d-plots.html">https://www.business-science.io/code-tools/2021/01/12/3d-plots.html</a>


```
library(rayshader)
library(tidyverse)

# 3D DATA PLOT ----

# ggplot (2D visualization) - DS4B 101-R, Week 4
g1 <- mtcars %>%
  ggplot(aes(disp, mpg, color = cyl)) +
  geom_point(size=2) +
  scale_color_continuous(limits=c(0,8)) +
  ggtitle("mtcars: Displacement vs mpg vs # of cylinders") +
  theme(title = element_text(size=8),
        text = element_text(size=12))

# rayshader
g1 %>%
  plot_gg(
    height        = 3,
    width         = 3.5,
    multicore     = TRUE,
    pointcontract = 0.7,
    soliddepth    = -200
  )

render_camera(zoom = 0.75, theta = -30, phi = 30)
render_snapshot(clear = FALSE)
```
