---
layout: post
title: "R - <em>eval()</em> and <em>bquote()</em> to call <em>lm()</em> with named variables"
date: 2019-08-14
category: R
tags: R function 
---


```
d <- data.frame(
  x1 = c(1, 2, 3, 4), 
  x2 = c(0, 0, 1, 1),
  y = c(3, 3, 4, -5), 
  wt = c(1, 2, 1, 1))

outcome_name <- "y"
explanatory_vars <- c("x1", "x2")  
name_for_weight_column <- "wt"

formula_str <- paste(outcome_name, "~", paste(explanatory_vars, collapse = " + "))
#[1] "y ~ x1 + x2"

eval(bquote(lm(formula_str, data = d, weights = .(as.name(name_for_weight_column)))))
```

See also:

<a href="http://www.win-vector.com/blog/2019/07/programming-over-lm-in-r">http://www.win-vector.com/blog/2019/07/programming-over-lm-in-r</a>
