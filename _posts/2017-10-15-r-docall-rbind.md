---
layout: post
title: "R <em>do.call()</em> with <em>rbind()</em>: operate on data frame"
date: 2017-10-15
category: R
tags: [R, function]
---

Useful to aggregate based on more than one columns. For example to select the start that has the smallest end:

```
inData_smallest <- do.call(rbind, by(inData, inData$start, function(x) x[which.min(x$end),]))
```

Or to select the smallest start with biggest end:

```
inData_smallest <- do.call(rbind, by(tmpDF, tmpDF$gene_id, function(x) c(min(x$start), max(x$end))))
```


