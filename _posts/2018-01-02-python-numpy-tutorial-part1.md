---
layout: post
title: "Python - <em>numpy</em> tutorial (part 1)"
date: 2018-01-02
category: python
tags: [python, numpy, vector, array]
---

Taken from:

<a href="https://www.machinelearningplus.com/python/numpy-tutorial-part1-array-python-examples">https://www.machinelearningplus.com/python/numpy-tutorial-part1-array-python-examples</a>


This tutorial includes examples of usage for the following functions:

* <em>np.array()</em>: to create array
```
<em>np.array(list1) # create 1d array from a list
```

* <em>myarray.astype()</em>: to convert between data types, e.g. <em>myarray.astype("int")</em>

* <em>myarray.tolist()</em>: to convert back to list

* <em>myarray.shape</em>: to get array shape

* <em>myarray.dtype</em>: to get the type of stored items (can only store data of same type)

* <em>myarray.size</em>: to get array size

* <em>myarray.ndim</em>: to get array number of dimension(s)

* <em>np.isnan()</em>: to test if the item is NaN, e.g. <em>np.isnan(myarray)</em>

* <em>np.isinf()</em>: to test if the item is infinite, e.g. <em>np.isinf(myarray)</em>

* <em>np.mean()</em>: to get array mean value, e.g. <em>np.mean(myarray) or <em>myarray.mean()</em>

* <em>np.min()</em>: to get array mean value, e.g. <em>np.min(myarray) or <em>myarray.min()</em>

* <em>np.max()</em>: to get array mean value, e.g. <em>np.max(myarray) or <em>myarray.max()</em>

* <em>np.amin()</em>: to get columnwise (<em>axis=0</em>) or rowwise (<em>axis=1</em>) minimum (by setting <em>axis</em>)
```
myarr
# array([[0, 4, 7],
#        [9, 1, 3]])
np.amin(myarr,axis=0) # columnwise
# array([0, 1, 3])
np.amin(myarr,axis=1) # rowwise
# array([0, 1])
```

* <em>np.apply_over_axis()</em>: to apply other functions along axis

* <em>np.cumsum()</em>: cumulative sum

* <em>myarray.copy()</em>: to create a copy of the array (if simple assignment, will modify the parent array)

* <em>myarray.reshape()</em>: to reshape the array, e.g. <em>myarray.reshape(4,3)</em>

* <em>myarray.flatten()</em>: flatten the array by creating a copy

* <em>myarray.ravel()</em>: flatten the array but without creating a copy (ulterior changes will also affect the parrent array)

* <em>np.arange()</em>: to create numpy array from a range of numbers, e.g. <em>np.arange(5)</em>, <em>np.arange(0,5)</em>, <em>np.arange(0,5,2)</em>


* <em>np.linspace()</em>: to create an array of evenly spaced numbers over a specified interval
```
np.linspace(start=1, stop=50, num=10, dtype=int)
# array([ 1,  6, 11, 17, 22, 28, 33, 39, 44, 50])
```

* <em>np.logspace()</em>: similar to <em>np.linspace()</em>, but in a logarithmic scale (default base value = 10); the given start value is actually base^start and ends with base^stop

* <em>np.set_printoptions(precision=2)</em>: to limit the number of digits after the decimal to 2

* <em>np.zeros()</em>: to create arrays of desired shape with all 0, e.g. <em>np.zeros([2,2])</em> or <em>np.zeros((2,2))</em>

* <em>np.ones()</em>: to create arrays of desired shape with all 0, e.g. <em>np.ones([2,2])</em> or <em>np.ones((2,2))</em>

* <em>np.tile()</em>: to repeats a whole list or array n times
```
np.tile([1,2,3],2)
# array([1, 2, 3, 1, 2, 3])
```

* <em>np.repeat()</em>: to repeat each item n times
```
np.repeat([1,2,3],2)
# array([1, 1, 2, 2, 3, 3])
```

* <em>np.random.rand()</em>: to create array of random numbers between [0,1) with desired shape passed in argument, e.g. <em>np.random.rand(2,2)</em>

* <em>np.random.randn()</em>: to create array of random numbers from normal distribution, e.g. <em>np.random.randn(2,2)</em>

* <em>np.random.randint(a,b)</em>: to create array of random integers between [a,b), e.g. <em>np.random.randint(0, 10, size=[2,2])</em>

* <em>np.random.random()</em>: to generate one random number between [0,1), e.g. <em>np.random.random(size=[2,2])</em>, shape argument passed as a tuple or list; is actually an alias for <em>numpy.random.random_sample</em>; 
similar to <em>np.random.rand()</em> but in this latter shape of desired array passed as separate arguments

