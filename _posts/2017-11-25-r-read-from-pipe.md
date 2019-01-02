---
layout: post
title: "R - read from command line pipe with <em>read.table(pipe(...))</em>"
date: 2017-11-25
category: R
tags: [R, i/o]
---

Read data from connection:

```
data <- read.table(pipe("sed -n -e'5000001p' data.csv"), sep=',')

```
