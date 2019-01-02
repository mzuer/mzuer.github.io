---
layout: post
title: "R - put only some words of the titles in italic with <em>substitute()</em>"
date: 2018-01-02
category: R
tags: [R, plot, function]
---


```
subTit <- "Cell lines vs. random data"
subTit <- substitute(x ~ italic("(MoC)"), list(x=subTit))

# => will result in: Cell lines vs. random data (MoC) with only "(MoC)" in  italic
```
