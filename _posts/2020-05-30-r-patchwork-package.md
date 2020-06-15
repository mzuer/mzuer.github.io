---
layout: post
title: "R - <em>patchwork</em>: package for assembling ggplots"
date: 2020-05-30
category: R
tags: R ggplot2 package plots visualization
---

<em>patchwork</em>: nice package for assembling plots from ggplot2

https://github.com/thomasp85/patchwork
https://www.r-bloggers.com/patchwork-r-package-goes-nerd-viral/


```
p1 + p2
```


Can also combine ggplots and base plots: https://patchwork.data-imaginist.com/articles/guides/assembly.html

```
p1 + ~plot(mtcars$mpg, mtcars$disp, main = 'Plot 2')
```
