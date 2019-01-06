---
layout: post
title: "Python - <em>pandas</em>: select row(s) of a DataFrame based on a pattern matching using <em>str.contains()</em>"
date: 2018-01-05
category: python
tags: [python, pandas, dataframe]
---


```
import pandas as pd

df = pd.read_csv("https://github.com/selva86/datasets/raw/master/mtcars.csv")

# change 'colors' value only for the rows for which the value in 'cars' column match the pattern "Fiat"
df.loc[df['cars'].str.contains("Fiat"), 'colors'] = "darkorange"


# pattern matching:
df.loc[df['cars'].str.contains("Fiat"), ['colors', 'carname']]
#         colors    carname
# 17  darkorange   Fiat 128
# 25  darkorange  Fiat X1-9

# exact matching
df.loc[df['cars'] == "Fiat X1-9", ['colors', 'carname']]
#        colors    carname
# 25  darkorange  Fiat X1-9

```
