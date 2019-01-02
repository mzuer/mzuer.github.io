---
layout: post
title: "Python - list comprehension basics"
date: 2018-01-02
category: python
tags: [python, list, vector]
---

Taken from:

<a href="https://www.machinelearningplus.com/python/list-comprehensions-in-python">https://www.machinelearningplus.com/python/list-comprehensions-in-python</a>

```

# https://www.machinelearningplus.com/python/list-comprehensions-in-python/

# Example Type 1: Simple for-loop
# Square each number in mylist and store the result as a list.
mylist = [1,2,3,4,5]
[i **2 for i in mylist]

# Example Type 2: for-loop with conditional filtering
# What if you have an if condition in the for loop? Say, you want to square only the even numbers:
mylist = list(range(1,6))
[i ** 2 for i in mylist if i % 2 == 0]

# Example Type 3: for-loop with ‘if’ and ‘else’ condition
# Problem Statement: In mylist, square the number if its even, else, cube it.
mylist = list(range(1,6))
[i ** 2 if i % 2 == 0 else i ** 3 for i in mylist]   # -> here there is no filter, so put it before the for loop !

# Example Type 4: Multiple for-loops
# Problem Statement: Flatten the matrix mat (a list of lists) keeping only the even numbers.
mat = [[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16]]
[i for mat_row in mat for i in mat_row if i % 2 == 0 ]

# Example Type 5: Paired outputs
# Problem Statement: For each number in list_b, get the number and its position in mylist as a list of tuples.
mylist = [9, 3, 6, 1, 5, 0, 8, 2, 4, 7]
list_b = [6, 4, 6, 1, 2, 2]
[(i, mylist.index(i)) for i in list_b]

# Example Type 6: Dictionary Comprehensions
# Same problem as previous example but output is a dictionary instead of a list of tuples.
{i: mylist.index(i) for i in list_b}

# Example Type 7: Tokenizing sentences into list of words
# Problem Statement: The goal is to tokenize the following 5 sentences into words, excluding the stop words.
sentences = ["a new world record was set",
             "in the holy city of ayodhya",
             "on the eve of diwali on tuesday",
             "with over three lakh diya or earthen lamps",
             "lit up simultaneously on the banks of the sarayu river"]

stopwords = ['for', 'a', 'of', 'the', 'and', 'to', 'in', 'on', 'with']
# version that flattens the list:
[word for sentence in sentences for word in sentence.split(' ') if word not in stopwords]

# version that does not flatten the list:
[[word for word in sentence.split(' ') if word not in stopwords] for sentence in sentences]

##### Question 1. Given a 1D list, negate all elements which are between 3 and 8, using list comprehensions
mylist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[-i if i >= 3 and i <= 8 else i for i in mylist]

#### Question 2: Make a dictionary of the 26 english alphabets mapping each with the corresponding integer.
import string
{a: i+1 for a,i in zip(string.ascii_letters[:26], range(26))}

# Question 3: Replace all alphabets in the string ‘Lee Quan Yew’, by substituting the alphabet with
#     the corresponding numbers, like 1 for ‘a’, 2 for ‘b’ and so on.
import string
d = {a:i+1 for a,i in zip(string.ascii_lowercase, range(26))}
[d.get(a.lower(), ' ') for a in 'Lee Quan Yew']

# Question 4: Get the unique list of words from the following sentences, excluding any stopwords.
sentences = ["The Hubble Space telescope has spotted",
             "a formation of galaxies that resembles",
             "a smiling face in the sky"]
{word.lower() for sentence in sentences for word in sentence.split(' ') if word not in stopwords}

# Question 5: Tokenize the following sentences excluding all stopwords and punctuations.
sentences = ["The Hubble Space telescope has spotted",
             "a formation of galaxies that resembles",
             "a smiling face in the sky",
             "The image taken with the Wide Field Camera",
             "shows a patch of space filled with galaxies",
             "of all shapes, colours and sizes"]
stopwords = ['for', 'a', 'of', 'the', 'and', 'to', 'in', 'on', 'with']
[[word.lower() for word in sentence.split(' ') if word not in stopwords] for sentence in sentences]

# Question 6: Create a list of (word:id) pairs for all words in the following sentences, where id is the sentence index.
sentences = ["The Hubble Space telescope has spotted",
             "a formation of galaxies that resembles",
             "a smiling face in the sky"]
[(word.lower(), i) for i, sentence in enumerate(sentences) for word in sentence.split(' ')]

# Question 7: Print the inner positions of the 64 squares in a chess board,
# replacing the boundary squares with the string ‘—-‘.
[[(i,j) if (i not in (0, 7)) and (j not in (0, 7)) else ('----') for i in range(8)] for j in range(8)]


```

