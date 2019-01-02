---
layout: post
title: "R - <em>file.path()</em>: construct path to file"
date: 2017-10-15
category: R
tags: [R, function]
---

Construct the path to a file from components in a platform-independent way


```
outFold <- "outfolder"
file.path(outFold, "myfile.txt")
# [1] "outfolder/myfile.txt"
```
