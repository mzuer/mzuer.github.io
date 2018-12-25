---
layout: post
title: "R - <em>reshape</em> data frame to wide/long format"
date: 2018-12-25
category: R
tags: R function dataframe
---

<em>reshape</em> to reformat data frame in wide or long format

```
head(Indometh)
#   Subject time conc
# 1       1 0.25 1.50
# 2       1 0.50 0.94
# 3       1 0.75 0.78

wideFormat <- reshape(Indometh, v.names = "conc", idvar = "Subject",
                 timevar = "time", direction = "wide")
head(wideFormat)
#    Subject conc.0.25 conc.0.5 conc.0.75 conc.1 conc.1.25 conc.2 conc.3 conc.4 conc.5 conc.6 conc.8
# 1        1      1.50     0.94      0.78   0.48      0.37   0.19   0.12   0.11   0.08   0.07   0.05
# 12       2      2.03     1.63      0.71   0.70      0.64   0.36   0.32   0.20   0.25   0.12   0.08
# 23       3      2.72     1.49      1.16   0.80      0.80   0.39   0.22   0.12   0.11   0.08   0.08
# 34       4      1.85     1.39      1.02   0.89      0.59   0.40   0.16   0.11   0.10   0.07   0.07

longFormat <- reshape(wideFormat, direction = "long")
head(longFormat)
#        Subject time conc
# 1.0.25       1 0.25 1.50
# 2.0.25       2 0.25 2.03
# 3.0.25       3 0.25 2.72
# 4.0.25       4 0.25 1.85
# 5.0.25       5 0.25 2.05
# 6.0.25       6 0.25 2.31

longFormat2 <- reshape(wide, idvar = "Subject", varying = list(2:12),
         v.names = "conc", direction = "long")
head(longFormat2)
#     Subject time conc
# 1.1       1    1 1.50
# 2.1       2    1 2.03
# 3.1       3    1 2.72
# 4.1       4    1 1.85
# 5.1       5    1 2.05
# 6.1       6    1 2.31
 
```

