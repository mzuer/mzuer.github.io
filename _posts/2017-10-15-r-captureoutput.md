---
layout: post
title: "R - <em>capture.output()</em>: save output into file (outputs from <em>summary</em>, <em>lm</em>, etc.)"
date: 2017-10-15
category: R
tags: [R, function]
---

Similar to <em>sink()</em>:

```
s <- summary(iris)
capture.output(s, file = "myfile.txt")

mod1 <- lm(size ~ day, data=myData)
capture.output(mod1, file = "myfile.txt")

```
