---
layout: post
title: "<em>mclapply</em>: parallelized apply"
date: 2017-10-15
category: R
tags: [R, function]
---

Parallelized apply with <em>mclapply{parallel}</em>


```
library(parallel)
options(mc.cores=2)
m<-mclapply(seq_along(chep.37),function(i){
	gr<-chep.37[[i]]
	mapChepToHindIII(gr,h.gr,prom.ass)
})
```
