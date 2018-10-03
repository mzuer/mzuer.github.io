---
layout: post
title: "R - create secondary axis in ggplot2"
date: 2018-10-03
category: R
tags: R plot ggplot2
---


```
library(ggplot2)
p <- ggplot(mtcars, aes(cyl, mpg)) +
  geom_point()
```

Create a simple secondary axis

```
# secondary axis with labels = y_axis + 10
p +  scale_y_continuous(sec.axis = sec_axis(~.+10))
```


Create a simple secondary axis with name from primary axis

```
# same but with axis name same as the one from primary axis
p + scale_y_continuous("Miles/gallon", sec.axis = sec_axis(~.+10, name = derive()))
```


Create secondary axis by duplicating primary axis

```
# Duplicate the primary axis
p + scale_y_continuous(sec.axis = dup_axis())
```

Create secondary axis by passing a formula

```
# pass in a formula as a shorthand
p + scale_y_continuous(sec.axis = ~.^2)
```
