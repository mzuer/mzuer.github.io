---
layout: post
title: "R - extract names from expression with <em>all.names()</em> and <em>all.vars()</em>"
date: 2021-02-10
category: R
tags: R text function
---

Extract names from expressions with  <em>all.names()</em> and <em>all.vars()</em> 

```
all.names(expression(sin(x+y)))
# [1] "sin" "+"   "x"   "y"  
all.vars(expression(sin(x+y)))
# [1] "x" "y"
```

The 2 differ from their default values

```
all.names(expr, functions = TRUE, max.names = -1L, unique = FALSE)
all.vars(expr, functions = FALSE, max.names = -1L, unique = TRUE)
```
