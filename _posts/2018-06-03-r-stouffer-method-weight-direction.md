---
layout: post
title: "R - implementation Stouffer's method with weight and direction'"
date: 2018-06-03
category: R
tags: R statistics
---

Implementation of Stouffer's method with weight and direction

```
signed.Stouffer.meta <- function(p, w, sign) { # p is a vector of p-values
  if (missing(w)) {
    w <- rep(1, length(p))/length(p)
  } else {
    if (length(w) != length(p))
      stop("Length of p and w must equal!")
  }
  if(length(p)==1) Zi1)
  {
  Zi<-qnorm(p/2,lower.tail=FALSE) 
  Zi[sign<0]<-(-Zi[sign<0])
  }
  Z  <- sum(w*Zi)/sqrt(sum(w^2))
  p.val <- 2*(1-pnorm(abs(Z)))
  return(c(Z = Z, p.value = p.val))
}
```
source: https://www.r-bloggers.com/stouffers-meta-analysis-with-weight-and-direction-effect-in-r/


