---
layout: post
title: "R - contingency table (<em>addmargins</em> and <em>prop.table</em>)"
date: 2018-01-21
category: R
tags: [R, function]
---


```
depsmok <- matrix(c(144,1729,50,1290),byrow=T,ncol=2);
dimnames(depsmok) <- list(Ever_Smoker=c("Yes","No"),Depression=c("Yes","No"));
depsmok
addmargins(depsmok)
addmargins(prop.table(depsmok))
sweep(depsmok,1,rowSums(depsmok), "/")
```


