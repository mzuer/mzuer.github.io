---
layout: post
title: "<em>as.list</em>: convert element of a vector to element of list"
date: 2017-08-26
category: R
tags: [R, function, vector, list]
---

```
datasetList <- c("DI", "IS", "MrTADFinder")
# [1] "DI"          "IS"          "MrTADFinder"

as.list(setNames(datasetList, paste(datasetList, "domains")))
# $`DI domains`
# [1] "DI"
# $`IS domains`
# [1] "IS"
# $`MrTADFinder domains`
# [1] "MrTADFinder"
```

