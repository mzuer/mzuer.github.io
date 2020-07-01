---
layout: post
title: "R - save datasets (<em>save()</em>,<em>saveRDS()</em>, <em>write.table()</em>, <em>WriteXLS()</em>)"
date: 2019-05-31
category: R
tags: R function objects save
---


https://www.r-bloggers.com/how-to-save-and-load-datasets-in-r-an-overview/


### Save R objects

1. <em>save()</em> -> create an .Rdata file, where several variables can be stored. 
To save space, use with <em>compress=TRUE</em> (default), to save time use with <em>compress = FALSE</em>.

```
data2 <- data
save(list = c("data", "data2"), file = "data.Rdata")
load("data.Rdata")
```

2. <em>saveRDS()</em> -> create an .Rds file. where only 1 variable can be stored.
The <em> compress</em> parameter is also available for saveRDS)

```
saveRDS(data, file = "data.Rds")
data.copy <- readRDS(file = "data.Rds")
```

With <em>readRDS()</em>, assign the result of the reading process to a variable.

With <em>load()</em>, you have to remember the name of the stored variable.


### Save as a CSV file

- <em>write.table()</em>

- <em>fwrite()</em>




### Save as an Excel file

```
library(WriteXLS)
WriteXLS()
```
