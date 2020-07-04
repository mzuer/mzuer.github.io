---
layout: post
title: "R - draw rotated <em>image()</em>"
date: 2017-11-25
category: R
tags: [R, plot]
---

Rotate the initial matrix => (0;0) on start top left, instead of bottom right 

```
mat1 <- t(shuffMatrix)[,nrow(shuffMatrix):1]
```

Then plot the rotated matrix with <em>image</em>

```
image(log10(mat1), main=paste0("My title"), col=colorRampPalette(c('red','white','blue'))(12))
```
