---
layout: post
title: "R - get overlap between intervals using functions from <em>IRanges</em>"
date: 2018-04-01
category: R
tags: [R package function]
---

Get overlap between 2 intervals using various functions from the <em>IRanges</em> package: <em>findOverlaps</em>, <em>pintersect</em>, <em>queryHits</em> and <em>subjectHits</em>.


For example, to get overlap between genes and TADs:

```
# Search for hit of genes in TADs
tad_gene_hits <- findOverlaps(query=gene_ranges_chr, subject= tad_ranges_chr)

# Compute percent overlap and filter the hits:
sizeOverlaps <- pintersect(gene_ranges_chr[queryHits(tad_gene_hits)], tad_ranges_chr[subjectHits(tad_gene_hits)])
sizeOverlapDT <- tad_gene_hits

# For each hit, get the bp of the overlap
metadata(sizeOverlapDT)$overlapBp <- width(sizeOverlaps)
metadata(sizeOverlapDT)$entrezID <- metadata(gene_ranges_chr)$entrezID[queryHits(tad_gene_hits)]
stopifnot(metadata(gene_ranges_chr)$chromo[queryHits(tad_gene_hits)] == chromo)
metadata(sizeOverlapDT)$region <- metadata(tad_ranges_chr)$region[subjectHits(tad_gene_hits)]

overlapDT <- data.frame(metadata(sizeOverlapDT), stringsAsFactors = FALSE)
# overlapBp entrezID    region

```

(! See <em>Hits</em> objects from {S4Vectors} !)
