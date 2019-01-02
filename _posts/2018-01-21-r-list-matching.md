---
layout: post
title: "R - list element matching (usage of <em>%in%</em> with lists)"
date: 2018-01-21
category: R
tags: [R, data_structure]
---

Can test the existence of a given vector within a list directly with <em>%in%</em>: 


```
mylist1 <- list(c(1,2,3,4,5), c(5,6,7))
#[[1]]
#[1] 1 2 3 4 5

#[[2]]
#[1] 5 6 7

list(c(5,6,7)) %in% mylist1
#[1] TRUE

list(c(5,6)) %in% mylist1
#[1] FALSE

```
