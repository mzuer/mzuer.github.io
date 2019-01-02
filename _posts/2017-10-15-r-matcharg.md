---
layout: post
title: "R - <em>match.arg()</em>: save output into file"
date: 2017-10-15
category: R
tags: [R, function]
---

<em>match.arg(arg, choices, several.ok = FALSE)</em> matches <em>arg</em> against a table of candidate values as specified by <em>choices</em>, where NULL means to take the first one.

In the example below:
<ul>
<li> type store the argument passed in parameter ("mean", "median", "trimmed") </li>
<li> the argument passed should be one of “mean”, “median”, “trimmed” </li>
</ul>
```
center <- function(x, type = c("mean", "median", "trimmed")) {
  type <- match.arg(type)
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = .1))
}

```
