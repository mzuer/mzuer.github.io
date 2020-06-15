---
layout: post
title: "R - draw and save plots from <em>plotly</em>"
date: 2020-05-30
category: R
tags: R package visualization plots
---

```
library(plotly)
x <- rnorm(200)
y <- rnorm(200)
s <- subplot(
  plot_ly(x = x, type = "histogram"),
  plotly_empty(),
  plot_ly(x = x, y = y, type = "histogram2dcontour"),
  plot_ly(y = y, type = "histogram"),
  nrows = 2, heights = c(0.2, 0.8), widths = c(0.8, 0.2), margin = 0,
  shareX = TRUE, shareY = TRUE, titleX = FALSE, titleY = FALSE
)
p <- layout(s, showlegend = FALSE)

p
# plotly_IMAGE(p, format = "png", out_file = "output.png")
htmlwidgets::saveWidget(p, "index.html")
orca(p, file='image.png')

```
