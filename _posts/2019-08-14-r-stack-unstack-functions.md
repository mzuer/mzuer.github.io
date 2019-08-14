---
layout: post
title: "R - <em>stack()</em> and <em>unstack()</em>"
date: 2019-08-14
category: R
tags: R function
---


The <em>stack()</em> function is used to transform data available as separate columns in a data frame or list into a single column that can be used in an analysis of variance model or other linear model. 
The <em>unstack()</em> function reverses this operation.


```
formula(PlantGrowth)         # check the default formula
pg <- unstack(PlantGrowth)   # unstack according to this formula
pg
stack(pg)                    # now put it back together
stack(pg, select = -ctrl)    # omitting one vector
```



```
id <- c("a", "b", "c", "a", "b", "c", "a", "b", "c")
par <- c("a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9")
df1 <- as.data.frame(cbind(id, par))

u_df1 <-unstack(df1, par~id)

stack(u_df1)
```

