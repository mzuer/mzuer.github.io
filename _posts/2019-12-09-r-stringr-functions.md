---
layout: post
title: "R - <em>str_split()</em>, <em>str_count()</em> and <em>str_extract_all()</em> from <em>stringr</em> package"
date: 2019-12-09
category: R
tags: R string package
---



```
x <- "This is a sentence."
str_split(x, boundary("word"))
#> [[1]]
#> [1] "This"     "is"       "a"        "sentence"
str_count(x, boundary("word"))
#> [1] 4
str_extract_all(x, boundary("word"))
#> [[1]]
#> [1] "This"     "is"       "a"        "sentence"

```


and other functions from <em>stringr</em> package
