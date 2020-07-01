---
layout: post
title: "Bash - move file in a for loop"
date: 2020-07-01
category: R
tags: [bash, for, loop]
---



```{bash}
for file in *.jpg ; do mv $file ${file//IMG/myVacation} ; done
```
