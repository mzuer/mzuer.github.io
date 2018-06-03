---
layout: post
title: "R - wrap string with <em>strwrap</em>"
date: 2018-06-03
category: R
tags: [R function string plot]
---

<em>strwrap</em>: to wrap strings to format paragraphs (can be useful e.g. to break plot axis labels)


Each character string in the input is first split into paragraphs (or lines containing whitespace only). 

The paragraphs are then formatted by breaking lines at word boundaries. 

The target columns for wrapping lines and the indentation of the first and all subsequent lines of a paragraph can be controlled independently.



```
strwrap(x, width = 0.9 * getOption("width"), indent = 0,
        exdent = 0, prefix = "", simplify = TRUE, initial = prefix)


cat("data.file")
writeLines(strwrap("file location (absolute path and file name)", indent=0, exdent=0, initial="\t\t", prefix="\t\t\t") )

```

