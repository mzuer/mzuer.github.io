---
layout: post
title: "Python - <em>pandas</em> basics"
date: 2018-12-28
category: python
tags: python pandas dataframe
---

Some pandas basics: 

row/column names (<em>shape</em>, <em>index</em>, <em>values</em>)

selection of rows/columns (<em>loc</em>, <em>iloc</em>)

aggregation (<em>groupby</em>, <em>get_group</em>)


```
import pandas as pd

# create a dictionary of series

#Create a Dictionary of series
d = {'Name':pd.Series(['Tom','James','Ricky','Vin','Steve','Smith','Jack']),
   'Age':pd.Series([25,26,25,23,30,29,23]),
   'Rating':pd.Series([4.23,3.24,3.98,2.56,3.20,4.6,3.8])}

#Create a DataFrame
df = pd.DataFrame(d)

# Show head or tail
df.head()

df.tail()

# get the number of rows
df.shape[0]

# of columns
df.shape[1]

# get the column names
list(df.columns)
# df.column returns an object "Index"
list(df.columns.values)
# df.column.values returns an object "array"

# get the row names
list(df.index)
# same as:
df.index.tolist()
# df.index returns a RangeIndex
list(df.index.values)
# df.index.values returns an object "array"

# get row names
df.axes[0].tolist()
df.axes[1].tolist()

# selection of the first 3 rows by index
df.iloc[0:3,:]

# selection of the first 3 rows by row names
df.loc[[0,1,2]]
# -> df[['a','b']] produces a copy

# selection of the 2nd column
df.iloc[:,2]
df[df.columns[2]]
df["Rating"]
df.loc[:,"Rating"]

# selection of the 2nd row
df.iloc[2,:]
df.loc[2,:] # -> pandas.core.series.Series
df.loc[[2]] # -> pandas.core.frame.DataFrame

# selection of the first 2 columns by index
df.iloc[:,0:2]

# selection of the first 2 column by column names
df.loc[:,["Age", "Name"]]

# select by criterion
df[df['Age'] == 25]
# can be written as:
df.query('Age == 25')


# select rows and columns
df[df['Age'] == 25].loc[:,['Age', 'Rating']]
df.query('Age > 25').iloc[:,0:4]

# group different variables
df[["Age", "Rating"]].mean()


import numpy as np
df2 = pd.DataFrame({'A' : ['foo', 'bar', 'foo', 'bar', 'foo', 'bar', 'foo', 'foo'],
                    'B' : ['one', 'one', 'two', 'three','two', 'two', 'one', 'three'],
                    'C' : np.random.randn(8),
                    'D' : np.random.randn(8)})

df2.groupby('A').mean()
#             C         D
# A
# bar -0.249526  0.075070
# foo  0.431255  0.193288
df2.groupby(['A', 'B']).mean()
#                   C         D
# A   B
# bar one    1.505002  0.404338
#     three -0.905634 -0.766677
#     two   -1.347947  0.587548
# foo one    0.244685 -0.472473
#     three -0.113079  1.228466
#     two    0.889992  0.341460
df2.groupby(['A']).get_group('bar')


```



