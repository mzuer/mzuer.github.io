---
layout: post
title: "R - single (e.g. <em>&</em>) or double (e.g. <em>&&</em>) logical operators"
date: 2018-04-01
category: R
tags: [R boolean]
---

Shorter form (e.g. <em>&</em>) performs elementwise comparisons.

Longer form (e.g. <em>&&</em>) mainly used in if-clauses, evaluates the first element of each vector and proceeds until the result is determined


```
# Longer form
if ((a==3) && (b==4) && (d==7)) {
}

# -> if (a==3) is NOT true, then R doesn’t need to look whether b==4 or d==7. 
# -> should be faster than with "&"
 
```

Longer form might be useful in case of potentially missing values:

```
if(all(!is.na(x)) && mean(x) > 0) { …
}
# -> the first test with missing values makes sure that you don’t run into trouble with the test on the mean
```

But be careful: to evaluate elements of a vector, shorter form should be used

```
c(TRUE, FALSE, FALSE) & c(TRUE, TRUE, TRUE)
#[1] TRUE FALSE FALSE

c(TRUE, FALSE, FALSE) && c(TRUE, TRUE, TRUE)
#[1] TRUE 
# -> only evaluates the 1st element !
```
 


