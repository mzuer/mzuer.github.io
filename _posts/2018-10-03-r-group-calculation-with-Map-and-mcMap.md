---
layout: post
title: "R - by-group calculation with <em>Map</em> and <em>mcMap</em>"
date: 2018-10-03
category: R
tags: R function parallel
---


```
data(iris)
lst1 <- split(iris, iris$Species)
Map(class, lst1)
#$setosa
#[1] "data.frame"
#$versicolor
#[1] "data.frame"
#$virginica
#[1] "data.frame"


Map(function(x) data.frame(grp = unique(x$Species), sl_avg = mean(x$Sepal.Length), sw_avg = mean(x$Sepal.Width)), lst1)
#$setosa
#     grp sl_avg sw_avg
#1 setosa  5.006  3.428
#$versicolor
#         grp sl_avg sw_avg
#1 versicolor  5.936   2.77
#$virginica
#        grp sl_avg sw_avg
#1 virginica  6.588  2.974


pkg <- list("parallel", "future")
mapply(function(x) require(x, character.only = T), pkg)
ft <- future({split(iris, iris$Species)})
mcMap(function(i) with(value(ft)[[i]], data.frame(grp = unique(Species), sl_avg = mean(Sepal.Length), sw_avg = mean(Sepal.Width))), 1:length(unique(iris$Species)), mc.cores = detectCores())
#[[1]]
#     grp sl_avg sw_avg
#1 setosa  5.006  3.428
#[[2]]
#         grp sl_avg sw_avg
#1 versicolor  5.936   2.77
#[[3]]
#        grp sl_avg sw_avg
#1 virginica  6.588  2.974
```
