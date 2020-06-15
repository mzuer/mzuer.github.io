---
layout: post
title: "R - generate gallery of ggplot2 themes"
date: 2020-05-30
category: R
tags: R visualization plots ggplot2
---

Post with code to generate gallery of ggplot2 themes (can also directly see them there)

https://martinctc.github.io/blog/vignette-generate-your-own-ggplot-theme-gallery/

```
theme_list <-
  list("ggplot2::theme_minimal()" = theme_minimal(),
       "ggplot2::theme_classic()" = theme_classic(),
       "ggplot2::theme_bw()" = theme_bw(),
       "ggplot2::theme_gray()" = theme_gray(),
       "ggplot2::theme_linedraw()" = theme_linedraw(),
       "ggplot2::theme_light()" = theme_light(),
       "ggplot2::theme_dark()" = theme_dark(),
       "ggthemes::theme_economist()" = ggthemes::theme_economist(),
       "ggthemes::theme_economist_white()" = ggthemes::theme_economist_white(),
       "ggthemes::theme_calc()" = ggthemes::theme_calc(),
       "ggthemes::theme_clean()" = ggthemes::theme_clean(),
       "ggthemes::theme_excel()" = ggthemes::theme_excel(),
       "ggthemes::theme_excel_new()" = ggthemes::theme_excel_new(),
       "ggthemes::theme_few()" = ggthemes::theme_few(),
       "ggthemes::theme_fivethirtyeight()" = ggthemes::theme_fivethirtyeight(),
       "ggthemes::theme_foundation()" = ggthemes::theme_foundation(),
       "ggthemes::theme_gdocs()" = ggthemes::theme_gdocs(),
       "ggthemes::theme_hc()" = ggthemes::theme_hc(),
       "ggthemes::theme_igray()" = ggthemes::theme_igray(),
       "ggthemes::theme_solarized()" = ggthemes::theme_solarized(),
       "ggthemes::theme_solarized_2()" = ggthemes::theme_solarized_2(),
       "ggthemes::theme_solid()" = ggthemes::theme_solid(),
       "ggthemes::theme_stata()" = ggthemes::theme_stata(),
       "ggthemes::theme_tufte()" = ggthemes::theme_tufte(),
       "ggthemes::theme_wsj()" = ggthemes::theme_wsj())
```
