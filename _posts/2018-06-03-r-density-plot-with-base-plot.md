---
layout: post
title: "R - density plot with R basic <em>plot</em>, <em>colorRampPalette</em>, <em>densCols</em> functions"
date: 2018-06-03
category: R
tags: [R plot]
---

Function to create density plot with R basic plot:


(use the following functions: <em>plot</em>, <em>colorRampPalette</em>, <em>densCols</em>)

```
densplot <- function(x,y, pch=19, cex=1){
	df <- data.frame(x,y)
	d <- densCols(x,y, colramp=colorRampPalette(c("black", "white")))
	df$dens <- col2rgb(d)[1,] + 1L
	cols <- colorRampPalette(c("#000099", "#00FEFF", "#45FE4F","#FCFF00", "#FF9400", "#FF3100"))(256)
	df$col <- cols[df$dens]
	df <- df[order(df$dens),]
	plot(df$x,df$y, pch=pch, col=df$col)
}

```
