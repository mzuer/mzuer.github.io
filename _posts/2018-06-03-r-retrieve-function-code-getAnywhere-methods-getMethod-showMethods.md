---
layout: post
title: "R - retrieve the code of a function using <em>getAnywhere()</em>, <em>methods()</em>, <em>getMethod()</em> and <em>showMethods()</em> functions"
date: 2018-06-03
category: R
tags: R function
---

Retrieve the "hidden" code of function definition

```
mapC 
# standardGeneric for "mapC" defined from package "HiTC"
# function (x, y, ...) 
# standardGeneric("mapC")
# <environment: 0x274e1258>
# Methods may be defined for arguments: x, y
# Use  showMethods("mapC")  for currently available ones.

showMethods("mapC")
# Function: mapC (package HiTC)
# x="HTCexp", y="ANY"
# x="HTCexp", y="HTCexp"
# x="HTClist", y="ANY"

# for S4
getMethod("mapC", "HTCexp")

# for S3
getAnywhere("plot.lm")

getAnywhere("melt")
# 3 differing objects matching ‘melt’ were found
# in the following places
#  package:reshape
#  package:reshape2
#  namespace:reshape
#  namespace:data.table
#   namespace:reshape2
# Use [] to view one of them

getAnywhere("melt")[2]
# function (data, ..., na.rm = FALSE, value.name = "value") 
# {
#    UseMethod("melt", data)
# }
# <environment: namespace:reshape2>	

methods("melt", class="reshape2")
# [1] melt.array       melt.cast_df     melt.cast_matrix melt.data.frame  melt.default     melt.list        melt.matrix     
# [8] melt.table      

reshape2::melt.data.frame

```
