---
layout: post
title: "<em>!!</em> operator from <em>rlang</em> package"
date: 2020-07-02
category: R
tags: [R, operators, package]
---

The big-bang operator !!! forces-splice a list of objects. The elements of the list are spliced in place, meaning that they each become one single argument.

Example:

``` 
# Use `!!!` to add multiple arguments to a function. Its argument
# should evaluate to a list or vector:
args <- list(1:3, na.rm = TRUE)
quo(mean(!!!args))
``` 

