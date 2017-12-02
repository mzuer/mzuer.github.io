---
layout: post
title: "R - <em>reshape</em> and <em>xtabs</em>:transform columns to wide (matrix) format"
date: 2017-12-02
category: R
tags: [R, function, data frame]
---

Transform a data frame in columns to wide matrix format

For a data frame that looks like
```
col_i   col_j   value
var1    varA    x
var2    varB    y
...     ...     ...
```
To transform into a matrix format

```
        varA        varB    ...
var1    x           ...
var2    ...          y
...
```
1) Using <em>reshape</em>

```
data_mat <- reshape(data_DT, idvar="col_i", timevar = "col_j", direction ="wide")
# but then the colnames are affected and should be updated !
#  colnames(data_mat) <- gsub("value, "", colnames(data_mat))
```  
  
2) Using <em>xtabs</em>

```  
data_mat <- as.data.frame.matrix(xtabs(value ~ col_i + col_j, data_DT))
# this does not affect column names
```


