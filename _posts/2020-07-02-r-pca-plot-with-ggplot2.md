#---
layout: post
title: "R - <em>ggbiplot()</em>: plot of PCA results with <em>ggplot2</em>"
date: 2020-07-02
category: R
tags: [R, ggplot2, visualization, plot, functions, packages]
---


https://github.com/fpsom/IntroToMachineLearning/blob/gh-pages/episodes/03-eda-unsupervised-learning.md

draw result of PCA with ggplot2 framework

```
ggbiplot(ppv_pca, choices=c(1, 2),
         labels=rownames(breastCancerData),
         ellipse=TRUE,
         groups = breastCancerData$Diagnosis,
         obs.scale = 1,
         var.axes=TRUE, var.scale = 1) +
  ggtitle("PCA of Breast Cancer Dataset")+
  theme_minimal()+
  theme(legend.position = "bottom")
```
