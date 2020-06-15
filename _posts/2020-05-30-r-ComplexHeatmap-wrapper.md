---
layout: post
title: "R - <em>tidyHeatmap</em>: tidy wrapper package for <em>ComplexHeatmap</em>"
date: 2020-05-30
category: R
tags: R visualization plots package
---

Tidy wrapper of the package <em>ComplexHeatmap</em>. The goal of this package is to interface tidy data frames with this powerful tool.

Some of the advantages are:

* Row and/or columns colour annotations are easy to integrate just specifying one parameter (column names).
* Custom grouping of rows is easy to specify providing a grouped tbl. For example df %>% group_by(...)
* Labels size adjusted by row and column total number
* Default use of Brewer and Viridis palettes

