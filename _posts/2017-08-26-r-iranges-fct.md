---
layout: post
title: "R - Functions from the <em>IRanges</em> package"
date: 2017-08-26
category: R
tags: [R, function, package]
---

https://bioconductor.org/packages/devel/bioc/vignettes/IRanges/inst/doc/IRangesOverview.pdf

* <em>findOverlaps</em> => detect overlaps
* <em>coverage</em> => count number of ranges over each position
* <em>nearest</em> => find nearest neighbor ranges (overlapping is zero distance) 
* <em>preced</em> / follow</em>  => find non-overlapping nearest neighbors on specific direction
* <em>disjoin</em> => make the ranges non-overlapping
* set operations are implemented in 2 ways (1 normal, 1 applied to each pair)
