---
layout: post
title: "R - draw Tendril plots with the <em>Tendril</em> package"
date: 2020-05-30
category: R
tags: R function visualization plot package
---

https://cran.r-project.org/web/packages/Tendril/vignettes/TendrilUsage.html


http://notabilia.net/


The Tendril package contains functions designed to compute the x-y coordinates and to build a Tendril plot. Inspired by the notabilia visualization, the Tendril plot was developed to capture the relative effect of different kind of adverse events for two treatments, including temporal aspects, in a single visualization. Specifically, each tendril (branch) in the Tendril plot represents a type of adverse effect, and the direction of the tendril is dictated by on which treatment arm the event is occurring. If an event is occurring on the first of the two specified treatment arms, the tendril bends clockwise (to the right). If an event is occurring on the second of the treatment arms, the tendril bends anti-clockwise (to the left).

```
library(Tendril)

data("TendrilData")

test <- Tendril(mydata = TendrilData,
                rotations = Rotations,
                AEfreqThreshold = 9,
                Tag = "Comment",
                Treatments = c("placebo", "active"),
                Unique.Subject.Identifier = "subjid",
                Terms = "ae",
                Treat = "treatment",
                StartDay = "day",
                SubjList = SubjList,
                SubjList.subject = "subjid",
                SubjList.treatment = "treatment"
)
  
plot(test)
```
