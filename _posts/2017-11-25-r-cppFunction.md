---
layout: post
title: "R - C++ in R with <em>cppFunction()</em>"
date: 2017-11-25
category: R
tags: [R, Rcpp, C++]
---

Write a C++ function directly in R script

```
#=============================================
# C++ code directly in R script with cppFunction()
#=============================================

library(Rcpp)

### function takes in and returns single numeric
cppFunction('int add(int x, int y, int z) {
            int sum = x + y + z;
            return sum;
            }')
add(1,2,3)


### function takes in and returns vector
cppFunction('NumericVector pdistC(double x, NumericVector ys){
            int n = ys.size();
            NumericVector out(n);
            
            for(int i = 0; i < n; i++){
              out[i] = sqrt(pow(ys[i] - x, 2.0));
            }
            return out;
            }')

pdistC(1, c(1,2,3))


### matrix in, vector out
# ! object.nrow() object.ncol() => to get the dim
# subset matrix element matrix(i,j) => () and not []
cppFunction('NumericVector rowSumsC(NumericMatrix x){
            int nrow = x.nrow(), ncol = x.ncol();
            NumericVector out(nrow);
            
            for(int i = 0; i < nrow; i++){
              double total = 0;
              for(int j = 0; j < ncol; j++){
                total += x(i,j);
              }
              out[i] = total;
            }
            return out;
          }')

x <- matrix(sample(100), 10)
rowSumsC(x)
```




