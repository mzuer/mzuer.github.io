---
layout: post
title: <em>cut</em>, <em>cut2</em> and <em>split</em>: splitting vectors in intervals
date: 2017-09-02
category: R
tags: [R, vector]
---

combine cut/cut2 and split for splitting vector 


use cut for splitting in intervals that cover the same interval length

```
set.seed(20)
vect <- round(runif(20,min=0, max=20))
# cut to split a vector of integer into intervals of same size
cut(vect, 3)
# [1] (13.3,20]    (13.3,20]    (-0.02,6.67] (6.67,13.3]  (13.3,20]    (13.3,20]    (-0.02,6.67]
# [8] (-0.02,6.67] (6.67,13.3]  (6.67,13.3]  (13.3,20]    (13.3,20]    (-0.02,6.67] (13.3,20]   
# [15] (-0.02,6.67] (6.67,13.3]  (-0.02,6.67] (-0.02,6.67] (-0.02,6.67] (13.3,20]   
# Levels: (-0.02,6.67] (6.67,13.3] (13.3,20]
split(vect, cut(vect, 3))
# $`(-0.02,6.67]`
# [1] 6 2 1 0 4 6 2 6
# $`(6.67,13.3]`
# [1] 11  7  7  9
# $`(13.3,20]`
# [1] 18 15 19 20 14 15 15 16
```

use cut2 for splitting in equal size groupe

```
library(Hmisc)  # for cut2
# cut2 to split a vector containing the same number of elements (quantile; "g" argument gives the number of groups)
cut2(vect, g=3)
# [1] [16,20] [ 7,16) [ 0, 7) [ 7,16) [16,20] [16,20] [ 0, 7) [ 0, 7) [ 7,16) [ 7,16) [ 7,16)
# [12] [ 7,16) [ 0, 7) [ 7,16) [ 0, 7) [ 7,16) [ 0, 7) [ 0, 7) [ 0, 7) [16,20]
# Levels: [ 0, 7) [ 7,16) [16,20]
split(vect, cut2(vect, g=3))
# $`[ 0, 7)`
# [1] 6 2 1 0 4 6 2 6
# $`[ 7,16)`
# [1] 15 11  7  7 14 15 15  9
# $`[16,20]`
# [1] 18 19 20 16
cut2(vect, g=3, levels.mean = T)
# [1] 18.250 11.625  3.375 11.625 18.250 18.250  3.375  3.375 11.625 11.625 11.625 11.625  3.375
# [14] 11.625  3.375 11.625  3.375  3.375  3.375 18.250
# Levels:  3.375 11.625 18.250
split(vect, cut2(vect, g=3, levels.mean = T))
# $` 3.375`
# [1] 6 2 1 0 4 6 2 6
# $`11.625`
# [1] 15 11  7  7 14 15 15  9
# $`18.250`
# [1] 18 19 20 16
```


