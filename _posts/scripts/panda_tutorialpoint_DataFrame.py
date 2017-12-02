import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#*************************************************************** pandas TUTORIAL - TUTORIALSPOINT
# Pandas data structures:
# 1) Series: 1D labeled homogeneous array, size-immutable.
# 2) DataFrame: general 2D labeled, size-mutable tabular structure with potentially heterogeneously-typed columns. 
# 3) Panel: general 3D labeled, size-mutable array (can be illustrated as a container of a DataFrame)

# Notes:
# - data frame: index (rows) and columns correspond to axis 0 and 1
# - all Pandas data structures are value mutable (can be changed) and except Series all are size mutable




#===================================================================
# 2) DataFrame
#===================================================================

############
# 2.a) DataFrame creation
############

# can be created from 1) Lists, 2) dict, 3) Series, 4) Numpy ndarrays, 5) Another DataFrame

# create a data frame from list - ex1
data = [1,2,3,4,5]
df = pd.DataFrame(data)
print(df)

# create a data frame from list - ex2
data = [['Alex',10],['Bob',12],['Clarke',13]]
df = pd.DataFrame(data, columns = ['Name', 'Age'], dtype=float)
print(df)

# create a data frame from dict of ndarrays/list
data = {'Name':['Tom', 'Jack', 'Steve', 'Ricky'],
		'Age':[28,34,29,42]}
df= pd.DataFrame(data)
print(df)

# create an indexed data frame
df = pd.DataFrame(data, index = ['rank1', 'rank2', 'rank3', 'rank4'] )
print(df)

# create DataFrame from list of dict
# the keys are used as column names, if missing -> NA
data = [{'a': 1, 'b': 2},
		{'a': 5, 'b': 10, 'c': 20}]
df = pd.DataFrame(data)
print(df)

# create DataFrame from list of dict, with row names
df = pd.DataFrame(data, index=['first', 'second'])
print(df)

# create DataFrame from list of dict, with row names and column names
# (take only the columns that correspond to the column names passed in argument, and if not present in data, create NA)
df = pd.DataFrame(data, index=['first', 'second'], columns = ['a', 'b1'])
print(df)

# create DataFrame from dict of Series
# (keys of the dict as column names, index of the Series as row names)
d = {'one' : pd.Series([1, 2, 3], index=['a', 'b', 'c']),
	'two' : pd.Series([1, 2, 3, 4], index=['a', 'b', 'c', 'd'])}
df = pd.DataFrame(d)
print(df)


############
# 2.b) DataFrame manipulation
############

# COLUMN MANIPULATION

# column selection - by column name
d = {'one' : pd.Series([1, 2, 3], index=['a', 'b', 'c']),
	'two' : pd.Series([1, 2, 3, 4], index=['a', 'b', 'c', 'd'])}
df = pd.DataFrame(d)
print(df['one'])

# column addition - by column label
df['three'] = pd.Series([10,20,30],index=['a','b','c'])
print(df)

# column addition - using existing columns
df['four'] = df['one'] + df['two']
print(df)

# column deletion - using del (no left assignment)
del df['one']
print(df)

# column deletion - using pop (removed column can be stored into variable)
y = df.pop('two')
print(df)
print(y)

# ROW MANIPULATION

# row selection by label
d = {'one' : pd.Series([1, 2, 3], index=['a', 'b', 'c']),
	'two' : pd.Series([1, 2, 3, 4], index=['a', 'b', 'c', 'd'])}
df = pd.DataFrame(d)
print(df.loc['b'])

# row selection by integer location
print(df.iloc[0])

# row selection by slice
print(df.iloc[0:2])

# row addition
df = pd.DataFrame([[1, 2], [3, 4]], columns=['a','b'])
df2 = pd.DataFrame([[5, 6], [7, 8]], columns=['a','b'])
df = df.append(df2)
print(df)

# deletion of rows with label 0
# ! if labels are duplicated, multiple rows will be dropped
df = df.drop(0)

