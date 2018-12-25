---
layout: post
title: "R - trim strings with <em>strtrim</em>"
date: 2018-12-25
category: R
tags: R strings function
---

Use of <em>strtrim</em> for trimming character vectors to specified display widths:

```
### Trim character strings to specified display widths.
strtrim(month.name, 3)
#  [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
# [12] "Dec"
```
See also <em>trimws</em> to trim leading and trailing whitespaces.

