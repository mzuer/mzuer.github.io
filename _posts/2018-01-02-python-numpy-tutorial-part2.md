---
layout: post
title: "Python - <em>numpy</em> tutorial (part 2)"
date: 2018-01-02
category: python
tags: [python, numpy, vector, array]
---

Taken from:

<a href="https://www.machinelearningplus.com/python/numpy-tutorial-python-part2">https://www.machinelearningplus.com/python/numpy-tutorial-python-part2</a>

This tutorial includes examples of usage for the following functions:


* <em>np.array()</em> creates an array, e.g. <em>np.array([1,2])</em>

* <em>np.where()</em>: locates the positions in the array where a given condition holds true, e.g. <em>np.where(my_array > 5)</em>; 
unlike <em>np.take()</em> also accepts 2 more optional arguments x and y, whenever condition is true, 'x' is yielded else 'y'

* <em>np.take()</em>: to extract the values of the given index/indices, e.g. <em>myarray.take(my_indices)</em>

* <em>np.argmax()</em>: location of the maximum value, e.g. <em>np.argmax(my_array)</em>

* <em>np.argmin()</em>: location of the minimum value, e.g. <em>np.argmin(my_array)</em>

* <em>np.genfromtxt()</em>: import datasets from web URLs, handle missing values, multiple delimiters, handle irregular number of columns etc.; 
numpy arrays store data from only one type, so to handle both numbers and text, need to explicitly set <em>dtype</em> argument as <em>"object"</em> or <em>None</em>

* <em>np.loadtxt()</em>: less versatile than <em>np.genfromtxt()</em>, assumes the dataset has no missing values

* <em>np.set_printoptions(suppress=True)</em>: turn off scientific notation

* <em>np.savetxt()</em>: export the array as a csv file

* <em>np.save()</em>: to store a single ndarray object as .npy file

* <em>np.savez()</em>: to store more than 1 ndarray object as .npz file

* <em>np.load()</em>: to load back the saved file

* <em>np.concatenate()</em>: to concatenate 2 numpy arrays (i) (rowise or columnwise by setting <em>axis</em> parameter), e.g. <em>np.concatenate([arr1,arr2],axis=0)</em>
```
arr1 = np.array([[1,2,3],[4,5,6]])
arr2 = np.array([[7,8,9],[10,11,12]])
np.concatenate([arr1,arr2],axis=1)
# array([[ 1,  2,  3,  7,  8,  9],
#        [ 4,  5,  6, 10, 11, 12]])
np.concatenate([arr1,arr2],axis=0)
# array([[ 1,  2,  3],
#        [ 4,  5,  6],
#        [ 7,  8,  9],
#        [10, 11, 12]])
```

