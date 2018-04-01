---
layout: post
title: "R - notes on <em>lattice</em> plot"
date: 2018-04-01
category: R
tags: [R plot]
---

Use <em>print</em> to save <em>lattice</em> plot in file


Use <em>scales</em> parameter for plots with different axes

```
png("myfile.png")
# x- and y-axes free
print(densityplot(~my_variable|my_category, main="", scales="free"))
dev.off()


png("myfile.png")
# only y-axes free
print(densityplot(~my_variable|my_category, main="", scales = list(y = list(relation = "free"))) 
dev.off()


            

```

