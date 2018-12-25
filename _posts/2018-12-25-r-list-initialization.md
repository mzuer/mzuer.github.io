---
layout: post
title: "R - list initialization (use of NA empty elements of specified types)"
date: 2018-12-25
category: R
tags: R plot ggplot2 lattice visualization
---

Example of list initialization (use of <em>L</em>, <em>NA_character_</em>, <em>NA_integer_</em)


```
weirdList <- list(
  "What is this?",
  Sys.time(),
  b = 5L,
  c = c("one", 2),
  d = factor(c("red", "blue")),
  e = NA_character_,
  f = NA_integer_
)

str(weirdList)

## List of 7
##  $  : chr "What is this?"
##  $  : POSIXct[1:1], format: "2018-11-24 11:55:57"
##  $ b: int 5
##  $ c: chr [1:2] "one" "2"
##  $ d: Factor w/ 2 levels "blue","red": 2 1
##  $ e: chr NA
##  $ f: int NA

```
