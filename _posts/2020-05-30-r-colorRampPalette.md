---
layout: post
title: "R - <em>colorRampPalette()</em>: create palette and assign colors for a vector of continuous values"
date: 2020-05-30
category: R
tags: R function colors palettes visualization
---

<em>colorRampPalette()</em> 

Define the colors for a continuous vector according to a palette


```
rbPal <- colorRampPalette(c('red','blue'))
meancolPlot_dt$dotCols <- rev(rbPal(10))[as.numeric(cut(meancolPlot_dt$meanCorr,breaks = 10))]
  


#Some sample data
x <- runif(100)
dat <- data.frame(x = x,y = x^2 + 1)

#Create a function to generate a continuous color palette
rbPal <- colorRampPalette(c('red','blue'))

#This adds a column of color values
# based on the y values
dat$Col <- rbPal(10)[as.numeric(cut(dat$y,breaks = 10))]

plot(dat$x,dat$y,pch = 20,col = dat$Col)

```


