import pandas as pd
import numpy as np

my_file = "foo_table.txt.csv"

#import a data frame that as header and row names

fileDT = pd.read_csv(my_file, sep="\t", header=0, index_col=0)

print("> Dimension:")
print(fileDT.shape)

# select the first 2 rows
print("> First two rows:")
print(fileDT[:2])

# select the first 2 colums
print("> First two columns (i):")
print(fileDT.iloc[:,0:2])

# other possibility to select teh first 2 columns
print("> First two columns (ii):")
# equivalent to the 3d version as columns returns column names
print(fileDT[fileDT.columns[0:2]])

print("> First two columns (iii):")
print(fileDT[['sample1','sample2']] )

# select both rows and columns
print("> First two columns and rows:")
print(fileDT.iloc[0:2,0:2])

########################################
#### Pandas STATISTICAL FUNCTIONS
########################################

# -> statistical functions available for  Series, DataFrame and Panel

### pct_change()
# -> compares every element with its prior element and computes the change percentage

df = pd.DataFrame(np.random.randn(5, 2))
print(df)
print(df.pct_change()) # equivalent to (axis=0) # column-wise
print(df.pct_change(axis=1)) # row-wise

### cov()
# -> calculates covariance
s1 = pd.Series(np.random.randn(10))
s2 = pd.Series(np.random.randn(10))
print(s1.cov(s2))

frame = pd.DataFrame(np.random.randn(10, 5), columns=['a', 'b', 'c', 'd', 'e'])
print(frame['a'].cov(frame['b']))
print(frame.cov())

### corr()
# -> calculates correlation
print(frame['a'].corr(frame['b']))
print(frame.corr())

### rank()
# -> data ranking
s = pd.Series(np.random.np.random.randn(5), index=list('abcde'))
print(s.rank())

# different tie-breaking methods: i) average, ii) min, iii) max, iv) first


########################################
#### Categorical data
########################################

# Categorical variables:
# -> can take on only a limited, and usually fixed number of possible values.
# -> might have an order but cannot perform numerical operation. 
# Categorical are a Pandas data type. Useful in the following cases:
# - a string variable consisting of only a few different values (will save some memory)
# - the lexical order of a variable is not the same as the logical order ("one", "two", "three"). 
#   by converting to a categorical and specifying an order on the categories, sorting and min/max will use the logical order instead of the lexical order.
# - as a signal to other python libraries that this column should be treated as a categorical variable (e.g. to use suitable statistical methods or plot types).

# categorical data can be created in multiple ways
# 1- by specifying the dtype as "category" in pandas object creation
s = pd.Series(["a","b","c","a"], dtype="category")
print(s)

# 2- using the standard pandas Categorical constructor
# pandas.Categorical(values, categories, ordered)
cat = pd.Categorical(['a', 'b', 'c', 'a', 'b', 'c'])
print(cat)
# by specifying the order
cat = pd.Categorical(['a','b','c','a','b','c','d'], ['c', 'b', 'a'],ordered=True)
print(cat)

# .describe()
# -> on the categorical data, to get similar output to a Series or DataFrame of the type string
cat = pd.Categorical(["a", "c", "c", np.nan], categories = ["b", "a", "c"])
df = pd.DataFrame({	"cat": cat, 
					"s": ["a", "c", "c", np.nan]})
print(df.describe())
print(df["cat"].describe())

# .categories
# -> to get the categories of the object
s = pd.Categorical(["a", "c", "c", np.nan], categories=["b", "a", "c"])
print(s.categories) 

# .ordered
# -> to get the categories of the object
# -> returns False if no order has been specified
print(s.ordered)

# .cat.categories
# -> renaming categories
s = pd.Series(["a","b","c","a"], dtype="category")
s.cat.categories = ["Group %s" % g for g in s.cat.categories]
print(s.cat.categories)

# .cat.add_categories()
# -> appending new categories
s = pd.Series(["a","b","c","a"], dtype="category")
s = s.cat.add_categories([4])
print(s.cat.categories)

# .cat.remove_categories()
# -> removing categories
s = s.cat.remove_categories('a')
print(s.cat.categories)

### comparison of categorical data
# possible in 3 cases:
# 1- comparing equality (== and !=) to a list-like object (list, Series, array, ...) of the same length as the categorical data.
# 2- all comparisons (==, !=, >, >=, <, and <=) of categorical data to another categorical Series, when ordered==True and the categories are the same.
# 3- all comparisons of a categorical data to a scalar.
cat = pd.Series([1,2,3]).astype("category", categories=[1,2,3], ordered=True)
cat1 = pd.Series([2,2,2]).astype("category", categories=[1,2,3], ordered=True)
print(cat > cat1)


