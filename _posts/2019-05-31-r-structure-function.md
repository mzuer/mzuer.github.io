---
layout: post
title: "R - create objects with <em>structure()</em>"
date: 2019-05-31
category: R
tags: R function objects 
---

https://www.r-bloggers.com/creating-data-frame-using-structure-function-in-r/


<em>structure()</em> is part of base R language library.
All objects created using <em>structure()</em> – whether homogeneous (matrix, vector) or heterogeneous (data.frame, list) – have additional metadata information stored, using attributes. 

### Examples of usage

```
dd <- structure(list( 
         year = c(2001, 2002, 2004, 2006) 
        ,length_days = c(366.3240, 365.4124, 366.5323423, 364.9573234)) 
        ,.Names = c("year", "length of days") 
        ,row.names = c(NA, -4L) 
        ,class = "data.frame")
```



```
just_vector <- structure(1:10, comment = "This is my simple 
                                       vector with info")

# to get the information back
attributes(just_vector)
$`comment`
[1] "This is my simple vector with info"
```


The following would create a data.frame (heterogeneous) with several steps:

```
year <- c(1999, 2002, 2005, 2008)
pollution <- c(346.82,134.308821199349, 130.430379885892, 88.275457392443)
dd2 <- data.frame(year,pollution)
dd2$year <- as.factor(dd2$year)
```

Using structure, simpler and faster:

```
dd <- structure(list( 
   year = as.factor(c(2001, 2002, 2004, 2006))
  ,length_days = c(366.3240, 365.4124, 366.5323423, 364.9573234)) 
  ,.Names = c("year", "length of days") 
  ,row.names = c(NA, -4L) 
  ,class = "data.frame")
```

Constructing data-frame with additional attributes and comments.

```
dd3 <- structure(list(
   v1 = as.factor(c(2001, 2002, 2004, 2006))
  ,v2 = I(c(2001, 2002, 2004, 2006))
  ,v3 = ordered(c(2001, 2002, 2004, 2006))
  ,v4 = as.double(c(366.3240, 365.4124, 366.5323423, 364.9573234)))
  ,.Names = c("year", "AsIs Year","yearO", "length of days")
  ,.typeOf = c("factor", "numeric", "ordered","numeric")
  ,row.names = c(NA, -4L)
  ,class = "data.frame"
  ,comment = "Ordered YearO for categorical analysis and other variables")

attributes(dd3)$comment
attr(dd3, which="comment")
```


Nesting lists within lists can also be done, or even preserving the original data-sets as sub-list, 
hidden from the dataframe, can also be an option.




