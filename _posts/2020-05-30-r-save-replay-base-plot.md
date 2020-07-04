---
layout: post
title: "R - save and replay base plots with <em>recordPlot()</em> and <em>replayPlot()</em>"
date: 2020-05-30
category: R
tags: R plot visualization function
---

To avoid repeating codes, you can save a plot and replay it later:


```
dev.control(displaylist="enable")
[...]
signifPlot <- recordPlot()
replayPlot(signifPlot) 
```
