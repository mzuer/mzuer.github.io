---
layout: post
title: "R - <em>YaRrr</em> package: colors in R and <em>transparent()</em>"
date: 2020-05-30
category: R
tags: R colors package function visualization
---

https://bookdown.org/ndphillips/YaRrr/colors.html

Nice for use of transparent with <em>transparent()</em>:


``` 
plot(x = pirates$height, 
     y = pirates$weight, 
     col = yarrr::transparent("blue", trans.val = .9), 
     pch = 16, 
     main = "col = yarrr::transparent('blue', .9)")
```
