---
layout: post
title: "R - coalesce 2 vectors with <em>dplyr</em>::<em>coalesce()</em>"
date: 2021-02-10
category: R
tags: R function dplyr
---

Merge 2 vectors: if y null populates with z


```
require(dplyr)

y <- c(1, 2, NA, NA, 5)
z <- c(NA, NA, 3, 4, 5)
coalesce(y, z)
# [1] 1 2 3 4 5

y <- c(1, 2, 7, NA, 5)
z <- c(NA, NA, 3, 4, 5)
coalesce(y, z)
# [1] 1 2 7 4 5
```