* <em>np.random.choice()</em>: to pick items from list with equal or predefined probability
```
# e.g. pick 10 items from a given list
np.random.choice(['a', 'e', 'i', 'o', 'u'], size=10)
# e.g. pick 10 items from a given list with a predefined probability 'p'
np.random.choice(['a', 'e', 'i', 'o', 'u'], size=10, p=[0.3, .1, 0.1, 0.4, 0.1])
```

* <em>np.random.RandomState()</em>: to a create a random state before using random number generation e.g. <em>np.random.RandomState(100)</em>

* <em>np.random.seed()</em>: to set seed for random number generation, e.g. <em>np.random.seed(100)</em>

* <em>np.unique()</em>: to get the unique items; <em>return_counts=True</em> to have the repetition counts of each item

```
import numpy as np

### 2. How to create a numpy array?

# create 1d array from a list
list1 = [0,1,2,3,4]
ar_1d = np.array(list1)

# => key difference between array and list: arrays designd to handle vectorized operations
# list1+2 # => won't work
ar_1d + 2

# create 2d array from list of list
list2 = [[1,2,3],[4,5,6],[7,8,9]]
ar_2d = np.array(list2)

# data type can be specified
ar_2d_f = np.array(list2, dtype="float")

# conversion between data type with astype()
ar_2d_i = ar_2d_f.astype("int")
ar_2d_s = ar_2d_f.astype("int").astype("str")

# => numpy array: unlike lists, elements must be of same data type
# to hold e.g. strings and numbers, store 'object'
ar1d_obj = np.array([1,'a'], dtype='object')

# convert back to list
ar1d_obj.tolist()

# Main differences with lists:
# -> Arrays support vectorised operations
# -> Once an array is created, you cannot change its size.
# (need to create a new array or overwrite the existing one)
# -> An array has one and only one dtype
# -> An equivalent numpy array occupies much less space than a python list of lists.

### 3. How to inspect the size and shape of a numpy array?

# Create a 2d array with 3 rows and 4 columns
list2 = [[1, 2, 3, 4],[3, 4, 5, 6], [5, 6, 7, 8]]
arr2 = np.array(list2, dtype='float')

# shape:
arr2.shape

# dtype:
arr2.dtype

# size
arr2.size

# ndim
arr2.ndim

### 4. How to extract specific items from an array?

# extraction can be done using indexing (starting at 0)
# unlike lists, can accept as many parameters in square brackets as dimensions

# list2[:2,:2] # -> won't work
arr2[:2,:2]

# arrays support boolean indexing
arr2[arr2 > 4]

## 4.1 How to reverse the rows and the whole array?

# with array, should be done along all axes

# reverse only row positions:
arr2[::-1,]

# reverse row and column positions:
arr2[::-1,::-1]

## 4.2 How to represent missing values and infinite?
# -> Missing values can be represented using np.nan object
# -> Infinite with np.inf
arr2[1,1] = np.nan  # not a number
arr2[1,2] = np.inf  # infinite

# Replace nan and inf with -1 (without using arr2 == np.nan)
arr2[np.isnan(arr2) | np.isinf(arr2)] = -1


missing_bool = np.isnan(arr2) | np.isinf(arr2)
arr2[missing_bool] = -1
arr2

## 4.3 How to compute mean, min, max on the ndarray?
arr2.mean()
arr2.min()
arr2.max()

# column wise minimum:
arr2.min(axis=0)
np.amin(arr2, axis=0)

# row wise minimum
arr2.min(axis=1)
np.amin(arr2, axis=1)

# to apply other functions along axis, use:
# np.apply_over_axis()

# cumulative sum:
np.cumsum(arr2)

### 5. How to create a new array from an existing array?
# If a portion of an array is just assigned to another array,
# the new array just created actually refers to the parent array in memory.
# -> any changes to the new array will reflect in the parent array as well.
# To avoid disturbing the parent array, a copy of it should be done using copy().

arr2a = arr2[:2,:2]
arr2a[:1,:1] = 100
# -> will modify arr2
arr2

arr2b = arr2[:2,:2].copy()
arr2b[:1,:1] = 101
# -> arr2 not modified
arr2

### 6. Reshaping and Flattening Multidimensional arrays

# reshape arr2 from 3x4 to 4x3

arr2.reshape(4,3)

## 6.1 What is the difference between flatten() and ravel()?
# 2 ways to implement flattening:

# -> flatten() creates a copy, changing b1 will not affect arr2
b1 = arr2.flatten()
b1[1] = 200
arr2

# -> whereas ravel() does not, changing b2 will modify arr2
b2 = arr2.ravel()
b2[0] = 200
arr2

### 7. How to create sequences, repetitions and random numbers using numpy?

# -> see np.arange()

# Lower limit is 0 be default
np.arange(5)
# array([0, 1, 2, 3, 4])

# 0 to 9
np.arange(0, 10)
# array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

# 0 to 9 with step of 2
np.arange(0, 10, 2)
# array([0, 2, 4, 6, 8])

# 10 to 1, decreasing order
np.arange(10, 0, -1)
# array([10,  9,  8,  7,  6,  5,  4,  3,  2,  1])

# To create an array of exactly 10 numbers between 1 and 50, use np.linspace instead
np.linspace(start=1, stop=50, num=10, dtype=int)
# array([ 1,  6, 11, 17, 22, 28, 33, 39, 44, 50])
# np.linspace -> returns evenly spaced numbers over a specified interval.

# Similar to np.linspace, there is also np.logspace which rises in a logarithmic scale.
# In np.logspace, the given start value is actually base^start and ends with base^stop,
# with a default based value of 10.

# Limit the number of digits after the decimal to 2
np.set_printoptions(precision=2)

# Start at 10^1 and end at 10^50
np.logspace(start=1, stop=50, num=10, base=10)

#> array([  1.00e+01,   2.78e+06,   7.74e+11,   2.15e+17,   5.99e+22,
#>          1.67e+28,   4.64e+33,   1.29e+39,   3.59e+44,   1.00e+50])

# np.zeros() -> create arrays of desired shape with all 0
# np.ones() -> create arrays of desired shape with all 1
np.zeros([2,2])
#> array([[ 0.,  0.],
#>        [ 0.,  0.]])
np.ones([2,2])
#> array([[ 1.,  1.],
#>        [ 1.,  1.]])

## 7.1 How to create repeating sequences?
# np.tile() -> repeats a whole list or array n times.
# np.repeat -> repeats each item n times.

a = [1,2,3]
np.tile(a,2)
# array([1, 2, 3, 1, 2, 3])

np.repeat(a,2)
# array([1, 1, 2, 2, 3, 3])

## 7.2 How to generate random numbers?
# np.random.rand() -> random numbers between [0,1)
# Random numbers between [0,1) of shape 2,2
np.random.rand(2,2)

# np.random.randn() -> random numbers from normal distribution
# Normal distribution with mean=0 and variance=1 of shape 2,2
np.random.randn(2,2)

# np.random.randint(a,b)= -> random integers between [a,b)
# Random integers between [0, 10) of shape 2,2
np.random.randint(0, 10, size=[2,2])

# np.random.random() -> one random number between [0,1)
np.random.random()

# Random numbers between [0,1) of shape 2,2
np.random.random(size=[2,2])

# np.random.random is actually an alias for numpy.random.random_sample.
# like np.random.rand(), generates samples from the uniform distribution on [0, 1).
# Difference: how the arguments are handled.
# np.random.rand -> the length of each dimension of the output array is a separate argument
# np.random.random_sample -> the shape argument is a single tuple.
# np.random.rand(3, 5)
# np.random.random_sample((3, 5))

# np.random.choice() -> pick items from list with equal or predefined probability
# e.g. pick 10 items from a given list
np.random.choice(['a', 'e', 'i', 'o', 'u'], size=10)
# e.g. pick 10 items from a given list with a predefined probability 'p'
print(np.random.choice(['a', 'e', 'i', 'o', 'u'], size=10, p=[0.3, .1, 0.1, 0.4, 0.1]))  # picks more o's


# To have reproducible random numbers every time, set the seed or the random state.
# Once np.random.RandomState is created, all the functions of the np.random module becomes available to
# the created randomstate object.

# Create the random state
rn = np.random.RandomState(100)
rn.rand(2,2)
#> [[ 0.54  0.28]
#>  [ 0.42  0.84]]

# Set the random seed
np.random.seed(100)
np.random.rand(2,2)
#> [[ 0.54  0.28]
#>  [ 0.42  0.84]]

## 7.3 How to get the unique items and the counts?

# np.unique() -> to get the unique items.
# to have the repetition counts of each item, set return_counts=True

np.random.seed(100)
arr_rand = np.random.randint(0, 10, size=10)
arr_rand
 # array([8, 8, 3, 7, 7, 0, 4, 2, 5, 2])

# Get the unique items and their counts
uniqs, counts = np.unique(arr_rand, return_counts=True)
uniqs
# array([0, 2, 3, 4, 5, 7, 8])
counts
 # array([1, 2, 1, 1, 1, 2, 2])
```
