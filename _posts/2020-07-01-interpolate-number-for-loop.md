---
layout: post
title: "Bash - interpolate between 2 numbers for for-loop"
date: 2020-07-01
category: R
tags: [bash, for]
---

### Interpolate between number range for for-loop

```{bash}
for chromo in ( "chr"{1..22} ); do echo $chromo; done
```