############
# 2.c) DataFrame basic functionalities
############

# create a DataFrame using a dict of Series
d={'Name':pd.Series(['Tom','James','Ricky','Vin','Steve','Smith','Jack']),
   'Age':pd.Series([25,26,25,23,30,29,23]),
	'Rating':pd.Series([4.23,3.24,3.98,2.56,3.20,4.6,3.8])}

df = pd.DataFrame(d)
print(df)

# 1- T
# => transpose
print(df.T)

# 2- axes
# => returns a list of row axis labels and column axis labels
df = pd.DataFrame(d)
print ("Row axis labels and column axis labels are:")
print(df.axes)

# 3- dtypes
# => returns the data type of each column
print(df.dtypes)

# 4- empty
# => returns a Boolean indicating if the object is empty
print(df.empty)

# 5- shape
# => returns a tuple representing the dimensionality of the DataFrame
print(df.shape)

# 6- size
# => returns the number of elements
print(df.size)

# 7- values
# => returns the actual data in the DataFrame as an NDarray
print(df.values)

# 8- head 
# => returns the first n rows
print(df.head(2))

# 9- tail
# => returns the last n rows
print(df.tail(2))


############
# 2.d) Descriptive statistics
############

# method of aggregation generally requires an argument specifying the axis
# the axis can be specified by name or integer "index" (axis=0, default), "columns" (axis=1)	
# (when axis is "index" (rows) => aggregate the rows (1 value/column) 


d={	'Name':pd.Series(['Tom','James','Ricky','Vin','Steve','Smith','Jack',	
				'Lee','David','Gasper','Betina','Andres']),
   	'Age':pd.Series([25,26,25,23,30,29,23,34,40,30,51,46]),
	'Rating':pd.Series([4.23,3.24,3.98,2.56,3.20,4.6,3.8,3.78,2.98,4.80,4.10,3.65])
}
#Create a DataFrame
df = pd.DataFrame(d)
print(df)

# 1- sum()
# => returns the sum
# by default, axis is index (axis=0)
# axis = 0 => aggregates the rows (returns 1 value per column)
# all equivalent:
print(df.sum())
print(df.sum(axis=0))
print(df.sum(axis="index"))

# axis = 1 => aggregates the column, 1 value/row
print(df.sum(axis=1))

# 2- mean()
# => returns the average value
print(df.mean())

# 3- std()
# => returns the sd of the numerical columns (axis=0) (resp. rows; axis = 1) only
print(df.std())
print(df.std(axis=1))

# other similar functions:
# 4- count() [# number of non-null observations]
# 5- median()
# 6- mode()
# 7- min()
# 8- max()
# 9- mode()
# 10- prod()
# 11- cumsum()
# 12- cumprod()

# functions like sum() and cumsum() will work with both numerics and characters/strings without drawing exceptions
# functions like abs(), cumprod() will throw exception if the DataFrame contains non-numeric values

# 13- describe()
# => returns mean, std and IQR values. 
# excludes the character columns 
# 'include' argument to used to pass necessary information regarding what columns need to be considered ('number' by default)
# 
print(df.describe()) # Age and Rating (returns std min quantiles max)
print(df.describe(include=['object'])) # Name (returns count unique top freq)
print(df.describe(include='all')) # (returns std min quantiles max, with NaN for the non-numerics)


############
# 2.e) Function applications
############


# 1- pipe() => table-wise function application

def adder(e1, e2):
	return e1+e2

df = pd.DataFrame(np.random.randn(5,3),columns=['col1','col2','col3'])
print(df)
print(df.pipe(adder,2))
# equivalent to:
print(df.pipe(lambda x,y: x+y, 2))

# 2- apply() => row or column-wise function application
# uses axis argument; by default, the operation performs column wise, taking each column as an array-like
# get the mean of each column
# (axis = index => aggregate the rows, mean of each column)
print(df.apply(np.mean))
print(df.apply(np.mean, axis=0))
print(df.apply(np.mean, axis="index"))
# axis = 1 => aggregate the column, get row mean
print(df.apply(np.mean, axis=1))
print(df.apply(np.mean, axis="columns"))

