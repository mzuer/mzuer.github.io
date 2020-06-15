---
layout: post
title: "R - use function to directly change axis labels in <em>ggplot2</em>"
date: 2020-05-30
category: R
tags: R ggplot2 package plots visualization function
---

The <em>labels</em> parameter of <em>scale_x_discrete()</em> (and similar functions) can directly take a function: 


```
[...] +
  scale_x_discrete(labels=function(x){sub("\\s", "\n", x)})
```
