---
layout: post
title: "Bash - update value of a variable"
date: 2017-10-15
category: bash
tags: [bash]
---

Examples how to increment a variable:


```
var=$((var+1))
((var=var+1))
((var+=1))
((var++))
```

Or using <em>let</em>

```
let "var=var+1"
let "var+=1"
let "var++"
```




