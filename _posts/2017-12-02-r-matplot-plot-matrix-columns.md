---
layout: post
title: "R - <em>matplot</em>: plot column of matrices"
date: 2017-12-02
category: R
tags: [R, function, matrix, plot]
---

Use <em>matplot</em> to plot the columns of one matrix against the columns of another (generate a new plot).

Use <em>matlines</em> or <em>matpoints</em> to add lines and points to the current plot.

```
Usage:

     matplot(x, y, type = "p", lty = 1:5, lwd = 1, lend = par("lend"),
             pch = NULL,
             col = 1:6, cex = NULL, bg = NA,
             xlab = NULL, ylab = NULL, xlim = NULL, ylim = NULL,
             ..., add = FALSE, verbose = getOption("verbose"))
     
     matpoints(x, y, type = "p", lty = 1:5, lwd = 1, pch = NULL,
               col = 1:6, ...)
     
     matlines (x, y, type = "l", lty = 1:5, lwd = 1, pch = NULL,
               col = 1:6, ...)

```
