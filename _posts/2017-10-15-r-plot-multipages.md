---
layout: post
title: "<em>on.exit</em>: argument to execute before exit"
date: 2017-10-15
category: R
tags: [R, plot]
---

However, you can output multiple plots to multiple files (one-to-one) after a single call to one of the bitmapped device functions. 
See the 'filename' argument in the various functions (eg. ?png) where you can use a filename format that includes a sprintf style 
integer format, such as "MyPlots%03d.png". The "%03d" will start as '001' and increment with each new plot() call before the 
subsequent dev.off() call.

```
png(file = "test%03d.png")
barplot(1:5)
barplot(1:10)
barplot(1:15)
dev.off()
```