# other example:
print(df.apply(lambda x: x.max() - x.min())) # do this for each column
print(df.apply(lambda x: x.max() - x.min(), axis=1)) # do this for each row

# 3- applymap() => element-wise function application
# for functions that can be vectorized
# e.g. applymap() on DataFrame and analogously map() on Series: accept any Python function taking a single value and returning a single value
print(df['col1'].map(lambda x:x*100))
print(df.applymap(lambda x:x*100))
#print(df.applymap(lambda x,y:x+y, 2)) => will not work, applymap takes only and exactly 2 arguments


############
# 2.f) Reindexing
############
# => change row labels and column labels

N=20
df = pd.DataFrame({
	'A': pd.date_range(start='2016-01-01',periods=N,freq='D'),
	'x': np.linspace(0,stop=N-1,num=N),
	'y': np.random.rand(N),
	'C': np.random.choice(['Low','Medium','High'],N).tolist(),
	'D': np.random.normal(100, 10, size=(N)).tolist()
})

print(df)

df_reindexed = df.reindex(index=[0,2,5], columns=['A', 'C', 'B'])
print(df_reindexed)

# reindex to align with other object
df1=pd.DataFrame(np.random.randn(10,3),columns=['col1','col2','col3'])
df2=pd.DataFrame(np.random.randn(7,3),columns=['col1','col2','col3'])
df1 = df1.reindex_like(df2)
print(df1)

# filling while reindexing
# reindex() takes an optional parameter method which is a filling method with values as follows:
# - pad/ffill - Fill values forward
# - bfill/backfill - Fill values backward
# - nearest - Fill from the nearest index values

df1=pd.DataFrame(np.random.randn(6,3),columns=['col1','col2','col3'])
df2=pd.DataFrame(np.random.randn(2,3),columns=['col1','col2','col3'])
# Padding NAN's
print(df2.reindex_like(df1))
# Now Fill the NAN's with preceding Values
print("Data Frame with Forward Fill:")
print(df2.reindex_like(df1,method='ffill'))

# limit argument provides additional control over filling while reindexing. 
# => specifies the maximum count of consecutive matches.

df1 = pd.DataFrame(np.random.randn(6,3),columns=['col1','col2','col3'])
df2 = pd.DataFrame(np.random.randn(2,3),columns=['col1','col2','col3'])
# Padding NAN's
print(df2.reindex_like(df1))
# Now Fill the NAN's with preceding Values
print("Data Frame with Forward Fill limiting to 1:")
print(df2.reindex_like(df1,method='ffill',limit=1))

# Renaming
# => rename() allows you to relabel an axis based on some mapping (a dict or Series) or an arbitrary function.
df1 = pd.DataFrame(np.random.randn(6,3),columns=['col1','col2','col3'])
print(df1)
print("After renaming the rows and columns:")
print(df1.rename(columns={'col1' : 'c1', 'col2' : 'c2'},
				index={0 : 'apple', 1 : 'banana', 2 : 'durian'}))


############
# 2.g) Iteration
############

# NB: do not modify object during iteration
# iteration is used for reading, the iterator returns a copy of the original object (a view)
# changing the object during iteration will not affect the original object.

# iterating a data frame gives column names:

df = pd.DataFrame({
	'A': pd.date_range(start='2016-01-01',periods=N,freq='D'),
	'x': np.linspace(0,stop=N-1,num=N),
	'y': np.random.rand(N),
	'C': np.random.choice(['Low','Medium','High'],N).tolist(),
	'D': np.random.normal(100, 10, size=(N)).tolist()
})
for col in df:
	print(col)


# iteritems()
# => iterates over each column as key, value pair with
# -> label as key 
# -> column as a Series object as value
df = pd.DataFrame(np.random.randn(4,3),columns=['col1','col2','col3'])
print(df)
for key,value in df.iteritems():
	print(key, value)


