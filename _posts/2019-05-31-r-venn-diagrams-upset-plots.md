---
layout: post
title: "R - Venn diagrams <em>vs.</em> UpSet plots"
date: 2019-05-31
category: R
tags: R package plots
---


https://www.r-bloggers.com/set-analysis-a-face-off-between-venn-diagrams-and-upset-plots



https://bioinfo-fr.net/contrarie-par-les-diagrammes-de-venn-decouvrez-les-diagrammes-upset


```
library(rJava)
library(UpSetR)
library(tidyverse)
library(venneuler)
library(grid)

# Create the Venn diagram
# note on set up for java v11 jdk (v12 does not work with this)
myExpVenn <- venneuler(expressionInput)
par(cex=1.2)
plot(myExpVenn, main = "Why I Love Twitter")
grid.text(
  "@littlemissdata",
  x = 0.52,
  y = 0.2,
  gp = gpar(
    fontsize = 10,
    fontface = 3
  )
)
# Create an UpsetR Plot
upset(fromExpression(expressionInput), order.by = "freq")
grid.text(
  "Why I Love Twitter  @littlemissdata",
  x = 0.80,
  y = 0.05,
  gp = gpar(
    fontsize = 10,
    fontface = 3
  )
)
```
