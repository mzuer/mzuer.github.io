---
layout: post
title: "Python - regular expressions basics"
date: 2018-01-02
category: python
tags: [python, regex]
---

Taken from:

<a href="https://www.machinelearningplus.com/python/python-regex-tutorial-examples">https://www.machinelearningplus.com/python/python-regex-tutorial-examples</a>


Main functions used in this tutorial:

*<em>re.compile()</em>

*<em>re.split()</em>

*<em>re.findall()</em>

*<em>re.search()</em>

*<em>re.match()</em>

*<em>re.search().start()</em>

*<em>re.search().end()</em>

*<em>re.match().start()</em>

*<em>re.match().end()</em>

*<em>re.group()</em>


```

### BASIC SYNTAX
# .             One character except new line
# \.            A period. \ escapes a special character.
# \d            One digit
# \D            One non-digit
# \w            One word character including digits
# \W            One non-word character
# \s            One whitespace
# \S            One non-whitespace
# \b            Word boundary
# \n            Newline
# \t            Tab


### MODIFIERS
# $             End of string
# ^             Start of string
# ab|cd         Matches ab or de.
# [ab-d]	      One character of: a, b, c, d
# [^ab-d]	      One character except: a, b, c, d
# ()            Items within parenthesis are retrieved
# (a(bc))       Items within the sub-parenthesis are retrieved

### REPETITIONS
# [ab]{2}       Exactly 2 continuous occurrences of a or b
# [ab]{2,5}     2 to 5 continuous occurrences of a or b
# [ab]{2,}      2 or more continuous occurrences of a or b
# +             One or more
# *             Zero or more
# ?             0 or 1


### PYTHON REGEX FLAGS
# re.I	re.IGNORECASE	ignore case.
# re.M	re.MULTILINE	make begin/end {^, $} consider each line.
# re.S	re.DOTALL	    make . match newline too.
# re.U	re.UNICODE	    make {\w, \W, \b, \B} follow Unicode rules.
# re.L	re.LOCALE	    make {\w, \W, \b, \B} follow locale.
# re.X	re.VERBOSE	    allow comment in regex.

import re

### Ex2: Compile a regular expression pattern that can match at least one or more space characters
regex = re.compile('\s+')

### Ex3: Split a string with unequal spacing
text = """101 COM    Computers
205 MAT   Mathematics
189 ENG   English"""

# version 1: using re.split()
re.split("\s+", text)

# version 2: using compiled pattern [better if used multiple times]
regex = re.compile('\s+')
regex.split(text)

# => if a particular pattern will be used multiple times, better to compile the regular expression

### Ex4: a) Find pattern matches using findall
# extract all the course numbers
text = """101 COM    Computers
205 MAT   Mathematics
189 ENG   English"""

regex_nbr = re.compile('\d+')
regex_nbr.findall(text)
 # ['101', '205', '189']

### Ex4: b) re.findall() vs. re.search() vs. re.match()
# re.findall() also searches for pattern in a text and returns matched positions as a list
# re.search() searches for pattern in a text and returns a "match" object containing starting and ending positions of the 1st occurence
# re.match() also returns a "match" object but requires the pattern to be present at the beginning of the text itself
regex_nbr.search(text)
# <_sre.SRE_Match object; span=(0, 3), match='101'>
regex_nbr.search(text).start()
# 0
regex_nbr.search(text).end()
# 3
regex_nbr.match(text)
# <_sre.SRE_Match object; span=(0, 3), match='101'>
regex_nbr.match(text).start()
# 0
regex_nbr.match(text).end()
# 3

# capture the matched pattern of the first occurence
text2 = """COM    Computers
205 MAT   Mathematics 189"""

text2_match = regex_nbr.search(text2)

text2[text2_match.start():text2_match.end()]
# '205
# or using re.group()
text2_match.group()
# '205

regex_nbr.match(text2)
print(regex_nbr.match(text2))
# None

### Ex5: substitution with regex with regex.sub()
# even out all the extra spaces and put all the words in one single line:
text = """101   COM \t  Computers
205   MAT \t  Mathematics
189   ENG  \t  English"""

re.sub("\s+", "", text)
# equivalent:
regex = re.compile("\s+")
regex.sub("", text)

# to keep new lines:
# -> can be done using negative lookahead (?!\n)
# => it checks for upcoming newline character and excludes it from the pattern
regex = re.compile("((?!\n)\s+)")
regex.sub("", text)

### Ex6: regex groups
# extract number, code and name as separate items
text = """101   COM   Computers
205   MAT   Mathematics
189   ENG    English"""
# without groups, should be done separately
re.findall('[0-9]+', text) # extract the number
re.findall('[A-Z]{3}', text) # extract the code
re.findall('[A-Za-z]{4,}', text) # extract the name
# using a single pattern with groups
course_pattern = '([0-9]+)\s*([A-Z]{3})\s*([A-Za-z]{4,})'
re.findall(course_pattern, text)
# [('101', 'COM', 'Computers'),
#  ('205', 'MAT', 'Mathematics'),
#  ('189', 'ENG', 'English')]

### Ex7: greedy matching
# (greedy matching is the default behaviour)
text = "< body>Regex Greedy Matching Example < /body>"
re.findall('<.*>', text)
# ['< body>Regex Greedy Matching Example < /body>']
# lazy matching = take as little as possible:
re.findall('<.*?>', text)
# ['< body>', '< /body>']
# to extract only the first match:
re.search('<.*?>', text).group()
# '< body>'

### REGULAR EXPRESSIONS EXAMPLES

# 1) any character, except a new line
text = 'machinelearningplus.com'
re.findall('.', text)    # .   Any character except for a new line
#> ['m', 'a', 'c', 'h', 'i', 'n', 'e', 'l', 'e', 'a', 'r', 'n', 'i', 'n', 'g', 'p', 'l', 'u', 's', '.', 'c', 'o', 'm']
re.findall('...', text)
#> ['mac', 'hin', 'ele', 'arn', 'ing', 'plu', 's.c']

# 2) match a period
re.findall("\.", text)

# 3) match anything but a period
re.findall("[^\.]", text)

# 4) match digits
text = '01, Jan 2015'
re.findall("\d", text) # match any digit
# ['0', '1', '2', '0', '1', '5']
re.findall("\d+", text) # match at least one digit
# ['01', '2015']

# 5) match anything but a digit
re.findall("\D", text)
# [',', ' ', 'J', 'a', 'n', ' ']
re.findall("\D+", text)
# [', Jan ']

# 6) match any character, including digits
re.findall("\w+", text)
# ['01', 'Jan', '2015']

# 7) match anything but a character
re.findall("\W+", text)

# 8) match collection of characters
re.findall('[a-zA-Z]+', text)  # -> match any characters inside []

# 9) match something up to 'n' times
re.findall('\d{4}', text)  # -> matches 4 digits
# ['2015']
re.findall('\d{2,4}', text)  # -> matches 2 or 4 digits
# ['01', '2015']

# 10) match 1 or + occurences
re.findall(r'Co+l', 'So Cooool')
# NB: when an "r" or "R" prefix is present, a character following a backslash is included in the string without change
# print("\newline")
# ewline
# print(r"\newline")
# \newline

# 11) match any number of occurences
re.findall("Pi*lani", "Pilani")
# ['Pilani']

# 12) match exactly 0 or 1 occurence
re.findall("Pio?lani", "Pilani")
# ['Pilani']
re.findall("Pi?lani", "Pilani")
# ['Pilani']

# 13) match word boundary
re.findall(r"\btoy", "toy cat")
# ['toy']
re.findall(r"\btoy\b", "toy cat")
# ['toy']
re.findall(r"\btoy", "tolstoy")
# []
re.findall(r"toy\b", "tolstoy")
# ['toy']

### EXERCISES
# Q1. Extract the user id, domain name and suffix from the following email addresses.

emails = """zuck26@facebook.com
page33@google.com
jeff42@amazon.com"""

# solution 1
re.findall(r"(.+)@(.+)\.(.+)", emails)

# solution 2
match_pattern = r'(\w+)@([A-Z0-9]+)\.([A-Z]{2,4})'
re.findall(match_pattern, emails, flags=re.IGNORECASE)


# Q2. Retrieve all the words starting with ‘b’ or ‘B’ from the following text.
text = """Betty bought a bit of butter, But the butter was so bitter, So she bought some better butter, To make the bitter butter better."""

# solution 1
match_pattern = r"\bB.+?\b"
re.findall(match_pattern, text, flags = re.IGNORECASE)

# solution 2
match_pattern = r"\bB\w+"
re.findall(match_pattern, text, flags = re.IGNORECASE)

# Q3. Split the following irregular sentence into words

sentence = """A, very   very; irregular_sentence"""

# match_pattern = r"\b\w+?\b"
# " ".join(re.findall(match_pattern, sentence))
#  'A very very irregular_sentence'
# => wrong, this does not discard "_"

" ".join(re.split('[;,\s_]+', sentence))
# 'A very very irregular sentence'

# Q4. Clean up the following tweet so that it contains only the user’s message.
# That is, remove all URLs, hashtags, mentions, punctuations, RTs and CCs.

tweet = '''Good advice! RT @TheNextWeb: What I would do differently if I was learning to code today http://t.co/lbwej0pxOd cc: @garybernhardt #rstats'''

def clean_tweet(tweet):
    tweet = re.sub('http\S+\s*', '', tweet)     # remove URLs
    tweet = re.sub('RT|cc', '', tweet)          # remove RT and cc
    tweet = re.sub('#\S+', '', tweet)           # remove hashtags
    tweet = re.sub('@\S+', '', tweet)           # remove mentions
    tweet = re.sub('[%s]' % re.escape("""!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"""), '', tweet)  # remove punctuations
    tweet = re.sub('\s+', ' ', tweet)           # remove extra whitespace
    return tweet

clean_tweet(tweet)
# 'Good advice What I would do differently if I was learning to code today '


# Q5. Extract all the text portions between the tags from the following HTML page:
# https://raw.githubusercontent.com/selva86/datasets/master/sample.html

# Code to retrieve the HTML page:
import requests
r = requests.get("https://raw.githubusercontent.com/selva86/datasets/master/sample.html")
r.text  # html text is contained here

re.findall('<.*?>(.*)</.*?>', r.text)
```