# iterrows() 
# => returns the iterator yielding each index value along with a series containing the data in each row.
for row_index,row in df.iterrows():
	print(row_index, row)

# itertuples() 
# => returns an iterator yielding a named tuple for each row in the DataFrame. 
# -> The first element of the tuple = row's corresponding index value
# -> Remaining values are the row values.
for row in df.itertuples():
	print(row)


############
# 2.h) Sorting
############

unsorted_df = pd.DataFrame(np.random.randn(10,2), index=[1,4,6,2,3,5,9,8,0,7], columns=['col2','col1'])
print(unsorted_df)

### Sort by label (row names)
# => sort_index(): by passing the axis and the order of sorting arguments

# default sort: axis=0 (sort the rows), increasing sort
sorted_df = unsorted_df.sort_index()  # equivalent to: (axis=0)
print(sorted_df)

# sort by column names
sorted_df = unsorted_df.sort_index(axis=1)
print(sorted_df)

# decreasing sort: ascending=False
sorted_df = unsorted_df.sort_index(axis=0, ascending=False) # equivalent to (ascending = False)
print(sorted_df)

### Sort by values
# => sort_values(): by passing the column name argument 
sorted_df = unsorted_df.sort_values(by='col1')
print(sorted_df)
# with one column, values of col2 and labels will alter along with col1

# sort_values() can take a list of column names
unsorted_df = pd.DataFrame({'col1':[2,1,1,1],'col2':[1,3,2,4]})
sorted_df = unsorted_df.sort_values(by=['col1','col2'])
print(sorted_df)

# algorithm choice with 'kind': different algorithms available for sorting
sorted_df = unsorted_df.sort_values(by='col1', kind='mergesort')
print(sorted_df)


############
# 2.i) Indexing and selecting
############

# in short:
# .loc() 	=> Label based
# .iloc() 	=> Integer based
# .ix()		=> Both Label and Integer based


# df.loc[row_index,col_index] => returns a Series object
# .iloc() & .ix() applies the same indexing options and Return value.

### .loc()
# -> purely label based indexing
# -> when slicing, the start bound is also included
# -> integers are valid labels, but refer to the label and not the position
# -> multiple access methods like: i) single scalar label, ii) list of labels, iii) slice object, iv) boolean array
# -> takes two single/list/range operator separated by ',': the 1st indicates the row; and the 2nd indicates columns.

df = pd.DataFrame(np.random.randn(8, 4),
			index=['a','b','c','d','e','f','g','h'], columns=['A', 'B', 'C', 'D'])

# ex1- select all rows for a specific column
print(df.loc[:,'A'])

# ex2 - select all rows for multiple columns
print(df.loc[:, ['A', 'B']])

# ex3 - select few rows for multiple columns
print(df.loc[['a', 'b', 'c'], ['A', 'B']])

# ex4 - select range of rows for all columns
print(df.loc['a':'f'])
df2 = pd.DataFrame(np.random.randn(8, 4),
			index=['a','f','c','h','e','d','g', 'b'], columns=['A', 'B', 'C', 'D'])
print(df2.loc['a':'f']) # will take only the first 2 rows

# ex5 - select all rows for a range of columns
print(df.loc[:, 'A':'C'])

# ex6 - getting values with boolean array
print(df.loc['a'] > 0)


### .iloc()
# -> purely integer based indexing (zero-based)
# -> access methods: i) An Integer, ii) A list of integers, iii) A range of values

# ex1 - access a specific column
print(df.iloc[:4])

# ex2 - integer slicing
print(df.iloc[1:5, 2:4])

# ex3 - slicing through list of values
print(df.iloc[[1, 3, 5], [1, 3]])
print(df.iloc[1:3, :])
print(df.iloc[:,1:3])	

### .ix()
# -> hybrid method
print(df.ix[:,'A'])

# get the column as a Series
print(df['A']) 
# get a DataFrame
print(df[['A','B']])

### "."
# -> columns can be accessed with the dot
print(df.A)

