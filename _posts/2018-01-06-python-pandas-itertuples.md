---
layout: post
title: "Python - <em>pandas</em>: iterate over DataFrame with <em>itertuples()</em>"
date: 2018-01-06
category: python
tags: [python, pandas, dataframe]
---


Iterate over DataFrame rows as namedtuples, with index value as first element of the tuple

Arguments:


- index : boolean, default True
    If True, return the index as the first element of the tuple.


- name : string, default "Pandas"
    The name of the returned namedtuples or None to return regular tuples.


```
import pandas as pd

df = pd.read_csv("https://github.com/selva86/datasets/raw/master/mtcars.csv")

df = df[['cars','mpg']]

df.head()
#                 cars       mpg
# 0          Mazda RX4  4.582576
# 1      Mazda RX4 Wag  4.582576

# for row in df.itertuples(index=True, name="Pandas"):
# same as:
for row in df.itertuples():
    print(str(row[0]) + " - " + str(row.cars) + " - " + str(row.mpg))
# 0 - Mazda RX4 - 4.58257569495584
# 1 - Mazda RX4 Wag - 4.58257569495584

for row in df.itertuples():
    print(type(row))
# <class 'pandas.core.frame.Pandas'>
# <class 'pandas.core.frame.Pandas'>

```
