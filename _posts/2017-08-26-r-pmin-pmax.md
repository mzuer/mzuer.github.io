---
layout: post
title: "<em>pmin</em> and <em>pmax</em>: parallel minima and maxima"
date: 2017-08-26
category: R
tags: [R, logic]
---

take one or more vectors as arguments, recycle them to common length and return a single vector giving the ‘parallel’ maxima (or minima) of the argument vectors

```
min(5:1, pi)
# [1] 1
pmin(5:1, pi)
# [1] 3.141593 3.141593 3.000000 2.000000 1.000000
```


