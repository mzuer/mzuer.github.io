---
layout: post
title: "R - pattern matching with <em>gregexpr</em>"
date: 2018-12-25
category: R
tags: R function string regexpr
---

<em>gregexpr</em> for pattern matching:
returns a list of the same length as text each element of which is of the same form as the return value for regexpr, except that the starting positions of every (disjoint) match are given.

```
myStrings <- c("20.january", "4.april")
gregexpr("a", myStrings)
# [[1]]
# [1] 5 8
# attr(,"match.length")
# [1] 1 1
# attr(,"useBytes")
# [1] TRUE
# [[2]]
# [1] 3
# attr(,"match.length")
# [1] 1
# attr(,"useBytes")
# [1] TRUE
```

