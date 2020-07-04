#---
layout: post
title: "R - <em>ggpairs()</em> from <em>GGally</em> to plot matrix of all plot types"
date: 2020-07-02
category: R
tags: [R, ggplot2, visualization, plot, function, package]
---


plot matrix of with all possible kinds of plots (boxplots, dotplots, densityplots, etc.)


seen here: https://github.com/fpsom/IntroToMachineLearning/blob/gh-pages/episodes/03-eda-unsupervised-learning.md

``` 
library(GGally)

ggpairs(breastCancerDataNoID[1:5], aes(color=Diagnosis, alpha=0.4))

```
