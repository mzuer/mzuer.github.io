---
layout: post
title: "R - reverse a string"
date: 2019-05-31
category: R
tags: R function string
---


https://www.r-bloggers.com/four-ways-to-reverse-a-string-in-r/

1) <em>strsplit()</em> and <em>paste()</em> (base R)
2) <em>utf8ToInt()</em> and intToUtf8()</em> (base R)
3) <em>stri_reverse()</em> (<em>stringi</em> package)
4) <em>str_rev()</em> (<em> Biostrings</em> package)


``` 
set.seed(1)
dna <- paste(sample(c("A", "T", "C", "G"), 10000000, replace = T), collapse = "")
``` 

``` 
# 1) Base R: strsplit and paste

splits <- strsplit(dna, "")[[1]]
reversed <- rev(splits)
final_result <- paste(reversed, collapse = "")


# 2) Base R: intToUtf8 and utf8ToInt

final_result <- intToUtf8(rev(utf8ToInt(dna)))


# 3) The stringi package
# (fastest)
	
library(stringi)
 
final_result <- stri_reverse(dna)


# 4) The Biostrings package

biocLite("Biostrings")
 
library(Biostrings)

final_result <- str_rev(dna)

```


