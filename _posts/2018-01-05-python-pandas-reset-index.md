---
layout: post
title: "Python - <em>pandas</em>: DataFrame index and <em>reset_index()</em>"
date: 2018-01-05
category: python
tags: [python, pandas, dataframe]
---


Use <em>reset_index()</em> on DataFrame: returns new DataFrame with labeling information in the columns under the index names

See <a href="https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.reset\_index.html">https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.reset_index.html</a>


Can be useful e.g. when creating a new dataframe by selecting the rows from another dataframe, causing some of the indices to be out of order. 
By using <em>reset_index()</em> it will set the indices in order, starting from 0, and make it easier for us to work with the dataframe.
Or when was changed to other values from integers, use <em>reset_index()</em> to convert back to integers.
(<a href="https://discuss.codecademy.com/t/when-should-i-use-reset-index-in-pandas/354480">https://discuss.codecademy.com/t/when-should-i-use-reset-index-in-pandas/354480</a>

```
import pandas as pd
import numpy as np

df = pd.DataFrame([('bird',    389.0),
                    ('bird',     24.0),
                    ('mammal',   80.5),
                    ('mammal', np.nan)],
                   index=['falcon', 'parrot', 'lion', 'monkey'],
                   columns=('class', 'max_speed'))
df
#         class  max_speed
# falcon    bird      389.0
# parrot    bird       24.0
# lion    mammal       80.5
# monkey  mammal        NaN


df.loc['falcon',:]
# class        bird
# max_speed     389
# Name: falcon, dtype: object

df.index
# Index(['falcon', 'parrot', 'lion', 'monkey'], dtype='object')
```
