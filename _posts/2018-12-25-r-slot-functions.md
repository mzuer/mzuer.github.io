---
layout: post
title: "R - <em>slot</em> related functions"
date: 2018-12-25
category: R
tags: R function object class
---

<em>slot</em> and <em>slot</em>-related functions:


For S4 objects, <em>@</em> operator and <em>slot</em> function extract or replace the formally defined slots for the object.




```
# define a class
setClass("track", slots = c(x="numeric", y="numeric"))
myTrack <- new("track", x = -4:4, y = exp(-4:4))
myTrack
# An object of class "track"
# Slot "x":
# [1] -4 -3 -2 -1  0  1  2  3  4
# 
# Slot "y":
# [1]  0.01831564  0.04978707  0.13533528  0.36787944  1.00000000  2.71828183  7.38905610 20.08553692
# [9] 54.59815003

slot(myTrack, "x")
# [1] -4 -3 -2 -1  0  1  2  3  4
myTrack@x
# [1] -4 -3 -2 -1  0  1  2  3  4

slot(myTrack, "y") <- log(slot(myTrack, "y")) # same as myTrack@y <- ...

getSlots("track") # or
#         x         y 
# "numeric" "numeric" 
getSlots(getClass("track"))
#         x         y 
# "numeric" "numeric" 

slotNames(class(myTrack)) # is the same as
slotNames(myTrack)
# [1] "x" "y"
slotNames("track")
# [1] "x" "y"


### other related functions
slot(object, name)
slot(object, name, check = TRUE) <- value
.hasSlot(object, name)

slotNames(x)
getSlots(x)

```


