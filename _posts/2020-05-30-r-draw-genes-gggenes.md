---
layout: post
title: "R - draw genes in ggplot2 plots with <em>gggenes</em>"
date: 2020-05-30
category: R
tags: R visualization plot package ggplot2 function genomics
---


https://cran.r-project.org/web/packages/gggenes/vignettes/introduction-to-gggenes.html


Draw genes in ggplot2 plots with <em>geom_gene_arrow()</em>, <em>geom_gene_label()</em>, and <em>geom_subgene_arrow()</em> <em>geom_subgene_label()</em>



```
ggplot(subset(example_genes, molecule == "Genome4" & gene == "genA"),
       aes(xmin = start, xmax = end, y = strand)
  ) +
  geom_gene_arrow() +
  geom_gene_label(aes(label = gene)) +
  geom_subgene_arrow(
    data = subset(example_subgenes, molecule == "Genome4" & gene == "genA"),
    aes(xsubmin = from, xsubmax = to, fill = subgene)
  ) +
  geom_subgene_label(
    data = subset(example_subgenes, molecule == "Genome4" & gene == "genA"),
    aes(xsubmin = from, xsubmax = to, label = subgene),
    min.size = 0
  )
```
