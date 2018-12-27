---
layout: post
title: "R - conversion between encodings with <em>iconv()</em>"
date: 2018-12-25
category: R
tags: R function string
---

Use <em>iconv</em> to convert string vectors between different encodings

``` 
# Convert a character vector between encodings
iconv(x = "šibrinkuje", from = "UTF-8", to = "ASCII", sub = "?")

# sub: character string. If not NA it is used to replace any non-convertible bytes in the input. 
```


