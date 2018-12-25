---
layout: post
title: "R - string quote function (<em>sQuote</em>, <em>dQuote</em>)"
date: 2018-12-25
category: R
tags: R strings function
---

Functions to use for quoting string vectors: <em>sQuote</em>, <em>dQuote</em>, <em>shQuote</em>:


```
# Quoting text for fancier priting - single quotes
sQuote(month.name)

##  [1] "'January'"   "'February'"  "'March'"     "'April'"     "'May'"      
##  [6] "'June'"      "'July'"      "'August'"    "'September'" "'October'"  
## [11] "'November'"  "'December'"

# Quoting text for fancier priting - double quotes
dQuote(month.name)

##  [1] "\"January\""   "\"February\""  "\"March\""     "\"April\""    
##  [5] "\"May\""       "\"June\""      "\"July\""      "\"August\""   
##  [9] "\"September\"" "\"October\""   "\"November\""  "\"December\""

# Not to be confused with quoting strings for passing to OS shell !
system(paste("echo", shQuote("Weird\nstuff")))
# -> quote Strings for Use in OS Shells

# Also not be confused with quoting expressions
str(quote(1 + 1))
##  language 1 + 1
```


