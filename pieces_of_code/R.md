---
layout: default
title: "Pieces of code - R"
---


### Theme for ggplot2

```{r}

theme(
	axis.legend = ()
)

``` 

### Density plot

```{r}

densplot <- function(x,y, pch=19, cex=1, ...){
	df <- data.frame(x,y)
	d <- densCols(x,y, colramp=colorRampPalette(c("black", "white")))
	df$dens <- col2rgb(d)[1,] + 1L
	cols <- colorRampPalette(c("#000099", "#00FEFF", "#45FE4F","#FCFF00", "#FF9400", "#FF3100"))(256)
	df$col <- cols[df$dens]
	df <- df[order(df$dens),]
	plot(df$x,df$y, pch=pch, col=df$col, ...)
}


``` 

### Multiple density curves

```{r}

plot_multiDens <- function(size_list, plotTit="", legTxt=NULL, legPos="topright", my_ylab="density", my_xlab="") {
  dens <- lapply(size_list, function(x) density(na.omit(x)))
  names(dens) <- names(size_list)
  
  lengthDens <- unlist(lapply(size_list, function(x) length(na.omit(x))))
  
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), 
       main=plotTit, xlab=my_xlab, ylab=my_ylab)
  foo <- mapply(lines, dens, col=1:length(dens))
  if(is.null(legTxt)){
    # legTxt <- names(dens)
    legTxt <- paste0(names(dens), " (n=", lengthDens, ")")
  }
  legend(legPos, legend=legTxt, fill=1:length(dens), bty='n')
}
``` 

### Print text and write to log file

```{r}
printAndLog <- function(txt, logFile=""){
  cat(txt)
  cat(txt, file = logFile, append=T)
}
``` 


### Add correlation to plot

```{r}

addCorr <- function(x, y, legPos="topright", corMet="pearson", ...) {
  corMet <- tolower(corMet)
  stopifnot(corMet %in% c("pearson", "kendall", "spearman"))
  x_new <- x[!is.na(x) & !is.na(y)]
  y_new <- y[!is.na(x) & !is.na(y)]
  x <- x_new
  y <- y_new
  stopifnot(length(x) == length(y))

  if(length(x) < 3) {
    legTxt <- paste0(paste0(toupper(substr(corMet,1,1)), "CC"), " = NA", "\n", "(# obs. < 3)")
  } else {
    ct <- cor.test(x,y, method = corMet)
    corCoeff <- ct$estimate
    corPval <- ct$p.value
    legTxt <- paste0(paste0(toupper(substr(corMet,1,1)), "CC"), " = ", round(corCoeff, 4), "\n", "(p-val = ", sprintf("%2.2e", corPval), ")")
  }
  legend(legPos, legend = legTxt, ...)
}

``` 
### Add fitted curve

```{r}

add_curv_fit <- function(x, y, withR2 = TRUE, R2shiftX = 0, R2shiftY = 0,...) {
  mymodel <- lm(y~x)
  abline(mymodel, ...)
  if(withR2) {
    r2Txt <- paste0("adj. R2 = ", sprintf("%.2f", summary(mymodel)$adj.r.squared))
    r2X <- x[which.min(x)] + R2shiftX
    r2Y <- fitted(mymodel)[which.min(x)]
    text(x = r2X, y = r2Y, 
         labels = r2Txt, 
         adj=c(1,0),
         pos=3,
         cex = 0.7)
  }
}
``` 




