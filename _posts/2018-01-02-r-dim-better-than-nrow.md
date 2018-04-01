---
layout: post
title: "R - why it is better to use <em>dim(x)[1]</em> rather than <em>nrow(x)</em>"
date: 2018-01-02
category: R
tags: [R, function]
---

It is more efficient to use <code>dim(x)[1]</code> to retrieve the number of rows rather than <code>nrow(x)</code> !

So to speed up your code, use <code>dim(x)</code)>. Full explanation here:

https://www.r-bloggers.com/nrow-references-and-copies/
