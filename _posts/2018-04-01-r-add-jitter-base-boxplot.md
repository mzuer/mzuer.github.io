---
layout: post
title: "R - add points with <em>jitter</em> in R base <em>plot</em>"
date: 2018-06-03
category: R
tags: [R plot function]
---

Add points with <em>jitter</em> on R base <em>plot</em>

```
bb <- boxplot(all.data$MoC ~ all.data$group, las=2, outline=FALSE, ylim=c(0,1)) # !!! do not forget outline=FALSE, otherwise outliers plot twice !!!
points(jitter(all.data$rank,factor=0.5),all.data$MoC,pch=20)
```