############
# 2.j) Window functions
############

# Pandas provide few variants like rolling, expanding and exponentially moving weights for window statistics. 
# Among these are sum, mean, median, variance, covariance, correlation, etc.


### .rolling() 
# -> can be applied on a series of data. Specify the window=n argument and apply the appropriate statistical function on top of it.

df = pd.DataFrame(np.random.randn(10, 4), index=pd.date_range('1/1/2000', periods=10), columns=['A', 'B', 'C', 'D'])
print(df.rolling(window=3).mean())
# Since the window size is 3, for first two elements there are nulls and from third the value will be the average of the n, n-1 and n-2 elements.

### .expanding() 
# -> can be applied on a series of data. Specify the min_periods=n argument and apply the appropriate statistical function on top of it.

print(df.expanding(min_periods=3).mean())

### .ewm()
# -> applied on a series of data. Specify any of the com, span, halflife argument and apply the appropriate statistical function on top of it. It assigns the weights exponentially.
print(df.ewm(com=0.5).mean())

############
# 2.k) Aggregation functions
############

# Once the rolling, expanding and ewm objects are created, several methods are available to perform aggregations on data.

# applying aggregation on whole data frame
df = pd.DataFrame(np.random.randn(10, 4),
index = pd.date_range('1/1/2000', periods=10), columns=['A', 'B', 'C', 'D'])
print(df)
r = df.rolling(window=3,min_periods=1)
print(r)

# applying aggregation on single column of a data frame
print(r['A'].aggregate([np.sum,np.mean]))

# applying multiple functions on multiple columns of a Dataframe
print(r[['A','B']].aggregate([np.sum,np.mean]))

# applying different functions to different columns of a Dataframe
print(r.aggregate({'A' : np.sum,'B' : np.mean}))


############
# 2.l) Missing data
############

