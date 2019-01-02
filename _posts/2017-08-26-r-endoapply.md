---
layout: post
title: "R - <em>endoapply()</em> equivalent of <em>lapply()</em> {S4Vectors}"
date: 2017-08-26
category: R
tags: [R, function, list]
---

http://bioconductor.org/packages/devel/bioc/vignettes/GenomicRanges/inst/doc/GenomicRangesIntroduction.pdf
(loaded with GenomicRanges)


<code>endoapply</code> and <code>mendoapply</code> perform the endomorphic equivalents of <code>lapply</code> and <code>mapply</code> by returning objects of the same class as the inputs rather than a list.

The return function should return object of the same class.

```
gr1 <- GRanges(
     seqnames = "chr2",
     ranges = IRanges(103, 106),
     strand = "+",
     score = 5L, GC = 0.45)

gr2 <- GRanges(
     seqnames = c("chr1", "chr1"),
     ranges = IRanges(c(107, 113), width = 3),
     strand = c("+", "-"),
     score = 3:4, GC = c(0.3, 0.5))

grl <- GRangesList("txA" = gr1, "txB" = gr2)

lapply(grl, length)
# $txA
# [1] 1

# $txB
# [1] 2

endoapply(grl, length)
# Error in .updateCompressedList(X, lapply_CompressedList(X, FUN, ...)) : 
#   'FUN' must return elements of class GRanges

endoapply(grl, rev)
# GRangesList object of length 2:
# $txA 
# GRanges object with 1 range and 2 metadata columns:
#       seqnames     ranges strand |     score        GC
#          <Rle>  <IRanges>  <Rle> | <integer> <numeric>
#   [1]     chr2 [103, 106]      + |         5      0.45
# 
# $txB 
# GRanges object with 2 ranges and 2 metadata columns:
#       seqnames     ranges strand | score  GC
#   [1]     chr1 [113, 115]      - |     4 0.5
#   [2]     chr1 [107, 109]      + |     3 0.3
# 
# -------
# seqinfo: 2 sequences from an unspecified genome; no seqlengths

```




