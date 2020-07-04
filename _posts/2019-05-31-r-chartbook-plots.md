---
layout: post
title: "R - plots (interactive charts) with <em>chartbookR</em> package"
date: 2019-05-31
category: R
tags: R function package plot
---


https://www.r-bloggers.com/introduction-to-chartbookr-2


https://kilianreber.netlify.com/post/interactive-charts-with-chartbookr



```
# Create a simple line plot 
# To plot the rebased indices in columns 4 to 6, use:

LineChart(zoo, d1=4:6)


# We can easily produce a more sophisticated chart instead by including a title, grid lines, recession shading, and a horizontal line at 100. 
# You can add a title by specifying title="The Decline of US Manufacturing Employment (indexed, 1987=100)". 
# Grid lines are added by specifying grid=TRUE, recession shading is added with rec=TRUE.
# Finally, add a figure number by adding no=1 and a more granular y-axis by specifying y1_def=c(50,250,25):

LineChart(zoo, d1=4:6, no=1, 
         title="The Decline of US Manufacturing Employment (indexed, 1987=100)", 
        y1_def=c(50,250,25), grid=TRUE, rec=TRUE)

```