* <em>np.vstack()</em> and <em>np.hstack()</em>: to concatenate 2 numpy arrays (ii) vertically or horizontally, e.g. <em>np.hstack([arr1,arr2]</em>

* <em>np.r_ and <em>np.c_: to concatenate 2 numpy arrays (iii) rowwise or columnwise [! usage with square brackets !], e.g. <em>np.r_[arr1,arr2]</em> (same as <em>np.concatenate([arr1,arr2],axis=0)</em> and <em>np.vstack([arr1,arr2])</em>)

* <em>np.zeros()</em>: to create array full of zeros

* <em>np.ones()</em>: to create array full of ones

* <em>np.sort()</em>: to sort all the columns (<em>axis=0</em>) or rows (<em>axis=1</em>) in ascending order independently of eachother

* <em>np.argsort()</em>: to return the index positions of that would make a given 1d array sorted; used to sort an array based on a given row/column
```
# sort arr based on the first column, without altering the rows
arr[np.argsort(arr[:,0])]
# same as
arr[arr[:,0].argsort()]
# to sort in decreasing order, reverse the argsorted index:
sort_idx = arr[:,0].argsort()
arr[sort_idx[::-1]]
# same as
arr[arr[:,0].argsort()[::-1]]
```

* <em>np.lexsort()</em>: to sort an array based on multiple columns; pass a tuple of columns based on which the array should be sorted (column to be sorted first at the RIGHTmost side inside the tuple)

* <em>np.datetime64()</em>: create a <em>datetime64</em> object

* <em>np.timedelta64()</em>: create the timedeltas (individual units of time); more convenient to increase time units

* <em>np.datetime_as_string()</em>: convert <em>dt64</em> to <em>string</em> object

* <em>np.is_busday()</em>: to test if a given date is a business day

* <em>np.busday_offset()</em>: to roll to nearest business day, use <em>roll="forward"</em> or <em>roll="backward"</em> to set direction

* <em>np.arange()</em>: to create an array of given range
```
np.arange(10,15)
array([10, 11, 12, 13, 14])
np.arange(5)
array([0, 1, 2, 3, 4])
```

* <em>np.tolist()</em>: convert numpy array to list; if input is a <em>np.datetime64</em>, converts to <em>datetime.datetime</em>

* <em>np.vectorize()</em>: to make a scalar function work on vectors; optional <em>otypes</em> parameter: provide what the datatype of the output should be; e.g. <em>np.vectorize(my_function, otypes=[float]); my_function(my_array)</em>

* <em>np.apply_along_axis()</em>: apply a function column wise or row wise, e.g. <em>np.apply_along_axis(myfunc, axis=1, arr=arr_x)</em>

* <em>np.searchsorted()</em>: gives the index position at which a number should be inserted in order to keep the array sorted; e.g. <em>np.searchsorted(x, 5, side = "right")</em>

* <em>np.newaxis</em>: insert a new axis (raise array from lower to higher dimension)
```
x = <em>np.arange(5)
# array([0, 1, 2, 3, 4])
x.shape
# (5,)
# Introduce a new column axis
x_col = x[:, np.newaxis]
# array([[0],
#        [1],
#        [2],
#        [3],
#        [4]])
x_col.shape
# (5, 1)
# Introduce a new row axis
x_row = x[np.newaxis, :]
# array([[0, 1, 2, 3, 4]])
x_row.shape
# (1,5)
```

* <em>np.digitize()</em>: return the index position of the bin each element belongs to, e.g.: create the array and bins and get bin allotments
```
x = np.arange(10)
bins = np.array([0, 3, 6, 9])
np.digitize(x, bins)
#> array([1, 1, 1, 2, 2, 2, 3, 3, 3, 4])
```

* <em>np.clip()</em>: cap the numbers within a given cutoff range, e.g. <em>np.clip(myarray, lowerLimit, upperLimit)</em>

* <em>np.histogram()</em>: to get the frequency of occurences; gives the frequency counts of the bins

* <em>np.bincount()</em>: to get the frequency of occurences;, unlike <em>np.histogram()</em>, gives the frequency count of all the elements in the range of the array between the min and max values (also includes the values that did not occur)



```
import numpy as np

### 1. How to get index locations that satisfy a given condition using np.where?
# -> np.where(): locates the positions in the array where a given condition holds true.
arr_rand = np.array([8, 8, 3, 7, 7, 0, 4, 2, 5, 2])
# Positions where value > 5
index_gt5 = np.where(arr_rand > 5)

# .take(): to extract the values
arr_rand.take(index_gt5)
#> array([[8, 8, 7, 7]])

# np.where accepts 2 more optional arguments x and y.
# Whenever condition is true, ‘x’ is yielded else ‘y’.
np.where(arr_rand > 5, "gt5", "le5")
# array(['gt5', 'gt5', 'le5', 'gt5', 'gt5', 'le5', 'le5', 'le5', 'le5','le5'], dtype='<U3')

# -> np.argmax(): location of the maximum value
np.argmax(arr_rand)

# -> np.argmin(): location of the minimum value
np.argmin(arr_rand)


### 2. How to import and export data as a csv file?

# -> np.genfromtxt(): can import datasets from web URLs, handle missing values, multiple delimiters,
# handle irregular number of columns etc.

# -> np.loadtxt(): less versatile, assumes the dataset has no missing values.

# Turn off scientific notation
np.set_printoptions(suppress=True)

# Import data from csv file url
 # Since all elements in a numpy array should be of the same data type,
# the last column which is a text will be imported as a ‘nan’ by default.
# -> "filling_values" argument can be used to replace the missing values with something else.
path = 'https://raw.githubusercontent.com/selva86/datasets/master/Auto.csv'
data = np.genfromtxt(path, delimiter=',', skip_header=1, filling_values=-999, dtype='float')
data[:3]  # see first 3 rows


# all values in last column has the same value ‘-999’ because of dtype="float".
# The last column in the file contained text values and since all the values in a numpy array
#  has to be of the same `dtype`, `np.genfromtxt` didn’t know how to convert it to a float.

## 2.1 How to handle datasets that has both numbers and text columns?
# -> either set the dtype as ‘object’ or as None.
# data2 = np.genfromtxt(path, delimiter=',', skip_header=1, dtype='object')
data2 = np.genfromtxt(path, delimiter=',', skip_header=1, dtype=None)
data2[:3]  # see first 3 rows

# -> np.savetxt(): export the array as a csv file
# np.savetxt("out.csv", data, delimiter=",")


### 3. How to save and load numpy objects?
# -> .npy and .npz file types

# -> np.save(): to store a single ndarray object as .npy file
# -> np.savez(): to store more than 1 ndarray object as .npz file
# -> np.load(): to load back the saved file

# Save single numpy array object as .npy file
# np.save('myarray.npy', arr2d)

# Save multile numy arrays as a .npz file
# np.savez('array.npz', arr2d_f, arr2d_b)

# Load back a .npy file
# a = np.load('myarray.npy')

# Load back the .npz file.
# b = np.load('array.npz')
# b['arr_0']


### 4. How to concatenate two numpy arrays columnwise and row wise
# 3 different ways of concatenating two or more numpy arrays (same output):

# 1) np.concatenate() (by changing "axis" parameter to 0 or 1)
# 2) np.vstack() (concatenate vertically), np.hstack() (concatenate horizontally)
# 3) np.r_ (concatenate rowwise), np.c_ (concatenate columnwise) [! use square brackets to stack arrays !]

a = np.zeros([4, 4])
b = np.ones([4, 4])

# vertical stack (=rowwise)
np.concatenate([a,b],axis=0)
np.vstack([a,b])
np.r_[a,b]

# horizontal stack (=columnwise)
np.concatenate([a,b], axis=1)
np.hstack([a,b])
np.c_[a,b]

# NB: np.r_ can also be used to create more complex number sequences in 1d arrays.
np.r_[[1,2,3], 0, 0, [4,5,6]]
#> array([1, 2, 3, 0, 0, 4, 5, 6])

### 5. How to sort a numpy array based on one or more columns?

arr = np.random.randint(1,6, size=[3, 5])
# array([[5, 4, 5, 3, 3],
#        [5, 3, 5, 2, 3],
#        [3, 1, 3, 3, 4]])

#-> np.sort(axis=0): all the columns will be sorted in ascending order independent of eachother,
# effectively compromising the integrity of the row items.

# Sort each columns (axis=0):
np.sort(arr, axis=0)
# array([[3, 1, 3, 2, 3],
#        [5, 3, 5, 3, 3],
#        [5, 4, 5, 3, 4]])

# Sort each rows (axis=1)
np.sort(arr, axis=1)
# array([[3, 3, 4, 5, 5],
#        [2, 3, 3, 5, 5],
#        [1, 3, 3, 3, 4]])

## 5.1 How to sort a numpy array based on 1 column using argsort?

# -> np.argsort(): returns the index positions of that would make a given 1d array sorted.
x = np.array([1, 10, 5, 2, 8, 9])
np.argsort(x)
#> [0 3 2 4 5 1]
x[np.argsort(x)]
#> array([ 1,  2,  5,  8,  9, 10])

# sort arr based on the first column, without altering the rows
arr[np.argsort(arr[:,0])]
# same as
arr[arr[:,0].argsort()]

# to sort in decreasing order, reverse the argsorted index:
sort_idx = arr[:,0].argsort()
arr[sort_idx[::-1]]
# same as
arr[arr[:,0].argsort()[::-1]]

## 5.2 How to sort a numpy array based on 2 or more columns?

# -> np.lexsort(): pass a tuple of columns based on which the array should be sorted.
#                 (column to be sorted first at the RIGHTmost side inside the tuple)

# Sort by column 0, then by column 1
lexsorted_index = np.lexsort((arr[:, 1], arr[:, 0]))
arr[lexsorted_index]


### 6. Working with dates

# implemented through the np.datetime64 object which supports a precision till nanoseconds
# can be created using a standard YYYY-MM-DD formatted date strings

#-> np.datetime64(): create a datetime64 object
# hours, minutes, seconds till nanoseconds can be passed as well
date64 = np.datetime64('2018-02-04 23:10:10')
date64
#> numpy.datetime64('2018-02-04T23:10:10')

# Drop the time part from the datetime64 object
dt64 = np.datetime64(date64, 'D')
dt64
#> numpy.datetime64('2018-02-04')

# By default, add a number increases the number of days.
# To increase any other time unit timedelta object is much convenient.

#-> np.timedelta64(): create the timedeltas (individual units of time)
tenminutes = np.timedelta64(10, 'm')  # 10 minutes
tenseconds = np.timedelta64(10, 's')  # 10 seconds
tennanoseconds = np.timedelta64(10, 'ns')  # 10 nanoseconds

# add 10 days
dt64 + 10
# add 10 minutes
dt64 + tenminutes
# add 10 seconds
dt64 + tenseconds
# add 10 nanoseconds
dt64 + tennanoseconds

#-> np.datetime_as_string(): convert dt64 to string
np.datetime_as_string(dt64)


#-> np.is_busday(): test if a given date is a business day
np.is_busday(dt64)

#-> np.busday_offset(): roll to nearest business day, use roll="forward" or roll="backward" to set direction
# add 2 business days, rolling forward to nearest business day
np.busday_offset(dt64, 2, roll='forward')
# add 2 business days, rolling backward to nearest business day
np.busday_offset(dt64, 2, roll='backward')


## 6.1 How to create a sequence of dates?

#-> np.arange():
dates = np.arange(np.datetime64('2018-02-01'), np.datetime64('2018-02-10'))
#> ['2018-02-01' '2018-02-02' '2018-02-03' '2018-02-04' '2018-02-05'
#>  '2018-02-06' '2018-02-07' '2018-02-08' '2018-02-09']

# check if its a business day:
np.is_busday(dates)
# array([ True,  True, False, False,  True,  True,  True,  True,  True], dtype=bool)

## 6.2 How to convert numpy.datetime64 to datetime.datetime object?

# -> tolist(): convert np.datetime64 to datetime.datetime
import datetime
dt = dt64.tolist()
dt
#> datetime.date(2018, 2, 4)

# with datetime.date object: more facilities to extract the day of month, month of year etc.
# e.g.:
print('Year: ', dt.year)
print('Day of month: ', dt.day)
print('Month of year: ', dt.month)
print('Day of Week: ', dt.weekday())

### 7. Advanced numpy functions
# 7.1 vectorize – Make a scalar function work on vectors

# e.g.:
# Define a scalar function
def foo(x):
    if x % 2 == 1:
        return x**2
    else:
        return x/2

# works on a scalar:
foo(10)
# 5.0
foo(11)
# 121

# won't work on array
# foo([10,11]) # -> error
# -> vectorize the function !

foo_v = np.vectorize(foo, otypes=[float])
foo_v([10,11])
# array([  5., 121.])

# optional "otypes" parameter: provide what the datatype of the output should be.
# -> makes the vectorized function run faster.

## 7.2 apply_along_axis – Apply a function column wise or row wise
np.random.seed(100)
arr_x = np.random.randint(1,10,size=[4,6])
arr_x  # 4x6
# array([[9, 9, 4, 8, 8, 1],
#        [5, 3, 6, 3, 3, 3],
#        [2, 1, 9, 5, 1, 7],
#        [3, 5, 2, 6, 4, 5]])

# e.g. How to find the difference of the maximum and the minimum value in each row?
# -> use np.apply_along_axis()
# It takes as arguments:
#     Function that works on a 1D vector (fund1d)
#     Axis along which to apply func1d. For a 2D array, 1 is row wise and 0 is column wise.
#     Array on which func1d should be applied.

#-> define the function that works on 1D vector
def max_minus_min(x):
    return np.max(x) - np.min(x)

#-> apply along the rows:
np.apply_along_axis(max_minus_min, 1, arr=arr_x)
# array([8, 3, 8, 4])

# -> apply along the columns
np.apply_along_axis(max_minus_min, 0, arr=arr_x)


## 7.3 searchsorted – Find the location to insert so the array will remain sorted

#-> np.searchsorted(): gives the index position at which a number should be inserted in order to keep the array sorted.
np.arange(10)
# e.g. where to insert 5 (from left):
np.searchsorted(x, 5)
# e.g. where to insert 5 (from right):
np.searchsorted(x, 5, side = "right")

#-> can be used to do sampling elements with probabilities.
#-> It’s much faster than np.choice.
#e.g.: randomly choose an item from a list based on a predefined probability
lst = range(10000)  # the list
probs = np.random.random(10000)
probs /= probs.sum()  # probabilities

lst[np.searchsorted(probs.cumsum(), np.random.random())]
# faster than
np.random.choice(lst, p=probs)

## 7.4 How to add a new axis to a numpy array?
# (e.g. convert a 1D array into a 2D array without adding any additional data;
# cam be used to handle a 1D array as a single column in a csv file, or
# to concatenate it with another array of similar shape)

#-> np.newaxis: insert a new axis (raise array from lower to higher dimension)
x = np.arange(5)
# array([0, 1, 2, 3, 4])
x.shape
# (5,)

# Introduce a new column axis
x_col = x[:, np.newaxis]
# array([[0],
#        [1],
#        [2],
#        [3],
#        [4]])
x_col.shape
# (5, 1)

# Introduce a new row axis
x_row = x[np.newaxis, :]
# array([[0, 1, 2, 3, 4]])
x_row.shape
# (1,5)

### 7.5 More Useful Functions

#-> np.digitize(): return the index position of the bin each element belongs to.
# e.g.: create the array and bins and get bin allotments
x = np.arange(10)
bins = np.array([0, 3, 6, 9])
np.digitize(x, bins)
#> array([1, 1, 1, 2, 2, 2, 3, 3, 3, 4])

#-> np.clip(): cap the numbers within a given cutoff range.
# All number lesser than the lower limit will be replaced by the lower limit.
# Same applies to the upper limit also.
# e.g.: cap all elements of x to lie between 3 and 8
np.clip(x, 3, 8)
#> array([3, 3, 3, 3, 4, 5, 6, 7, 8, 8])

#-> np.histogram() and np.bincount(): gives the frequency of occurences
# Difference:
#-> histogram(): gives the frequency counts of the bins,
#-> bincount(): gives the frequency count of all the elements in the range of the array between the min and max values.
#                Including the values that did not occur.

# np.bincount example
x = np.array([1,1,2,2,2,4,4,5,6,6,6]) # doesn't need to be sorted
np.bincount(x) # 0 occurs 0 times, 1 occurs 2 times, 2 occurs thrice, 3 occurs 0 times, ...
# array([0, 2, 3, 0, 2, 1, 3])
# -> np.bincount() also includes the values that did not occur

# np.histogram example
np.histogram(x, [0, 2, 4, 6, 8])
# (array([2, 3, 3, 3]), array([0, 2, 4, 6, 8]))
counts, bins = np.histogram(x, [0, 2, 4, 6, 8])



```
