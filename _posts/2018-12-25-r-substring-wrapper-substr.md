---
layout: post
title: "R - <em>substring()</em>: wrapper for <em>substr()</em>"
date: 2018-12-25
category: R
tags: R function string
---

<em>substring</em>: wrapper for <em>substr</em>


```
substring(text=month.name, first=1, last=3)
# [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
substr(x=month.name, start=1, stop=3)
# [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec" 
```
