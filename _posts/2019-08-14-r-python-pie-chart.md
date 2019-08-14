---
layout: post
title: "Pie charts with <em>ggplot</em> in R and <em>pd.plot</em> in Python"
date: 2019-08-14
category: R
tags: R function python plots 
---

* <em>coord_polar()</em> to plot pies with <em>ggplot()</em> in R

``` 
df <- data.frame(
  variable = c("Yet to eat", "Eaten"),
  value = c(20, 80)
)
	
ggplot(df, aes(x = "", y = value, fill = variable)) +
  geom_col(width = 2) +
  scale_fill_manual(values = c("grey", "blue")) +
  coord_polar("y", start = pi / 3) +
  labs(title = "Happy Pi(e) Day")
``` 

* <em>pandas.plot()</em> with argument <em>kind="pie"</em> in Python

```
df = pd.DataFrame([8,2], 
        index=['Eaten', 'To Be Eaten'], 
        columns=['x'])
df.plot(kind='pie', subplots=True, figsize=(6, 6))
```
