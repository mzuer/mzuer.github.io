import pandas as pd
import numpy as np


#*************************************************************** pandas TUTORIAL - TUTORIALSPOINT
# Pandas data structures:
# 1) Series: 1D labeled homogeneous array, size-immutable.
# 2) DataFrame: general 2D labeled, size-mutable tabular structure with potentially heterogeneously-typed columns. 
# 3) Panel: general 3D labeled, size-mutable array (can be illustrated as a container of a DataFrame)

# Notes:
# - data frame: index (rows) and columns correspond to axis 0 and 1
# - all Pandas data structures are value mutable (can be changed) and except Series all are size mutable


#===================================================================
# 1) Series 
#===================================================================

############
# 1.a) Series creation
############

# can be created using: 1) array, 2) dict, 3) scalar value or constant

# create Series from array - without user-defined index:
data = np.array(['a', 'b', 'c', 'd'])
s = pd.Series(data)
print(s)

# create Series from array - without defined index:
s= pd.Series(data,index=[100,101,102,103])
print(s)

# create Series from dict (the key is used as index)
data = {'a': 0., 'b': 2.}
s = pd.Series(data)
print(s)

# create a Series from scalar (the value is repeated for all index)
s = pd.Series(5, index = [0,1,2,3])
print(s)

############
# 1.b) Series manipulation
############

# data can be accessed as for array
s = pd.Series(5, index = ['a','b','c','d'])
print(s[1])
# or using the index
print(s[['a']])

############
# 1.c) Series basic functionalities
############

# create a Series with 100 
s = pd.Series(np.random.randn(100))
print(s)

# 1- axes
# => returns the list of the labels of the Series
print("The axes are:")
print(s.axes)

# 2- empty
# => returns a boolean whether the list is object or not
print("Empty:")
print(s.empty)

# 3- ndim
# => returns number of dimensions (by default, Series is 1D)
print("Dimension:")
print(s.ndim)

# 4- size
# => returns the size (length) of a Series
print("Size:")
print(s.size)

# 5- values
# => returns the actual data in the series as an array
print("Actual data:")
print(s.values)

# 6- head
print("First 2 entries:")
print(s.head(2))

# 7- tail
print("Last 2 entries:")
print(s.tail(2))

# 8- dtype
print("dtype stored:")
print(s.dtype) 



############
# 1.d) Working with strings
############

s = pd.Series(['Tom', 'William Rick', 'John', 'Alber@t', np.nan, '1234','Steve Smith'])	
print(s)

# lower() => Converts strings in the Series/Index to lower case.
print(s.str.lower())
# upper() => Converts strings in the Series/Index to upper case.
print(s.str.upper())
# len() => Computes String length(). 
# -> returns the length of each element of the Series
print(s.str.len())
# strip() => Helps strip whitespace(including newline) from each string in the Series/index from both the sides.
s2 = pd.Series(['Tom          ', 'William Rick', '    John', '\nAlber@t', np.nan, '1234','Steve Smith'])	
print(s2)
print(s2.str.strip())
# split(' ') => Splits each string with the given pattern.
print(s.str.split(' '))
# cat(sep=' ') => Concatenates the series/index elements with given separator.
# (will return nan if there is a nan in the Series)
s3 = pd.Series(['Tom', 'William Rick', 'Steve Smith'])	
print(s3.str.cat(sep="-"))
# get_dummies() => Returns the DataFrame with One-Hot Encoded values.
print(s3.str.get_dummies())
# contains(pattern) => Returns a Boolean value True for each element if the substring contains in the element, else False.
print(s3.str.contains("am"))
# replace(a,b) => Replaces the value a with the value b.
print(s3.str.replace("am", "oo"))
# repeat(value) => Repeats each element with specified number of times.
# (the first element will be "TomTom")
print(s3.str.repeat(2))
# count(pattern) => Returns count of appearance of pattern in each element.
print(s3.str.count("l"))
# startswith(pattern) => Returns true if the element in the Series/Index starts with the pattern.
print(s3.str.startswith("T"))
# endswith(pattern) => Returns true if the element in the Series/Index ends with the pattern.
print(s3.str.endswith("m"))
# find(pattern) => Returns the first position of the first occurrence of the pattern.
print(s3.str.find("m"))
# findall(pattern) => Returns a list of all occurrence of the pattern.
print(s3.str.find("i"))
# swapcase() => Swaps the case lower/upper.
print(s3.str.swapcase())
# islower() => Checks whether all characters in each string in the Series/Index in lower case or not. Returns Boolean.
print(s3.str.islower())
# isupper() => Checks whether all characters in each string in the Series/Index in upper case or not. Returns Boolean.
print(s3.str.isupper())
# isnumeric() => Checks whether all characters in each string in the Series/Index are numeric. Returns Boolean.
# (for nan return NaN)
print(s.str.isnumeric())


############
# 1.e) Indexing and selecting
############
# s.loc[indexer] => returns a Scalar value
# .iloc() & .ix() applies the same indexing options and Return value.


