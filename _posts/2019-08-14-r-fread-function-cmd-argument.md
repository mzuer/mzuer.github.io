---
layout: post
title: "R - <em>fread()</em>: highly composite numbers"
date: 2019-08-14
category: R
tags: R function 
---


Use <em>fread()</em> function with <em>cmd</em> argument with a shell command that pre-processes the file(s). 


Example: use <em>grep</em> first and only have <em>fread()</em> process output of that command:

``` 
library(data.table)
dataDir <- path.expand("~/dataexpo")
dataFiles <- dir(dataDir, pattern = "csv$", full.names = TRUE)
# All flights by American Airlines
command <- sprintf("grep --text ',AA,' %s", paste(dataFiles, collapse = " "))
dt <- data.table::fread(cmd = command)
``` 
