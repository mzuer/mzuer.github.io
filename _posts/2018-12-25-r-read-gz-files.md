---
layout: post
title: "R - read gz files"
date: 2018-12-25
category: R
tags: R io table function package
---

Read <em>gz</em> files in R:

```
read.table(gzfile("foo.csv.gz"))

```

Or using <em>fread</em> from <em>data.table</em> package:

<a href="https://www.r-bloggers.com/now-fread-from-data-table-can-read-gz-and-bz2-files-directly">https://www.r-bloggers.com/now-fread-from-data-table-can-read-gz-and-bz2-files-directly</a>
