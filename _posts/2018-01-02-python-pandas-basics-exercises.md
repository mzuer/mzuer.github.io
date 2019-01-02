---
layout: post
title: "Python - <em>pandas</em> basics exercises"
date: 2018-01-02
category: python
tags: [python, pandas, dataframe]
---

Taken from:

<a href="https://www.machinelearningplus.com/python/101-pandas-exercises-python">https://www.machinelearningplus.com/python/101-pandas-exercises-python</a>

```
import numpy as np

# 1. How to import pandas and check the version?
import pandas as pd
print(pd.__version__)
print(pd.show_versions(as_json=True))

# 2. How to create a series from a list, numpy array and dict?
# Create a pandas series from each of the items below: a list, numpy and a dictionary
mylist = list('abcedfghijklmnopqrstuvwxyz')
myarr = np.arange(26)
mydict = dict(zip(mylist, myarr))

series_list = pd.Series(mylist)
print(series_list.head())
series_array = pd.Series(myarr)
print(series_array.head())
series_dict= pd.Series(mydict)
print(series_dict.head())

# 3. How to convert the index of a series into a column of a dataframe?
# Convert the series ser into a dataframe with its index as another column on the dataframe.

ser = pd.Series(mydict)
df = ser.to_frame().reset_index()
print(df.head())

# 4. How to combine many series to form a dataframe?
# Combine ser1 and ser2 to form a dataframe.

ser1 = pd.Series(list('abcedfghijklmnopqrstuvwxyz'))
ser2 = pd.Series(np.arange(26))

# -> using concat()
df_v1 = pd.concat([ser1, ser2])
print(df_v1.head())

# -> using DataFrame constructor with dictionary
df_v2 = pd.DataFrame({'col1': ser1, 'col2': ser2})
print(df_v2.head())


# 5. How to assign name to the series’ index?
# Give a name to the series ser calling it ‘alphabets’.
ser = pd.Series(list('abcedfghijklmnopqrstuvwxyz'))
ser.name = 'alphabets'
print(ser.head())

# 6. How to get the items of series A not present in series B?
# From ser1 remove items present in ser2.

ser1 = pd.Series([1, 2, 3, 4, 5])
ser2 = pd.Series([4, 5, 6, 7, 8])

# tilde to revert numpy.bool_
ser1[~ser1.isin(ser2)]

# 7. How to get the items not common to both series A and series B?
# Get all items of ser1 and ser2 not common to both.

ser1 = pd.Series([1, 2, 3, 4, 5])
ser2 = pd.Series([4, 5, 6, 7, 8])

# v1: using difference between union and intersect
ser_u = pd.Series(np.union1d(ser1,ser2))
ser_i = pd.Series(np.intersect1d(ser1,ser2))
ser_u[~ser_u.isin(ser_i)]

# v2: using setdiff
pd.Series(np.append(np.setdiff1d(ser1,ser2), np.setdiff1d(ser2,ser1)))

# 8. How to get the minimum, 25th percentile, median, 75th, and max of a numeric series?
# Compute the minimum, 25th percentile, median, 75th, and maximum of ser.

state = np.random.RandomState(100)
ser = pd.Series(state.normal(10, 5, 25))
np.percentile(ser, q=[0, 25, 50, 75, 100])

# 9. How to get frequency counts of unique items of a series?
# Calculte the frequency counts of each unique value ser.

ser = pd.Series(np.take(list('abcdefgh'), np.random.randint(8, size=30)))
ser.value_counts()

# 10. How to keep only top 2 most frequent values as it is and replace everything else as ‘Other’?
# From ser, keep the top 2 most frequent items as it is and replace everything else as ‘Other’.

np.random.RandomState(100)
ser = pd.Series(np.random.randint(1, 5, [12]))
two_most_freq = ser.value_counts().index[:2]

ser[~ser.isin(two_most_freq)] = "Other"

# 11. How to bin a numeric series to 10 groups of equal size?
# Bin the series ser into 10 equal deciles and replace the values with the bin name.

ser = pd.Series(np.random.random(20))
print(ser.head())

ser_binned = pd.qcut(ser,
        q=[0, .10, .20, .3, .4, .5, .6, .7, .8, .9, 1],
        labels=['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th'])
print(ser_binned.head())


# 12. How to convert a numpy array to a dataframe of given shape? (L1)
# Reshape the series ser into a dataframe with 7 rows and 5 columns

ser = pd.Series(np.random.randint(1, 10, 35))
df = pd.DataFrame(ser.values.reshape(7,5))
print(df)

# 13. How to find the positions of numbers that are multiples of 3 from a series?
# Find the positions of numbers that are multiples of 3 from ser.

ser = pd.Series(np.random.randint(1, 10, 7))
np.argwhere(ser % 3 == 0)

# 14. How to extract items at given positions from a series
# From ser, extract the items at positions in list pos.

ser = pd.Series(list('abcdefghijklmnopqrstuvwxyz'))
pos = [0, 4, 8, 14, 20]

ser.take(pos)

# 15. How to stack two series vertically and horizontally ?
# Stack ser1 and ser2 vertically and horizontally (to form a dataframe).

ser1 = pd.Series(range(5))
ser2 = pd.Series(list('abcde'))

# vertical
df_vert = ser1.append(ser2)
print(df_vert)
# can also be done with concat()
df_vert2 = pd.concat([ser1,ser2], axis=0)
print(df_vert)

# horizontal
df_horiz = pd.concat([ser1,ser2], axis=1)

# 16. How to get the positions of items of series A in another series B?
# Get the positions of items of ser2 in ser1 as a list.

ser1 = pd.Series([10, 9, 6, 5, 3, 1, 12, 8, 13])
ser2 = pd.Series([1, 3, 10, 13])

# version 1
match_idx1 = [np.where(i == ser1)[0].tolist()[0] for i in ser2]
# -> np.where(1 == ser1)
# Out[86]: (array([5]),)
# -> np.where(1 == ser1)[0]
# Out[86]: array([5])
# -> np.where(1 == ser1)[0].tolist()
# Out[86]: [5]
# -> np.where(1 == ser1)[0].tolist()[0
# Out[86]: 5

# version 2
match_idx2 = [pd.Index(ser1).get_loc(i) for i in ser2]


# 17. How to compute the mean squared error on a truth and predicted series?
# Compute the mean squared error of truth and pred series.

truth = pd.Series(range(10))
pred = pd.Series(range(10)) + np.random.random(10)

np.mean((truth-pred)**2)
# same as
pd.Series((truth-pred)**2).mean()

18. How to convert the first character of each element in a series to uppercase?
Change the first character of each word to upper case in each word of ser.

ser = pd.Series(['how', 'to', 'kick', 'ass?'])

# version 1
ser.map(lambda x: x.title())

# version 2
ser.map(lambda x: x[0].upper() + x[1:])

# version 3
pd.Series(i.title() for i in ser)


19. How to calculate the number of characters in each word in a series?
ser = pd.Series(['how', 'to', 'kick', 'ass?'])

ser.map(lambda x: len(x))
pd.Series(len(i) for i in ser)


# 20. How to compute difference of differences between consequtive numbers of a series?
# Difference of differences between the consequtive numbers of ser.

ser = pd.Series([1, 3, 6, 10, 15, 21, 27, 35])

print(ser.diff().tolist())
print(ser.diff().diff().tolist())

# 21. How to convert a series of date-strings to a timeseries?

ser = pd.Series(['01 Jan 2010', '02-02-2011', '20120303', '2013/04/04', '2014-05-05', '2015-06-06T12:20'])

# version 1
from dateutil.parser import parse
ser.map(lambda x: parse(x))

# version 2
pd.to_datetime(ser)

# Desired Output
# 0   2010-01-01 00:00:00
# 1   2011-02-02 00:00:00
# ...

# 22. How to get the day of month, week number, day of year and day of week from a series of date strings?
# Get the day of month, week number, day of year and day of week from ser.

ser = pd.Series(['01 Jan 2010', '02-02-2011', '20120303', '2013/04/04', '2014-05-05', '2015-06-06T12:20'])

from dateutil.parser import parse
ser_ts = ser.map(lambda x: parse(x)) # same as: pd.to_datetime(ser)

# day of month
print("Date: ", ser_ts.dt.day.tolist())

# week number
print("Week number: ", ser_ts.dt.weekofyear.tolist())

# day of year
print("Day number of year: ", ser_ts.dt.dayofyear.tolist())

# day of week
print("Day of week: ", ser_ts.dt.weekday_name.tolist())


# 23. How to convert year-month string to dates corresponding to the 4th day of the month?
# Change ser to dates that start with 4th of the respective months.

ser = pd.Series(['Jan 2010', 'Feb 2011', 'Mar 2012'])

# version 1
from dateutil.parser import parse
ser_ts = ser.map(lambda x: parse(x))

# Construct date string with date as 4
ser_datestr = ser_ts.dt.year.astype('str') + '-' + ser_ts.dt.month.astype('str') + '-' + '04'

# Format it.
[parse(i).strftime('%Y-%m-%d') for i in ser_datestr]

# version 2
ser.map(lambda x: parse('04 ' + x))


# 24. How to filter words that contain atleast 2 vowels from a series?
# From ser, extract words that contain atleast 2 vowels.

ser = pd.Series(['Apple', 'Orange', 'Plan', 'Python', 'Money'])


from collections import Counter
# use get(i,0) => allows to specify default values => .get(key, default)
mask = ser.map(lambda x: sum([Counter(x.lower()).get(i, 0) for i in list('aeiou')]) >= 2)
# mask contains indicating if it matches the criteria
# same as
# mask = [ sum([Counter(x.lower()).get(i, 0) for i in list('aeiou')]) >= 2 for x in ser.tolist()]
# or same as
# mask = ser.map(lambda x: sum([Counter(x.lower())[i] for i in list('aeiou')]) >= 2)
ser[mask]


# 25. How to filter valid emails from a series?
# Extract the valid emails from the series emails. The regex pattern for valid emails is provided as reference.

emails = pd.Series(['buying books at amazom.com', 'rameses@egypt.com', 'matt@t.co', 'narendra@modi.com'])
pattern ='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}'

# version 1 - as a series of strings
import re
mask = emails.map(lambda x: bool(re.match(pattern, x)))
print(emails[mask])
mask = [bool(re.match(pattern, x)) for x in emails.tolist()]
print(emails[mask])

# version 2 (as series of list)
emails.str.findall(pattern, flags=re.IGNORECASE) # pandas.Series.str.findall function

# version 3 (as list)
[x[0] for x in [re.findall(pattern, email) for email in emails] if len(x) > 0]
# re.findall(pattern, emails[0])
# Out[180]: []
# re.findall(pattern, emails[1])
# Out[181]: ['rameses@egypt.com']


# 26. How to get the mean of a series grouped by another series?
# Compute the mean of weights of each fruit.
fruits = pd.Series(np.random.choice(['apple', 'banana', 'carrot'], 10))
weights = pd.Series(np.linspace(1, 10, 10))
print(weights.tolist())
print(fruits.tolist())

weights.groupby(fruits).mean()

# 27. How to compute the euclidean distance between two series?
# Compute the euclidean distance between series (points) p and q, without using a packaged formula.

p = pd.Series([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
q = pd.Series([10, 9, 8, 7, 6, 5, 4, 3, 2, 1])

sum((p-q)**2)**0.5

# using numpy function
np.linalg.norm(p-q)

# 28. How to find all the local maxima (or peaks) in a numeric series?
# Get the positions of peaks (values surrounded by smaller values on both sides) in ser.

ser = pd.Series([2, 10, 3, 4, 9, 10, 2, 7, 3])

dd = np.diff(np.sign(np.diff(ser)))
peak_locs = np.where(dd == -2)[0] + 1
peak_locs

# 29. How to replace missing spaces in a string with the least frequent character?
# Replace the spaces in my_str with the least frequent character.

my_str = 'dbc deb abed gade'
# least frequent character
mystr = pd.Series(list(my_str))
all_freq = mystr.value_counts()
least_freq = all_freq.dropna().index[-1]
"".join(mystr.replace(' ', least_freq))

# 30. How to create a TimeSeries starting ‘2000-01-01’ and 10 weekends (saturdays) after that having random numbers as values?

ser = pd.Series(np.random.randint(1,10,10), pd.date_range('2000-01-01', periods=10, freq='W-SAT'))
ser

# 31. How to fill an intermittent time series so all missing dates show up with values of previous non-missing date?
# ser has missing dates and values. Make all missing dates appear and fill up with value from previous date.

ser = pd.Series([1,10,3,np.nan], index=pd.to_datetime(['2000-01-01', '2000-01-03', '2000-01-06', '2000-01-08']))

# version 1
ser.resample('D').ffill()  # fill with previous value

# can also be done like that:
ser.resample('D').bfill()  # fill with next value
ser.resample('D').bfill().ffill()  # fill next else prev value


# 32. How to compute the autocorrelations of a numeric series?
# Compute autocorrelations for the first 10 lags of ser. Find out which lag has the largest correlation.

ser = pd.Series(np.arange(20) + np.random.normal(1, 10, 20))

autocorrelations = [ser.autocorr(i).round(2) for i in range(11)]
print(autocorrelations[1:])
print('Lag having highest correlation: ', np.argmax(np.abs(autocorrelations[1:]))+1) # np.argmax() !!!!


# 33. How to import only every nth row from a csv file to create a dataframe?
# Import every 50th row of BostonHousing dataset as a dataframe.

# version 1: chunks and for-loop
df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv', chunksize=50)
df2 = pd.DataFrame()
for chunk in df:
    df2 = df2.append(chunk.iloc[0,:])


# version 2: chunks and list comprehension #(need to csv a file)
df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv', chunksize=50)
df2 = pd.concat([chunk.iloc[0] for chunk in df], axis=1)
df2 = df2.transpose()

# version 3: csv reader
import csv
with open('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv', 'r') as f:
    reader = csv.reader(f)
    out = []
    for i, row in enumerate(reader):
        if i%50 == 0:
            out.append(row)

df2 = pd.DataFrame(out[1:], columns=out[0])
print(df2.head())


# 34. How to change column values when importing csv to a dataframe?
# Import the boston housing dataset, but while importing change the 'medv' (median house value) column so that values < 25 becomes ‘Low’ and > 25 becomes ‘High’.

# version 1: using converter parameter
df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv',
                 converters={'medv': lambda x: 'High' if float(x) > 25 else 'Low'}              #-> converters !!!
                 )

# version 2: using csv reader
import csv
with open('BostonHousing.csv', 'r') as f:
    reader = csv.reader(f)
    out = []
    for i, row in enumerate(reader):
        if i > 0:
            row[13] = 'High' if float(row[13]) > 25 else 'Low'
        out.append(row)
df = pd.DataFrame(out[1:], columns=out[0])
print(df.head())


# 35. How to create a dataframe with rows as strides (stride=longueur de pas) from a given series?

L = pd.Series(range(15))

def gen_strides(a, stride_len=5, window_len=5):
    n_strides = ((a.size-window_len)//stride_len) + 1
    return np.array([a[s:(s+window_len)] for s in np.arange(0, a.size, stride_len)[:n_strides]])

gen_strides(L, stride_len=2, window_len=4)


# 36. How to import only specified columns from a csv file?
# Import ‘crim’ and ‘medv’ columns of the BostonHousing dataset as a dataframe.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv',
                 usecols=['crim', 'medv'])              #-> usecols !!!
print(df.head())

# 37. How to get the nrows, ncolumns, datatype, summary stats of each column of a dataframe? Also get the array and list equivalent.
# Get the number of rows, columns, datatype and summary statistics of each column of the Cars93 dataset. Also get the numpy array and list equivalent of the dataframe.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')

# nrows:
df.shape[0]

# ncolumns:
df.shape[1]

# datatype:
df.dtypes

# how many column under each dtype
df.get_dtype_counts()
# same as
df.dtypes.value_counts()

# summary statistics
df.describe()
# -> by default, only numeric columns are included
# to be sure to include all columns regardless of data types:
df.describe(include="all")

# numpy array:
df_arr = df.values
print(df_arr)

# to list
df_list = df.values.tolist()
print(df_list)

# 38. How to extract the row and column number of a particular cell with given criterion?

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')
df.head()
# a) Which manufacturer, model and type has the highest Price?
df.loc[df.Price == np.max(df.Price), ["Manufacturer", "Model", "Type"]]

# b) What is the row and column number of the cell with the highest Price value?
rowN, colN = np.where(df.values == np.max(df.Price))
row, col = np.where(df.values == np.max(df.Price))

# to get the value from the indices:
df.iloc[rowN, colN]

# Get the value
df.iat[row[0], col[0]]
df.iloc[row[0], col[0]]
#=>  `iat` snd `iloc` accepts row and column numbers.

# Alternates
df.at[row[0], 'Price']
df.get_value(row[0], 'Price')
#=>  Whereas `at` and `loc` accepts index and column names.

# 39. How to rename a specific columns in a dataframe?
# Rename the column Type as CarType in df and replace the ‘.’ in column names with ‘_’.
df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')
print(df.columns)

# rename a column:
df=df.rename(columns = {'Type':'CarType'})
# same as:
df.columns.values[2] = "CarType"

# replace "." with "_"
df.columns = df.columns.map(lambda x: x.replace('.', '_'))
print(df.columns)

# 40. How to check if a dataframe has any missing values?
# Check if df has any missing values.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')

df.isnull().values.any() # is.null() -> replace all entries of the df with True/False

# 41. How to count the number of missing values in each column?
# Count the number of missing values in each column of df. Which column has the maximum number of missing values?

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')

df_missings_each_col = df.apply(lambda x: x.isnull().sum()) # default: axis=0
df_missings_each_col.argmax()

# 42. How to replace missing values of multiple numeric columns with the mean?
# Replace missing values in Min.Price and Max.Price columns with their respective mean.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')

df_out = df[['Min.Price', 'Max.Price']] = df[['Min.Price', 'Max.Price']].apply(lambda x: x.fillna(x.mean()))

print(df_out.head())

# 43. How to use apply function on existing columns with global variables as additional arguments?
# In df, use apply method to replace the missing values in Min.Price with the column’s mean
# and those in Max.Price with the column’s median.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')
d = {'Min.Price': np.nanmean, 'Max.Price': np.nanmedian}
df[['Min.Price', 'Max.Price']] = \
    df[['Min.Price', 'Max.Price']].apply(
        lambda x, d: x.fillna(d[x.name](x)), args=(d, ))

# 44. How to select a specific column from a dataframe as a dataframe instead of a series?
# Get the first column (a) in df as a dataframe (rather than as a Series).

df = pd.DataFrame(np.arange(20).reshape(-1, 5), columns=list('abcde'))

d1 = df[["a"]]
type(d1)

d2 = df.loc[:,["a"]]
type(d2)

d3 = df.iloc[:,[0]]
type(d3)

# => on the other hand, this returns Series
s1 = df["a"]
type(s1)

s2 = df.loc[:,"a"]
type(s2)

s3 = df.iloc[:,0]
type(s3)

# 45. How to change the order of columns of a dataframe?
df = pd.DataFrame(np.arange(20).reshape(-1, 5), columns=list('abcde'))

#     a. In df, interchange columns 'a' and 'c':
df[list('cbade')]

#     b. Create a generic function to interchange two columns, without hardcoding column names.
def switch_columns(df, col1=None, col2=None):
    colnames = df.columns.tolist()
    i1, i2 = colnames.index(col1), colnames.index(col2)
    colnames[i2], colnames[i1] = colnames[i1], colnames[i2]
    return df[colnames]

df1 = switch_columns(df, 'a', 'c')

#     c. Sort the columns in reverse alphabetical order, that is colume 'e' first through column 'a' last.
df[sorted(df.columns, reverse=True)]
df.head()
# or
df.sort_index(axis=1, ascending=False, inplace=True)
df.head()

# 46. How to set the number of rows and columns displayed in the output?
# Change the pamdas display settings on printing the dataframe df it shows a maximum of 10 rows and 10 columns.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')

# Solution
pd.set_option('display.max_columns', 10)
pd.set_option('display.max_rows', 10)
df

# all available options:
pd.describe_option()

# 47. How to format or suppress scientific notations in a pandas dataframe?
# Suppress scientific notations like ‘e-03’ in df and print upto 4 numbers after decimal.

df = pd.DataFrame(np.random.random(4)**10, columns=['random'])
df

# version 1: Rounding
df.round(4)

# version 2: Use apply to change format
df.apply(lambda x: '%.4f' % x, axis=1)
# or
df.applymap(lambda x: '%.4f' % x)

# version 3: Use set_option
pd.set_option('display.float_format', lambda x: '%.4f' % x)

# version 4: Assign display.float_format
pd.options.display.float_format = '{:.4f}'.format
print(df)

# Reset/undo float formatting
pd.options.display.float_format = None


# 48. How to format all the values in a dataframe as percentages?
# Format the values in column 'random' of df as percentages.

df = pd.DataFrame(np.random.random(4), columns=['random'])

out = df.style.format({
    'random': '{0:.2%}'.format,
})

out

# 49. How to filter every nth row in a dataframe?
# From df, filter the 'Manufacturer', 'Model' and 'Type' for every 20th row starting from 1st (row 0).

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv')

print(df.iloc[::20, :][['Manufacturer', 'Model', 'Type']])

# 50. How to create a primary key index by combining relevant columns?
# In df, Replace NaNs with ‘missing’ in columns 'Manufacturer', 'Model' and 'Type' and create a index as
# a combination of these three columns and check if the index is a primary key.

df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/Cars93_miss.csv', usecols=[0,1,2,3,5])

df[['Manufacturer', 'Model', 'Type']] = df[['Manufacturer', 'Model', 'Type']].fillna('missing')
df.index = df.Manufacturer + '_' + df.Model + '_' + df.Type
print(df.index.is_unique)

# 51. How to get the row number of the nth largest value in a column?
# Find the row position of the 5th largest value of column 'a' in df.

df = pd.DataFrame(np.random.randint(1, 30, 30).reshape(10,-1), columns=list('abc'))

n = 5
df['a'].argsort()[::-1][n]

# 52. How to find the position of the nth largest value greater than a given value?
# In ser, find the position of the 2nd largest value greater than the mean.

ser = pd.Series(np.random.randint(1, 100, 15))

print('ser: ', ser.tolist(), 'mean: ', round(ser.mean()))
np.argwhere(ser > ser.mean())[1]

# 53. How to get the last n rows of a dataframe with row sum > 100?
# Get the last two rows of df whose row sum is greater than 100.

df = pd.DataFrame(np.random.randint(10, 40, 60).reshape(-1, 4))

# print row sums
rowsums = df.apply(np.sum, axis=1)

# last two rows with row sum greater than 100
last_two_rows = df.iloc[np.where(rowsums > 100)[0][-2:], :]

# 54. How to find and cap outliers from a series or dataframe column?
# Replace all values of ser in the lower 5%ile and greater than 95%ile with respective 5th and 95th %ile value.

ser = pd.Series(np.logspace(-2, 2, 30))

def cap_outliers(ser, low_perc, high_perc):
    low, high = ser.quantile([low_perc, high_perc])
    print(low_perc, '%ile: ', low, '|', high_perc, '%ile: ', high)
    ser[ser < low] = low
    ser[ser > high] = high
    return(ser)

capped_ser = cap_outliers(ser, .05, .95)

# 55. How to reshape a dataframe to the largest possible square after removing the negative values?
# Reshape df to the largest possible square with negative values removed. Drop the smallest values if need be. The order of the positive numbers in the result should remain the same as the original.

df = pd.DataFrame(np.random.randint(-20, 50, 100).reshape(10,-1))

# Step 1: remove negative values from arr
arr = df[df > 0].values.flatten()
arr_qualified = arr[~np.isnan(arr)]

# Step 2: find side-length of largest possible square
n = int(np.floor(arr_qualified.shape[0]**.5))

# Step 3: Take top n^2 items without changing positions
top_indexes = np.argsort(arr_qualified)[::-1]
output = np.take(arr_qualified, sorted(top_indexes[:n**2])).reshape(n, -1)
print(output)

# 56. How to swap two rows of a dataframe?
# Swap rows 1 and 2 in df.

df = pd.DataFrame(np.arange(25).reshape(5, -1))

def swap_rows(df, i1, i2):
    a, b = df.iloc[i1, :].copy(), df.iloc[i2, :].copy()
    df.iloc[i1, :], df.iloc[i2, :] = b, a
    return df

print(swap_rows(df, 1, 2))

# 57. How to reverse the rows of a dataframe?
# Reverse all the rows of dataframe df.

df = pd.DataFrame(np.arange(25).reshape(5, -1))

# version 1
df.iloc[::-1, :]

# version 2
df.loc[df.index[::-1], :]


# 58. How to create one-hot encodings of a categorical variable (dummy variables)?
# Get one-hot encodings for column 'a' in the dataframe df and append it as columns.

df = pd.DataFrame(np.arange(25).reshape(5,-1), columns=list('abcde'))

df_onehot = pd.concat([pd.get_dummies(df['a']), df[list('bcde')]], axis=1)
df_onehot

# 59. Which column contains the highest number of row-wise maximum values?
# Obtain the column name with the highest number of row-wise maximum’s in df.

df = pd.DataFrame(np.random.randint(1,100, 40).reshape(10, -1))

df.apply(np.argmax, axis=1).value_counts().index[0]

# 60. How to create a new column that contains the row number of nearest column by euclidean distance?
# Create a new column such that, each row contains the row number of nearest row-record by euclidean distance.

df = pd.DataFrame(np.random.randint(1,100, 40).reshape(10, -1), columns=list('pqrs'), index=list('abcdefghij'))

# init outputs
nearest_rows = []
nearest_distance = []

# iterate rows.
for i, row in df.iterrows():
    curr = row
    rest = df.drop(i)
    e_dists = {}  # init dict to store euclidean dists for current row.
    # iterate rest of rows for current row
    for j, contestant in rest.iterrows():
        # compute euclidean dist and update e_dists
        e_dists.update({j: round(np.linalg.norm(curr.values - contestant.values))})
    # update nearest row to current row and the distance value
    nearest_rows.append(max(e_dists, key=e_dists.get))
    nearest_distance.append(max(e_dists.values()))

df['nearest_row'] = nearest_rows
df['dist'] = nearest_distance


# 61. How to know the maximum possible correlation value of each column against other columns?
# Compute maximum possible absolute correlation value of each column against other columns in df.

df = pd.DataFrame(np.random.randint(1,100, 80).reshape(8, -1), columns=list('pqrstuvwxy'), index=list('abcdefgh'))

abs_corrmat = np.abs(df.corr())
max_corr = abs_corrmat.apply(lambda x: sorted(x)[-2])
# Maximum Correlation possible for each column:
np.round(max_corr.tolist(), 2)


# 62. How to create a column containing the minimum by maximum of each row?
# Compute the minimum-by-maximum for every row of df.

df = pd.DataFrame(np.random.randint(1,100, 80).reshape(8, -1))

# version 1
min_by_max = df.apply(lambda x: np.min(x)/np.max(x), axis=1)

# version 2
min_by_max = np.min(df, axis=1)/np.max(df, axis=1)

# 63. How to create a column that contains the penultimate value in each row?
# Create a new column 'penultimate' which has the second largest value of each row of df.

df = pd.DataFrame(np.random.randint(1,100, 80).reshape(8, -1))

out = df.apply(lambda x: x.sort_values().unique()[-2], axis=1)
df['penultimate'] = out


# 64. How to normalize all columns in a dataframe?
#     a. Normalize all columns of df by subtracting the column mean and divide by standard deviation.
#     b. Range all columns of df such that the minimum value in each column is 0 and max is 1.
# Don’t use external packages like sklearn.

df = pd.DataFrame(np.random.randint(1,100, 80).reshape(8, -1))

# version 1
df.apply(lambda x: ((x - x.mean())/x.std()).round(2))

# version 2
df.apply(lambda x: ((x.max() - x)/(x.max() - x.min())).round(2))

# 65. How to compute the correlation of each row with the suceeding row?
# Compute the correlation of each row of df with its succeeding row.

df = pd.DataFrame(np.random.randint(1,100, 80).reshape(8, -1))

[df.iloc[i].corr(df.iloc[i+1]).round(2) for i in range(df.shape[0])[:-1]]

# 66. How to replace both the diagonals of dataframe with 0?
# Replace both values in both diagonals of df with 0.

df = pd.DataFrame(np.random.randint(1,100, 100).reshape(10, -1))

for i in range(df.shape[0]):
    df.iat[i, i] = 0
    df.iat[df.shape[0]-i-1, i] = 0

# 67. How to get the particular group of a groupby dataframe by key?
# This is a question related to understanding of grouped dataframe. From df_grouped, get the group belonging to 'apple' as a dataframe.

df = pd.DataFrame({'col1': ['apple', 'banana', 'orange'] * 3,
                   'col2': np.random.rand(9),
                   'col3': np.random.randint(0, 15, 9)})

df_grouped = df.groupby(['col1'])

# version 1
df_grouped.get_group('apple')

# version 2
for i, dff in df_grouped:
    if i == 'apple':
        print(dff)

# 68. How to get the n’th largest value of a column when grouped by another column?
# In df, find the second largest value of 'taste' for 'banana'

df = pd.DataFrame({'fruit': ['apple', 'banana', 'orange'] * 3,
                   'taste': np.random.rand(9),
                   'price': np.random.randint(0, 15, 9)})

df_grpd = df['taste'].groupby(df.fruit)
df_grpd.get_group('banana').sort_values().iloc[-2]

# 69. How to compute grouped mean on pandas dataframe and keep the grouped column as another column (not index)?
# In df, Compute the mean price of every fruit, while keeping the fruit as another column instead of an index.

df = pd.DataFrame({'fruit': ['apple', 'banana', 'orange'] * 3,
                   'rating': np.random.rand(9),
                   'price': np.random.randint(0, 15, 9)})

df.groupby('fruit', as_index=False)['price'].mean()

# 70. How to join two dataframes by 2 columns so they have only the common rows?
# Join dataframes df1 and df2 by ‘fruit-pazham’ and ‘weight-kilo’.


df1 = pd.DataFrame({'fruit': ['apple', 'banana', 'orange'] * 3,
                    'weight': ['high', 'medium', 'low'] * 3,
                    'price': np.random.randint(0, 15, 9)})

df2 = pd.DataFrame({'pazham': ['apple', 'orange', 'pine'] * 2,
                    'kilo': ['high', 'low'] * 3,
                    'price': np.random.randint(0, 15, 6)})


pd.merge(df1, df2, how='inner',
         left_on=['fruit', 'weight'],
         right_on=['pazham', 'kilo'],
         suffixes=['_left', '_right'])

# 71. How to remove rows from a dataframe that are present in another dataframe?
# From df1, remove the rows that are present in df2. All three columns must be the same.

df1 = pd.DataFrame({'fruit': ['apple', 'orange', 'banana'] * 3,
                    'weight': ['high', 'medium', 'low'] * 3,
                    'price': np.arange(9)})

df2 = pd.DataFrame({'fruit': ['apple', 'orange', 'pine'] * 2,
                    'weight': ['high', 'medium'] * 3,
                    'price': np.arange(6)})
df1[~df1.isin(df2).all(1)]




# 72. How to get the positions where values of two columns match?
df = pd.DataFrame({'fruit1': np.random.choice(['apple', 'orange', 'banana'], 10),
                    'fruit2': np.random.choice(['apple', 'orange', 'banana'], 10)})
np.where(df.fruit1 == df.fruit2)


# 73. How to create lags and leads of a column in a dataframe?
# Create two new columns in df, one of which is a lag1 (shift column a down by 1 row) of column ‘a’ and the other is a lead1 (shift column b up by 1 row).

df = pd.DataFrame(np.random.randint(1, 100, 20).reshape(-1, 4), columns = list('abcd'))

df['a_lag1'] = df['a'].shift(1)
df['b_lead1'] = df['b'].shift(-1)

# 74. How to get the frequency of unique values in the entire dataframe?
# Get the frequency of unique values in the entire dataframe df.

df = pd.DataFrame(np.random.randint(1, 10, 20).reshape(-1, 4), columns = list('abcd'))

pd.value_counts(df.values.ravel())

# 75. How to split a text column into two separate columns?
# Split the string column in df to form a dataframe with 3 columns as shown.

df = pd.DataFrame(["STD, City    State",
"33, Kolkata    West Bengal",
"44, Chennai    Tamil Nadu",
"40, Hyderabad    Telengana",
"80, Bangalore    Karnataka"], columns=['row'])


# Solution
df_out = df.row.str.split(',|\t', expand=True)

# Make first row as header
new_header = df_out.iloc[0]
df_out = df_out[1:]
df_out.columns = new_header
print(df_out)
```
