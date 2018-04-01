---
layout: post
title: "R - make a vector monotonically decreasing (use <em>cummax</em> function)"
date: 2018-04-01
category: R
tags: [R function]
---

To transform a vector with decreasing values but potentially not monotonic using <em>rev(cummax(rev(c(...))))</em>

```
###### 3) transform the empFDR to make them <= 1 and monotonically decreasing; and select the smallest threshold that pass the desired empFDR threshold
#### transform the empFDR so that they are 1) not > 1 and 2) monotonically decreasing
# (code inspired from: csaw::empiricalFDR)
# forced monotonically decreasing example:
# if a higher FDR comes after, replaces current FDR with the higher FDR
# empFDR_seq_logFC_toy <- c(1, 0.97, 0.90, 0.92, 0.89, 0.75, 0.88, 0.86, 0.67, 0.66, 0.5, 0.6, 0.4, 0.2, 0.3)
# rev(cummax(rev(empFDR_seq_logFC_toy)))
# 1.00 0.97 0.90 0.92 0.89 0.75 0.88 0.86 0.67 0.66 0.50 0.60 0.40 0.20 0.30
# 1.00 0.97 0.92 0.92 0.89 0.88 0.88 0.86 0.67 0.66 0.60 0.60 0.40 0.30 0.30
# # (-> start from the right and retain the highest encounter value)
# empFDR_seq_logFC_toy <- c(1, 0.97, 0.4, 0.3, 0.7)
# rev(cummax(rev(empFDR_seq_logFC_toy)))
# 1.00 0.97 0.70 0.70 0.70

```
