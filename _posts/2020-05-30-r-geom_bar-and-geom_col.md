---
layout: post
title: "R - difference between <em>geom_bar()</em> and <em>geom_col()</em> in <em>ggplot2</em>"
date: 2020-05-30
category: R
tags: R visualization ggplot2 plot function
---

https://sebastiansauer.github.io/two_ways_barplots_with_ggplot2/

There are two types of bar charts: <em>geom_bar()</em> and <em>geom_col()</em>. <em>geom_bar()</em> makes the height of the bar proportional to the number of cases in each group (or if the weight aesthetic is supplied, the sum of the weights). If you want the heights of the bars to represent values in the data, use <em>geom_col()</em> instead. 

<em>geom_bar()</em> uses <em>stat_count()</em> by default: it counts the number of cases at each x position. 



in effect, <em>geom_col(...)</em> is <em>geom_bar(stat = "identity")</em>

