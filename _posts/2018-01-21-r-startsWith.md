---
layout: post
title: "R - <em>startsWith</em>"
date: 2018-01-21
category: R
tags: R function string
---

To test if a string starts with a certain pattern, more efficient than using <em>substr()</em> and testing equality:

```
x1 <- "foobar"
startsWith(x1, "foo")
# [1] TRUE
```