# create a DataFrame with NaN (when provided row name does not exist in the DataFrame -> row filled with NaN)
df = pd.DataFrame(np.random.randn(5, 3), index=['a', 'c', 'e', 'f','h'],columns=['one', 'two', 'three'])
df = df.reindex(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
print(df)

# isnull()
print(df['one'].isnull())
# returns a Series for the column 'one' with Booleans (True if missing)

print(df['one'].notnull())
# returns a Series for the column 'one' with Booleans (True if not missing)

# if missing data, mathematical functions (e.g. sum) will return nan

# .fillna()
# -> replace NA with scalar values
df = pd.DataFrame(np.random.randn(3, 3), index=['a', 'c', 'e'],columns=['one','two', 'three'])
df = df.reindex(['a', 'b', 'c'])
print(df)
print(df.fillna(0))

# method="pad"
# -> fill methods forward
print(df.fillna(method="pad")) # equivalent to: method = "ffill"
print(df.fillna(method="ffill"))

# method="backfill"
# -> fill methods backward
print(df.fillna(method="backfill")) # equivalent to: method = "bfill"

# .dropna()
# -> drop missing values
# by default, axis=0, i.e., along row => if any value within row is NA, exclude the whole row
print(df.dropna())  # equivalent to axis=0 (drop the rows with missing values)
print(df.dropna(axis=1)) # (drop the column with missing values)

# replace values
# (if NA values are replaced with scalars => equivalent to fillna())
df = pd.DataFrame({'one':[10,20,30,40,50,2000], 'two':[1000,0,30,40,50,60]})
# ex: replace 1000 with 10 and 2000 with 60
# ex1: dict notation
print(df.replace({1000:10,2000:60}))
# ex2: list notation
print(df.replace([1000, 2000], [10, 60]))


############
# 2.m) groupby
############

# involves one of the following operation: 1) splitting, 2) applying (aggregation, transformation, filtration), 3) combining

ipl_data = {'Team': ['Riders', 'Riders', 'Devils', 'Devils', 'Kings',
			'kings', 'Kings', 'Kings', 'Riders', 'Royals', 'Royals', 'Riders'],
			'Rank': [1, 2, 2, 3, 3,4 ,1 ,1,2 , 4,1,2],
			'Year': [2014,2015,2014,2015,2014,2015,2016,2017,2016,2014,2015,2017],
			'Points':[876,789,863,673,741,812,756,788,694,701,804,690]}
df = pd.DataFrame(ipl_data)
print(df)

### .groupby()
# -> split data into groups

# multiple ways to split an object:
# i) obj.groupby('key'); ii) obj.groupby(['key1', 'key2']); iii) obj.groupby(key,axis=1)

# ex1: groupby with single column
print(df.groupby('Team')) # returns a groupby object
# output: <pandas.core.groupby.DataFrameGroupBy object at 0x7f88a5bc7898>
print(df.groupby("Team").groups)

# ex2: groupby with multiple columns
print(df.groupby(["Team", "Year"]).groups)

# iteration over groupby object
groupedDF = df.groupby('Year')

for name, group in groupedDF:
	print(name, group)

### .get_group()
# -> select group

groupedDF = df.groupby("Year")
print(groupedDF.get_group(2014))

### AGGREGATION - .agg()
# -> aggregated function, returns a single aggregated value for each group. 
# Once the groupby object is created, several aggregation operations can be performed on the grouped data.

# ex1: get the mean of points for each year:
groupedDF = df.groupby('Year')
print(groupedDF['Points'].agg(np.mean))

# ex2: get the size of each group:
groupedDF = df.groupby('Team')
print(groupedDF.agg(np.size))

# apply multiple functions at once using a list or dict of functions
groupedDF = df.groupby('Team')
print(groupedDF['Points'].agg([np.sum, np.mean, np.std]))

### TRANSFORMATION - .transform()
# Transformation on a group or a column returns an object that is indexed the same size of
# that is being grouped -> the transform should return a result that is the same size as that of a group chunk

groupedDF = df.groupby('Team')
score = lambda x: (x-x.mean())/x.std() * 10
print(groupedDF.transform(score))

### FILTRATION - .filter()
# -> filters the data on a defined criteria and returns the subset of data

print(df.groupby('Team').filter(lambda x: len(x) >= 3))


############
# 2.n) Merging and joining
############

# typical function: .merge()

# pd.merge(left, right, how='inner', on=None, left_on=None, right_on=None, left_index=False, right_index=False, sort=True)
# -> left: A DataFrame object.
# -> right: Another DataFrame object.
# -> on: Columns (names) to join on. Must be found in both the left and right DataFrame objects.
# -> left_on: Columns from the left DataFrame to use as keys. Can either be column names or arrays with length equal to the length of the DataFrame.
# -> right_on: Columns from the right DataFrame to use as keys. Can either be column names or arrays with length equal to the length of the DataFrame.
# -> left_index: If True, use the index (row labels) from the left DataFrame as its join key(s). 
#                In case of a DataFrame with a MultiIndex (hierarchical), the number of levels must match the number of join keys from the right DataFrame.
# -> right_index: Same usage as left_index for the right DataFrame.
# -> how: One of 'left', 'right', 'outer', 'inner'. Defaults to inner. Each method has been described below.
# -> sort: Sort the result DataFrame by the join keys in lexicographical order. Defaults to True, setting to False will improve the performance substantially in many cases.

leftDF = pd.DataFrame({
						'id':[1,2,3,4,5],
						'Name': ['Alex', 'Amy', 'Allen', 'Alice', 'Ayoung'],
						'subject_id':['sub1','sub2','sub4','sub6','sub5']})
rightDF = pd.DataFrame({
						'id':[1,2,3,4,5],
						'Name': ['Billy', 'Brian', 'Bran', 'Bryce', 'Betty'],
						'subject_id':['sub2','sub4','sub3','sub6','sub5']})
print(leftDF)
print(rightDF)

# Merge 2 data frames on one Key
print(pd.merge(leftDF, rightDF, on = "id"))

# Merge 2 data frames on multiple keys
print(pd.merge(leftDF, rightDF, on = ["id", "subject_id"]))

# "how" argument
# -> specify how to determine which keys are to be included in the resulting table. 
# If a key combination does not appear in either the left or the right tables, the values in the joined table will be NA.
# "left" [SQL: LEFT OUTER JOIN] -> Use keys from left object
# "right" [SQL: RIGHT OUTER JOIN] -> Use keys from right object
# "outer" [SQL: FULL OUTER JOIN] -> Use union of keys
# "inner" [SQL: INNER JOIN] -> Use intersection of keys
print(pd.merge(leftDF, rightDF, on='subject_id', how='left'))

# .join()
# -> Joining will be performed on index. Join operation honors the object on which it is called (a.join(b) is not equal to b.join(a))
df1 = pd.DataFrame(np.random.randn(3, 3), index=['a', 'b', 'c'],columns=['one','two', 'three'])
df2 = pd.DataFrame(np.random.randn(3, 3), index=['c', 'd', 'e'],columns=['four','five', 'six'])

print(df1.join(df2))
print(df2.join(df1))

############
# 2.o) Concatenation
############

# concat() can be easily applied on Series, DataFrame and Panel
# typical function .concat()
# pd.concat(objs,axis=0,join='outer',join_axes=None, ignore_index=False)
# -> objs: This is a sequence or mapping of Series, DataFrame, or Panel objects.
# -> axis: {0, 1, ...}, default 0 (concatenate the rows). This is the axis to concatenate along.
# -> join: {‘inner’, ‘outer’}, default ‘outer’. How to handle indexes on other axis(es). Outer for union and inner for intersection.
# -> ignore_index: boolean, default False. If True, do not use the index values on the concatenation axis. The resulting axis will be labeled 0, ..., n - 1.
# -> join_axes: This is the list of Index objects. Specific indexes to use for the other (n-1) axes instead of performing inner/outer set logic.

oneDF = pd.DataFrame({
			'Name': ['Alex', 'Amy', 'Allen', 'Alice', 'Ayoung'],
			'subject_id':['sub1','sub2','sub4','sub6','sub5'],
			'Marks_scored':[98,90,87,69,78]},
			index=[1,2,3,4,5])
twoDF = pd.DataFrame({
			'Name': ['Billy', 'Brian', 'Bran', 'Bryce', 'Betty'],
			'subject_id':['sub2','sub4','sub3','sub6','sub5'],
			'Marks_scored':[89,80,79,97,88]},
			index=[1,2,3,4,5])
print(pd.concat([oneDF, twoDF]))

# Suppose we wanted to associate specific keys with each of the pieces of the chopped up DataFrame. We can do this by using the keys argument:
print(pd.concat([oneDF, twoDF], keys=['x', 'y']))

# The index of the resultant is duplicated; each index is repeated.
# If the resultant object has to follow its own indexing, set ignore_index to True.
print(pd.concat([oneDF, twoDF], ignore_index = True))


# to append the columns not the rows
print(pd.concat([oneDF, twoDF], axis=1))

# append()
# -> concatenation using .append() instance method (shortcut for Series and DataFrame)
print(oneDF.append(twoDF))
# can take multiple arguments
print(oneDF.append([twoDF, oneDF, twoDF]))

############
# 2.p) Time series
############

# datetime.now()
# -> gives you the current date and time.
print(pd.datetime.now())

# Timestamp()
print(pd.Timestamp('2017-03-01'))
print(pd.Timestamp(1587687255,unit='s'))

# date_range()
# -> creates a range of time
print(pd.date_range("11:00", "13:30", freq="30min").time)
# change the frequency of time
print(pd.date_range("11:00", "13:30", freq="H").time)
print(pd.date_range('1/1/2011', periods=5))
print(pd.date_range('1/1/2011', periods=5,freq='M'))

# bdate_range() stands for business date ranges. Unlike date_range(), it excludes Saturday
print(pd.bdate_range('1/1/2011', periods=5))

# to_datetime()
# -> convert a Series or list-like object of date-like objects
print(pd.to_datetime(pd.Series(['Jul 31, 2009','2010-01-10', None])))
print(pd.to_datetime(['2005/11/23', '2010.12.31', None]))


############
# 2.p) Time deltas
############

# Timedeltas are differences in times, expressed in difference units, for example, days, hours, minutes, seconds. They can be both positive and negative.

# creation from string
print(pd.Timedelta('2 days 2 hours 15 minutes 30 seconds'))
# creation from integer
print(pd.Timedelta(6,unit='h'))
# creation from data offsets
print(pd.Timedelta(days=2))

# to_timedelta()
# convert a scalar, array, list, or series from a recognized timedelta format/ value into a Timedelta type. 
# It will construct Series if the input is a Series, a scalar if the input is scalar-like, otherwise will output a TimedeltaIndex.
print(pd.to_timedelta('1 days 06:05:01.00003'))

# operations on Series/DataFrames with Timedelta and datetime objects
s = pd.Series(pd.date_range('2012-1-1', periods=3, freq='D'))
td = pd.Series([ pd.Timedelta(days=i) for i in range(3) ])
df = pd.DataFrame(dict(A = s, B = td))
print(df)
df['C']=df['A']+df['B']
print(df)
df['D']=df['C']-df['B']
print(df)

############
# 2.q) Visualization
############
# plot() on Series and DataFrame is just a simple wrapper around the matplotlib libraries

# lineplot:
df = pd.DataFrame(np.random.randn(10,4),index=pd.date_range('1/1/2000', periods=10), columns=list('ABCD'))
df.plot()
# If the index consists of dates, it calls gct().autofmt_xdate() to format the x-axis as shown in the above illustration.
# We can plot one column versus another using the x and y keywords.
plt.show(block = True)


# handful of plot styles other than the default line plot. These methods can be provided as the kind keyword argument to plot(). These include:
# i) bar or barh for bar plots, ii) hist for histogram, iii) box for boxplot, iv) 'area' for area plots, v) 'scatter' for scatter plots

# .plot.bar() -> barplot:
df=pd.DataFrame(np.random.rand(10,4),columns=['a','b','c','d'])
df.plot.bar()
plt.show(block = True)

# .plot.bar(stacked=True) -> stacked barplot:
df.plot.bar(stacked = True)
plt.show(block = True)

# .plot.barh(stacked=True) -> stacked horizontal barplot:
df.plot.barh(stacked=True)
plt.show(block = True)

# .plot.hist() -> histogram
df=pd.DataFrame({'a':np.random.randn(1000)+1,'b':np.random.randn(1000),'c': np.random.randn(1000) - 1}, columns=['a', 'b', 'c'])
# one plot, 1 color/column
df.plot.hist(bins=20)
plt.show(block = True)
# 1 plot/column
df=pd.DataFrame({'a':np.random.randn(1000)+1,'b':np.random.randn(1000),'c':
np.random.randn(1000) - 1}, columns=['a', 'b', 'c'])
df.diff().hist(bins=20)
plt.show(block = True)

# .boxplot() -> boxplot 
# -> Series.box.plot(), DataFrame.box.plot(), or DataFrame.boxplot() to visualize the distribution of values within each column
df = pd.DataFrame(np.random.rand(10, 5), columns=['A', 'B', 'C', 'D', 'E'])
df.boxplot()
plt.show(block = True)

# .plot.area() -> area plot
# -> Series.plot.area() or the DataFrame.plot.area()
df.plot.area()
plt.show(block = True)

# .plot.scatter() -> scatter plot
df = pd.DataFrame(np.random.rand(50, 4), columns=['a', 'b', 'c', 'd'])
df.plot.scatter(x='a', y='b')
plt.show(block = True)

# .plot.pie() -> pie chart
df = pd.DataFrame(3 * np.random.rand(4), index=['a', 'b', 'c', 'd'], columns=['x'])
df.plot.pie(subplots=True)
plt.show(block=True)
