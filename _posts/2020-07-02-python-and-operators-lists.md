---
layout: post
title: "R - <em>and</em> and <em>&</em> in the context of lists and numpy arrays"
date: 2020-07-02
category: python
tags: [python, boolean, operators]
---

https://stackoverflow.com/questions/22646463/and-boolean-vs-bitwise-why-difference-in-behavior-with-lists-vs-nump

```{python}
mylist1 = [True,  True,  True, False,  True]
mylist2 = [False, True, False,  True, False]

>>> len(mylist1) == len(mylist2)
True

# ---- Example 1 ----
>>> mylist1 and mylist2
[False, True, False, True, False]
# I would have expected [False, True, False, False, False]

# ---- Example 2 ----
>>> mylist1 & mylist2
TypeError: unsupported operand type(s) for &: 'list' and 'list'
# Why not just like example 1?

>>> import numpy as np

# ---- Example 3 ----
>>> np.array(mylist1) and np.array(mylist2)
ValueError: The truth value of an array with more than one element is ambiguous. Use a.any() or a.all()
# Why not just like Example 4?

# ---- Example 4 ----
>>> np.array(mylist1) & np.array(mylist2)
array([False,  True, False, False, False], dtype=bool)
# This is the output I was expecting!

#, & is an operator like any other, like + for example. It can be defined for a type by defining a special method on that class.
# list does not define it

# In numpy & is equal to np.bitwise_and
# x & y
#    Does a "bitwise and". Each bit of the output is 1 if the corresponding bit of x AND of y is 1, otherwise it's 0. 
# they operate on numbers (normally), but instead of treating that number as if it were a single value, they treat it as if it were a string of bits, written in twos-complement binary. 

#empty built-in objects are typically treated as logically False while non-empty built-ins are logically True. 

# # ---- Example 1 ----
# >>> mylist1 and mylist2
# [False, True, False, True, False]
# # I would have expected [False, True, False, False, False]
# So in Example 1, the first list is non-empty and therefore logically True, so the truth value of the and is the same as that of the second list. (In our case, the second list is non-empty and therefore logically True, but identifying that would require an unnecessary step of calculation.)


# # ---- Example 2 ----
# >>> mylist1 & mylist2
# TypeError: unsupported operand type(s) for &: 'list' and 'list'
# # Why not just like example 1?

# For example 2, lists cannot meaningfully be combined in a bitwise fashion because they can contain arbitrary unlike elements. 
# Things that can be combined bitwise include: Trues and Falses, integers.


# >>> import numpy as np

# # ---- Example 3 ----
# >>> np.array(mylist1) and np.array(mylist2)
# ValueError: The truth value of an array with more than one element is ambiguous. Use a.any() or a.all()
# # Why not just like Example 4?

# Example 3 fails because NumPy arrays (of length > 1) have no truth value as this prevents vector-based logic confusion.
# try to evaluate bool(

# # ---- Example 4 ----
# >>> np.array(mylist1) & np.array(mylist2)
# array([False,  True, False, False, False], dtype=bool)
# # This is the output I was expecting!
# Example 4 is simply a vectorized bit and operation.
# NumPy objects, by contrast, support vectorized calculations. That is, they let you perform the same operations on multiple pieces of data.


#->      If you are not dealing with arrays and are not performing math manipulations of integers, you probably want and.
#->  If you have vectors of truth values that you wish to combine, use numpy with &.
```


