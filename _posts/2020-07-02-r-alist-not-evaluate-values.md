---
layout: post
title: "<em>alist()</em> to not evaluate the values"
date: 2020-07-02
category: R
tags: [R, functions, list]
---

<em>alist()</em> handles its arguments as if they described function arguments. So the values are not evaluated, and tagged arguments with no value are allowed whereas list simply ignores them. alist is most often used in conjunction with formals.

```{r}
# Note the specification of a "..." argument:
formals(f) <- al <- alist(x = , y = 2+3, ... = )

f
#function (x, y = 2 + 3, ...) 

al
#$x
#
#$y
#2 + 3
#
#$...
#
```

