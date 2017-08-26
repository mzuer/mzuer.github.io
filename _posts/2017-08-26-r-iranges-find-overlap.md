---
layout: post
title: "Example of usage of <em>IRanges::findOverlaps</em>"
date: 2017-08-26
category: R
tags: [R, function, package]
---

Example how to find overlap between intervals and select min start and max end of overlapping

```
# find overlap and replace by min start and max end

bdRange <-   IRanges(boundariesDT$start, boundariesDT$end)
boundariesDT$group <- subjectHits(findOverlaps(bdRange, reduce(bdRange)))
  
boundariesDT_noOverlap <- data.frame(chromo, 
                              do.call(rbind,by(boundariesDT, boundariesDT$group, 
                                               function(x) c(min(x$start), max(x$end)))))

colnames(boundariesDT_noOverlap) <- c("chromo", "start", "end")
```
