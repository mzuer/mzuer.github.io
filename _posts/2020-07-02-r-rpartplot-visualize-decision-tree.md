---
layout: post
title: "R - <em>rpart()</em> to fit and <em>rpart.plot()</em> for fitting and visualizing decision trees"
date: 2020-07-02
category: R
tags: [R, function, package, machine_learning, plot]
---


https://github.com/fpsom/IntroToMachineLearning/blob/gh-pages/episodes/04-supervised-learning.md

use the rpart and the rpart.plot package in order to produce and visualize a decision tree

```{r}
library(rpart)
library(rpart.plot)
myFormula <- Diagnosis ~ Radius.Mean + Area.Mean + Texture.SE

breastCancerData.model <- rpart(myFormula,
                                method = "class",
                                data = breastCancerData.train,
                                minsplit = 10,
                                minbucket = 1,
                                maxdepth = 3,
                                cp = -1)

print(breastCancerData.model$cptable)
rpart.plot(breastCancerData.model)
```
