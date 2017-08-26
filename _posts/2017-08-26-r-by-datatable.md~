---
layout: post
title: "<em>by</em> and <em>data.table</em>: select data frame on > 1 criterion (e.g. select min start and max end)"
date: 2017-08-26
category: R
tags: [R, function, data_frame]
---


With <code>data.table</code>: 

* find the smallest start and biggest end of a given gene ID

```
data.table(tmpDF)[,.(min(start), max(end)), .(gene_id)]
```

With <code>by</code>: 

* e.g. find the smallest <code>end</code> of a given start

```
do.call(rbind, by(inData, inData$start, function(x) x[which.min(x$end),]))
```

* e.g. find the smallest start and biggest end of a given gene ID

```
do.call(rbind, by(tmpDF, tmpDF$gene_id, function(x) c(min(x$start), max(x$end))))
```

