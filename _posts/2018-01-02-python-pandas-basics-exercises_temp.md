
pd.Series(myarg), argument can be e.g. list, array, dictionary

myserie.head()
myserie.tail()

ser.name : to assign name to a serie

pd.concat([myserie1, myserie2]) # set axis for rowise or columnwise if mydf1



myserie.to_frame().reset_index()





ser1.isin(ser2)



pd.DataFrame(mydictionary)




other useful functions

* zip()

np.setdiff1d(ser1,ser2),

np.percentile(ser, q=[0, 25, 50, 75, 100])






ser.value_counts() frequency counts of each unique value

pd.qcut(): to bin a numeric series, e.g. pd.qcut(ser,
        q=[0, .10, .20, .3, .4, .5, .6, .7, .8, .9, 1],
        labels=['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th'])

ser.values.reshape(7,5)


np.argwhere(ser % 3 == 0)  find the positions of numbers that are multiples of 3 f




ser.map(lambda x: x.title())

ser.diff()


pd.to_datetime(ser)

ser_ts.dt.day.tolist()

ser_ts.dt.weekofyear.tolist()

 ser_ts.dt.dayofyear.tolist()

ser_ts.dt.weekday_name.tolist()




mydf.groupby(myvalue).mean()


# version 1
ser.resample('D').ffill()  # fill with previous value

# can also be done like that:
ser.resample('D').bfill()  # fill with next value
ser.resample('D').bfill().ffill()  # fill next else prev value


ser.autocorr(i)




df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv', chunksize=50)

df2 = df2.transpose()


df = pd.read_csv('https://raw.githubusercontent.com/selva86/datasets/master/BostonHousing.csv',
                 converters={'medv': lambda x: 'High' if float(x) > 25 else 'Low'}              #-> converters !!!
                 )

df.shape 


df.dtypes

# how many column under each dtype
df.get_dtype_counts()
# same as
df.dtypes.value_counts()

# summary statistics
df.describe()
# -> by default, only numeric columns are included; to be sure to include all columns regardless of data types use include="all" in argument



# numpy array:
df_arr = df.values
print(df_arr)

# to list
df_list = df.values.tolist()
print(df_list)

# 38. How to extract the row and column number of a particular cell with given criterion?

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


df.columns = df.columns.map(lambda x: x.replace('.', '_'))
print(df.columns)


# column selection: DataFrame or Series as return type


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




#     c. Sort the columns in reverse alphabetical order, that is colume 'e' first through column 'a' last.
df.sort_index(axis=1, ascending=False, inplace=True)


# 46. How to set the number of rows and columns displayed in the output?
pd.set_option('display.max_columns', 10)
pd.set_option('display.max_rows', 10)
pd.set_option('display.float_format', lambda x: '%.4f' % x)

# all available options:
pd.describe_option()


# version 1: Rounding
df.round(4)

# version 2: Use apply to change format
df.apply(lambda x: '%.4f' % x, axis=1)
# or
df.applymap(lambda x: '%.4f' % x)




# Reset/undo float formatting
pd.options.display.float_format = None


# 48. How to format all the values in a dataframe as percentages?
# Format the values in column 'random' of df as percentages.

df = pd.DataFrame(np.random.random(4), columns=['random'])

out = df.style.format({
    'random': '{0:.2%}'.format,
})

out




df.index = primary key index


n = 5


df['a'].argsort()[::-1][n]




print('ser: ', ser.tolist(), 'mean: ', round(ser.mean()))
np.argwhere(ser > ser.mean())[1]


df = pd.DataFrame(np.random.randint(10, 40, 60).reshape(-1, 4))

# print row sums
rowsums = df.apply(np.sum, axis=1)

# last two rows with row sum greater than 100
last_two_rows = df.iloc[np.where(rowsums > 100)[0][-2:], :]




ser.quantile([low_perc, high_perc])


def cap_outliers(ser, low_perc, high_perc):

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


df.apply(np.argmax, axis=1).value_counts().index[0]



mydict.update()


# version 1
df.apply(lambda x: ((x - x.mean())/x.std()).round(2))




    df.iat[i, i] = 0




df_grouped = df.groupby(['col1'])

# version 1
df_grouped.get_group('apple')

# version 2



df_grpd = df['taste'].groupby(df.fruit)
df_grpd.get_group('banana').sort_values().iloc[-2]





pd.merge(df1, df2, how='inner',
         left_on=['fruit', 'weight'],
         right_on=['pazham', 'kilo'],
         suffixes=['_left', '_right'])


# 73. How to create lags and leads of a column in a dataframe?
# Create two new columns in df, one of which is a lag1 (shift column a down by 1 row) of column ‘a’ and the other is a lead1 (shift column b up by 1 row).

df = pd.DataFrame(np.random.randint(1, 100, 20).reshape(-1, 4), columns = list('abcd'))

df['a_lag1'] = df['a'].shift(1)
df['b_lead1'] = df['b'].shift(-1)



# 75. How to split a text column into two separate columns?
# Split the string column in df to form a dataframe with 3 columns as shown.

# Solution
df_out = df.row.str.split(',|\t', expand=True)

# Make first row as header
new_header = df_out.iloc[0]
df_out = df_out[1:]
df_out.columns = new_header
print(df_out)
