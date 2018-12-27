---
layout: post
title: "R - control flow with <em>repeat{}</em>"
date: 2018-12-25
category: R
tags: R flow
---

Control flow with <em>repeat</em>


Format:
``` 
repeat expr
```

Basic syntax example:
```
x <- 0
repeat {
  print("a\n")
  if(x==3) break
  x <- x+1
}

```



