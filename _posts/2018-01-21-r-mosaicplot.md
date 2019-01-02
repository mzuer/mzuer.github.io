---
layout: post
title: "R - <em>mosaicplot()</em> a dataframe"
date: 2018-01-21
category: R
tags: [R, plot]
---


Visualize data frame with <em>mosaicplot</em> (can use formula expression):


```

mosaicplot(~ Sex + Age + Survived, data = Titanic, color = TRUE)

```
