---
layout: post
title: "R - example of <em>mclapply</em> usage"
date: 2018-06-03
category: R
tags: R function parallel
---

Example how to use  <em>parallel::mclapply</em>:

```
binnedMean2 <- function(bins, numvar) {
  stopifnot(is(bins, "GRangesList"))
  stopifnot(is(numvar, "RleList"))
  mean.list <- mclapply(names(bins),
                        function(binname) {
                          print(binname)
                          seqname=unique(as.character(seqnames(bins[[binname]])))
                          views <- Views(numvar[[seqname]],ranges(bins[[binname]]))
                          sum(viewSums(views))/sum(as.numeric(width(bins[[binname]])))
                        },mc.cores=9)
  names(mean.list) <- names(bins)
  mean.list <- unlist(mean.list)
  mean.list
}
```
