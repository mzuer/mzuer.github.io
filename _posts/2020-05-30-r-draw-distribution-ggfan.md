---
layout: post
title: "R - distribution plots with <em>geo_fan()</em> from <em>ggfan</em> package"
date: 2020-05-30
category: R
tags: R function visualization plots package ggplot2
---

the <em>fanplot</em> package provides methods to visualise probability distributions by representing intervals of the distribution function with colours.

https://cran.r-project.org/web/packages/ggfan/vignettes/geom_fan.html

```
ggplot(fake_df, aes(x=x,y=y)) +
 geom_fan()
```
