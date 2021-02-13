---
layout: post
title: "R - plot overlaying points (<em>sunflowerplot()</em>, <em>jitter()</em> and transparency)"
date: 2021-02-10
category: R
tags: R function plot base 
---

tips for plotting overlaying points:

When given (x, y) values, sunflowerplot counts the number of times each (x, y) value appears to determine the number of petals it needs to draw. It is possible to override this behavior by passing a number argument, as the next code snippet shows:

```
set.seed(1)
sunflowerplot(1:10, 1:10, number = 1:10,
              main = "n observations at (n, n)")
```

Another common technique is jittering, where random noise is added to each point.

```
set.seed(1)
plot(jitter(mtcars$gear), jitter(mtcars$carb),
     main = "Plot of carb vs. gear")
```

Sunflower plots will not solve all your overplotting issues. Here is an example (on the diamonds dataset) where it does a horrendous job:

```
library(ggplot2)
data(diamonds)
sunflowerplot(diamonds$carat, diamonds$price,
              main = "Plot of price vs. carat")
```

A better solution here would be to change the transparency of the points. The code snippet below shows how this can be done in base R:

```
plot(diamonds$carat, diamonds$price,
     col = rgb(0, 0, 0, alpha = 0.05),
     main = "Plot of price vs. carat")
```

source: https://statisticaloddsandends.wordpress.com/2021/02/05/what-is-a-sunflower-plot/



