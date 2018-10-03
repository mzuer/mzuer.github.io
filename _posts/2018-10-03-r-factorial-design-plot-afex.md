---
layout: post
title: "R - factorial design plot with <em>afex_plot()</em> from <em>afex</em> package"
date: 2018-10-03
category: R
tags: [R plot package function ggplot2]
---

Publication-ready plots for factorial designs


```
library("afex")         # requires ggpol package
library("ggplot2") 

data(md_12.1)
# afex::aov_ez() -> convenient ANOVA estimation for factorial designs
aw <- aov_ez("id", "rt", md_12.1, within = c("angle", "noise"))

afex_plot(aw, x = "angle", trace = "noise", error = "within",
          mapping = c("shape", "fill"), dodge = 0.7,
          data_geom = ggpol::geom_boxjitter, 
          data_arg = list(
            width = 0.5, 
            jitter.width = 0,
            jitter.height = 10,
            outlier.intersect = TRUE),
          point_arg = list(size = 2.5), 
          error_arg = list(size = 1.5, width = 0),
          factor_levels = list(angle = c("0°", "4°", "8°"),
                               noise = c("Absent", "Present")), 
          legend_title = "Noise") +
  labs(y = "RTs (in ms)", x = "Angle (in degrees)") +
  scale_y_continuous(breaks=seq(400, 900, length.out = 3)) +
  theme_bw(base_size = 15) + 
  theme(legend.position="bottom", panel.grid.major.x = element_blank())
```

