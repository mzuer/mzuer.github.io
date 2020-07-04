---
layout: post
title: "R - draw sinaplots with <em>geom_sina()</em> from <em>ggforce</em> package"
date: 2020-05-30
category: R
tags: R ggplot2 package plot visualization function
---

<em>geom_sina()</em> from <em>ggforce</em> package:

sinaplot is inspired by the strip chart and the violin plot. By letting the normalized density of points restrict the jitter along the x-axis, the plot displays the same contour as a violin plot, but resemble a simple strip chart for small number of data points (Sidiropoulos et al. 2015).

```
library(ggforce)
# Create some data
d1 <- data.frame(
  y = c(rnorm(200, 4, 1), rnorm(200, 5, 2), rnorm(400, 6, 1.5)),
  group = rep(c("Grp1", "Grp2", "Grp3"), c(200, 200, 400))
  )
# Sinaplot
ggplot(d1, aes(group, y)) +
  geom_sina(aes(color = group), size = 0.7)+
  scale_color_manual(values =  c("#00AFBB", "#E7B800", "#FC4E07"))```
```
