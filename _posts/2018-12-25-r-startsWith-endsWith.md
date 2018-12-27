---
layout: post
title: "R - check start (<em>startsWith()</em>) and end (<em>endsWith()</em>) of a string"
date: 2018-12-25
category: R
tags: R function string
---

Check if elements start (<em>startsWith</em>) or end (<em>endsWith</em>) with a string:


```
# Check whether elements start with a string
startsWith(month.name, "J")
# [1]  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE
# [12] FALSE

# Check whether elements end with a string
endsWith(month.name, "ember")
# [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE
# [12]  TRUE

```
