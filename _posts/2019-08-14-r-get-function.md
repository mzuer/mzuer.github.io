---
layout: post
title: "R - <em>get()</em>: retrieve value of a named object"
date: 2019-08-14
category: R
tags: R function 
---

<em>get()</em> returns the value of a named object



Using <em>get()</em> may be shorter than <em>eval(parse())</em>.


```
zz <- 2
get("zz")
#[1] 2
eval(parse(text = "zz"))
#[1] 2
```
