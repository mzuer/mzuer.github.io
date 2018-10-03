---
layout: post
title: "R - <em>ggpol</em> package, parliament diagram and other extensions of <em>ggplot2</em> (e.g. mix box/scatterplots) "
date: 2018-10-03
category: R
tags: [R plot package function ggplot2]
---


Example of parliament diagram using <em>geom_parliament()</em>:


```
library(ggplot2)
library(ggpol)

bt <- data.frame(
 parties = factor(c("CDU", "CSU", "AfD", "FDP", "SPD", 
                    "Linke", "Gruene", "Fraktionslos"),
                  levels = c("CDU", "CSU", "AfD", "FDP", "SPD", 
                             "Linke", "Gruene", "Fraktionslos")),
 seats   = c(200, 46, 92, 80, 153, 69, 67, 2),
 colors  = c("black", "blue", "lightblue", "yellow", 
             "red","purple", "green", "grey"),
 stringsAsFactors = FALSE)

ggplot(bt) + 
  geom_parliament(aes(seats = seats, fill = parties), color = "black") + 
  scale_fill_manual(values = bt$colors, labels = bt$parties) +
  coord_fixed() + 
  theme_void()
```



Hybrid boxplot-scatterplot using <em>geom_boxjitter()</em>:


```
library(ggplot2)
library(ggpol)

df <- data.frame(score = rgamma(150, 4, 1), 
                 gender = sample(c("M", "F"), 150, replace = TRUE), 
                genotype = factor(sample(1:3, 150, replace = TRUE)))

ggplot(df) + geom_boxjitter(aes(x = genotype, y = score, fill = gender),
                            jitter.shape = 21, jitter.color = NA, 
                            jitter.height = 0, jitter.width = 0.04,
                            outlier.color = NA, errorbar.draw = TRUE) +
  scale_fill_manual(values = c("#ecb21e", "#812e91")) +
  theme_minimal()
```


Other examples in the <a href="https://erocoar.github.io/ggpol/">vignette</a>:

- <em>geom_arcbar()</em>: arc bar diagrams that span 180 degrees.
- <em>geom_bartext()</em>: unstacking overlapping text-labels in barcharts.
- <em>geom_parliament()</em>: plot parliament diagrams.
- <em>geom_circle()</em>: plot circle-polygons with a specified radius.
- <em>geom_tshighlight()</em>: highlight rectangle in timeseries (wrapper for geom_rect with ymin and ymax).
- <em>geom_boxjitter()</em>: plot a hybrid half boxplot/half scatterplot, with optional errorbars.
- <em>facet_share()</em>: two panels face-to-face with with basic shared axes.
