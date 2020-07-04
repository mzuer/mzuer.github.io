---
layout: post
title: "R - plot distributions with <em>plot_distr()</em> from <em>fplot</em>package"
date: 2020-05-30
category: R
tags: R function visualization plot package 
---

https://cran.r-project.org/web/packages/fplot/vignettes/fplot_walkthrough.html


<em>fplot</em> plots of distributions, automatically adjusting the parameters for the user. The syntax uses formulas, allowing conditional/weighted distributions with minimum efforts. The many arguments are automatically adjusted to provide the most meaningful (and hopefully beautiful!) graphs depending on the data at hand.

Although the core of the package concerns distributions, fplot also offers functions to plot trends (possibly conditional) and conditional boxplots.



```
library(fplot)
data(us_pub_econ, package = "fplot")
plot_distr(us_pub_econ$institution)
```
