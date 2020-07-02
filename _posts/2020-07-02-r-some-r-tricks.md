---
layout: post
title: "R - some R tricks: <em>sloop</em>, <em>microbenchmark()</em> and <em>gc()</em>"
date: 2020-07-02
category: R
tags: R function package classes
---

Some tricks from https://eranraviv.com/r-tips-tricks-utilities/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+REranRaviv+%28R+%E2%80%93+Eran+Raviv%29

##### sloop

Have a look at the sloop package, maintained by Hadley Wickham (that alone is a reason). Use the function s3_methods_generic to get a nice table with some relevant information:

```
# install.packages("sloop")
library(sloop)
citation("sloop")
s3_methods_generic("mean")
# s3_methods_generic("as.data.frame")
# A tibble: 10 x 4
#...
``` 

You can use the above to check if there exists a method for the class you are working with. If there is, you can help R by specifying that method directly. Do that and you gain, sometimes meaningfully so, a speed advantage. Let’s see how it works in couple of toy cases. One with a Date class and one with a numeric class.


##### microbenchmark
 
``` 
# Now something more standard
x <- runif(1000) # simulate 1000 from random uniform
bench <-  microbenchmark( mean(x), mean.default(x) )
print(bench)
#             expr   min    lq     mean median    uq    max neval
#1         mean(x) 4.529 5.133 7.113611  7.548 8.453 44.376  1000
#2 mean.default(x) 2.113 2.416 3.148788  3.321 3.623  9.963  1000
``` 

##### gc

Memory management

Use the gc function; gc stands for garbage collection. It frees up memory by, well, collecting garbage objects from your workspace and trashing them. I at least, need to do this often.
heta function


