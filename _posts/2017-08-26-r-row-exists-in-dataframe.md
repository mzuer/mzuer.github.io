---
layout: post
title: "R - Test if a data frame row exists in an other data frame"
date: 2017-08-26
category: R
tags: [R, data_frame, logic]
---

Test if the "vector" <code>oldCoord</code> is a row of the data frame <code>newCoord</code>

```
# do not use apply otherwise always TRUE
newInOld <- foreach(i = 1:nrow(newCoord), .combine='c') %dopar% {
  nrow(merge(newCoord[i,], oldCoord)) > 0 
}
```
