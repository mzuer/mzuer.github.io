---
layout: post
title: "R - directory manipulation with <em>list.dirs()</em> and <em>dir.<...>()</em> functions"
date: 2018-12-27
category: R
tags: R function directory
---

Various functions for direct directory manipulation (e.g. avoid use of <em>system(<...command...>)</em>)


<em>dir.create()</em> to create the last element of the path, unless recursive = TRUE. 


<em>dir.exists()</em> to check existence of directory(ies)


See ?dir.create for more information

```
list.dirs(path = ".", full.names = TRUE, recursive = TRUE)


dir.exists(paths)
dir.create(path, showWarnings = TRUE, recursive = FALSE, mode = "0777")

```



