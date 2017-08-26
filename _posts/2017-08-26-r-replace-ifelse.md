---
layout: post
title: "avoid ifelse"
date: 2017-08-26
category: R
tags: [R, logic]
---

ifelse is known to be slow; instead of writing:

```
ifelse(female, 1.25, 0.75), write
```

prefer: 

```
p + 0.75 + 0.5 * female
```



