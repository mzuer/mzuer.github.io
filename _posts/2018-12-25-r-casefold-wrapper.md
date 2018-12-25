---
layout: post
title: "R - <em>casefold</em> as a wrapper for <em>tolower</em> and <em>toupper</em>"
date: 2018-12-25
category: R
tags: R strings function
---

<em>casefold</em> is a wrapper for <em>tolower</em> and <em>toupper</em> (provided for compatibility with S-PLUS)


```
casefold("hello", upper=TRUE) # same as toupper("hello")
# HELLO

casefold("HELLO", upper=FALSE) # same as tolower("HELLO")
# hello
```


