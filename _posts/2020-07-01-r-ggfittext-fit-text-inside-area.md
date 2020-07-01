---
layout: post
title: "R - <em>ggfittext</em> package: <em>ggplot2</em> fit text inside defined area"
date: 2020-07-01
category: R
tags: [R, visualization, plot, ggplot2, package]
---

https://cran.r-project.org/web/packages/ggfittext/vignettes/introduction-to-ggfittext.html


Sometimes you want to draw some text in a ggplot2 plot so that it fits inside a defined area. It’s possible to achieve this by manually fiddling with the font size, but this is both tedious and un-reproducible. ggfittext provides a geom called geom_fit_text() that automatically resizes text to fit inside a box. It works like this:
