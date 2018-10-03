---
layout: post
title: "R - draw error bars in R base plot with <em>arrows</em>"
date: 2018-06-03
category: R
tags: [R plot]
---

Draw error bar in base plot

```
plot(x, y, xaxt='n', xlab='', ylim = c(0,1)) #, ylim = c(min.y, max.y))
axis(side = 1, at = 1:length(bb$names), bb$names, las=2)
arrows(x, y-sd, x, y+sd, code=3, angle = 90, length=0.05)
```