########################################
#### Input/output
########################################
 
df = pd.read_csv("temp.csv", sep=",")
print(df)

# "index_col" argument
# -> use custom index (row names)
df = pd.read_csv("temp.csv", sep=",", index_col=['S.No'])
print(df)

# "dtype" argument
# -> type converter, can be passed as a dict
df = pd.read_csv("temp.csv", dtype={'Salary': np.float64})
print(df)
print(df.dtypes)

# "header_names" argument
# -> can be used to specify column names
df = pd.read_csv("temp.csv", sep=",", names=["a", "b", "c", "d", "e"])
print(df)
# the header names are appended with the custom names, but the header in the file has not been eliminated. 
# "header" -> to define or eliminate the header from the file
# NB: if the header is in a row other than the first, pass the row number to header. This will skip the preceding rows.

df = pd.read_csv("temp.csv", names=["a", "b", "c", "d", "e"], header=0)
print(df)

# "skiprows" -> skip the number of first rows specified
df = pd.read_csv("temp.csv", header=0, skiprows = 2) # unexpected: used the 0-th row as header after having skipped the first 2 rows
print(df) 
df = pd.read_csv("temp.csv", names=["a", "b", "c", "d", "e"], header=0, skiprows=2)
print(df)



########################################
#### Sparse data
########################################

# Sparse objects are "compressed" when any data matching a specific value (NaN / missing value, though any value can be chosen) is omitted. 
# A special SparseIndex object tracks where data has been “sparsified”. This will make much more sense in an example. 
# All of the standard Pandas data structures apply the to_sparse method:

# .to_sparse() -> convert to sparse

ts = pd.Series(np.random.randn(10))
ts[2:-2] = np.nan
sts = ts.to_sparse()
print(sts)

# The sparse objects exist for memory efficiency reasons.

df = pd.DataFrame(np.random.randn(10000, 4))
df.ix[:9998] = np.nan
sdf = df.to_sparse()
print(sdf.density)

# .to_dense()
# -> any sparse object can be converted back to the standard dense

ts = pd.Series(np.random.randn(10))
ts[2:-2] = np.nan
sts = ts.to_sparse()
print(sts.to_dense())


# Sparse data should have the same dtype as its dense representation. Currently, float64, int64 and booldtypes are supported. 
# Depending on the original dtype, fill_value default changes:
# float64: np.nan; int64: 0, bool: False

s = pd.Series([1, np.nan, np.nan])
print(s)
s.to_sparse()
print(s)

########################################
#### Caveats and Gotchas
########################################

# Pandas follows the numpy convention of raising an error when you try to convert something to a bool.

# if pd.Series([False, True, False]):
#	print 'I am True'
# -> will raise an error

if pd.Series([False, True, False]).any():
	print("I am any")

# To evaluate single-element pandas objects in a Boolean context, use the method .bool():
print(pd.Series([True]).bool())

# Bitwise Boolean operators like == and != will return a Boolean series, which is almost always what is required anyways.
s = pd.Series(range(5))
print(s==4)

#.isin() => returns a Boolean series showing whether each element in the Series is exactly contained in the passed sequence of values.
s = pd.Series(list('abc'))
s = s.isin(['a', 'c', 'e'])
print(s)

# ix indexing capabilities as a concise means of selecting data from a Pandas object:
df = pd.DataFrame(np.random.randn(6, 4), columns=['one', 'two', 'three', 'four'],index=list('abcdef'))
print(df)
print(df.ix[['b', 'c', 'e']])
# completely equivalent in this case to using the reindex method:
df = pd.DataFrame(np.random.randn(6, 4), columns=['one', 'two', 'three', 'four'],index=list('abcdef'))
print(df)
print(df.reindex(['b', 'c', 'e']))

# Some might conclude that ix and reindex are 100% equivalent based on this. 
# This is true except in the case of integer indexing. 
# For example, the above operation can alternatively be expressed as:
df = pd.DataFrame(np.random.randn(6, 4), columns=['one', 'two', 'three', 'four'],index=list('abcdef'))
print(df)
print(df.ix[[1, 2, 4]])
print(df.reindex([1, 2, 4]))
# !!! reindex is strict label indexing only. This can lead to some potentially surprising results in pathological cases where an index contains, e.g. both integers and strings.


