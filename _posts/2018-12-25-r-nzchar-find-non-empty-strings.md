---
layout: post
title: "R - <em>nzchar()</em>: find non empty strings"
date: 2018-12-25
category: R
tags: R function string
---

<em>nzchar</em>: find out if elements of a character vector are non-empty string


```
x <- c("asfef", "", "()", "", NA, "hello")
nzchar(x)
# [1]  TRUE FALSE  TRUE FALSE  TRUE  TRUE
```
