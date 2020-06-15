---
layout: post
title: "R - improved text rendering of ggplot2 plots with <em>mdthemes</em> package"
date: 2020-05-30
category: R
tags: R function visualization plots package ggplot2 text
---

See also <em>ggtext</em> package ! 

<em>mdthemes</em> adds support for rendering text as markdown to your favorite ggplot2 themes thanks to the awesome <em>ggtext</em> package.


Currently, mdthemes contains all themes from ggplot2, ggthemes, hrbrthemes, tvthemes and cowplot with support for rendering text as markdown. All themes start with md_ followed by the name of the original theme, e.g. md_theme_bw().



```
library(ggplot2)
library(mdthemes)
data(mtcars)

p <- ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  labs(
    title = "This is a **bold** title",
    subtitle = "And an *italics* subtitle",
    x = "**_hp_**",
    caption = "<span style = 'color:blue'>A blue caption</span>"
  )

p + theme_minimal()
p + md_theme_minimal()
```


