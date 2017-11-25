---
layout: post
title: "R - C++ in R by sourcing a cpp file"
date: 2017-11-25
category: R
tags: [R, Rcpp, C++]
---

Source the file and call the function in R:

```
#=============================================
# Source the cpp file and use the functions in R 
#=============================================

sourceCpp("essai.cpp")
```

Write definition of the function(s) in a cpp file:

```
#=============================================
# C++ code in a cpp file
#=============================================

// [[Rcpp::plugins(cpp11)]]
#include <Rcpp.h>
#include < unordered_set>
using namespace Rcpp;

//for each function to make it available, need to prefix with [[Rcpp::export]]

// [[Rcpp::export]]
double meanC(NumericVector x)
{
	int n  = x.size();
	double total = 0;

	for(int i = 0; i < n; i++)
	{
		total += x[i];
	}
	return total/n;
}

// you can embed R code in special C++ comment blocks (may be convenient to test some code); is run when running sourceCpp(...)

/*** R
# This is R code
meanC(c(1,2,3,4))
*/


// [[Rcpp::export]]
bool f3(LogicalVector x){
	int n = x.size();
	for(int i = 0; i < n; i++)
	{
		if(x[i]) return true;
	}
	return false;
}


/*
	Scalar classes:
	- int
	- double
	- bool
	- String

	Vector classes:
	- IntegerVector
	- NumericVector
	- LogicalVector
	- CharacterVector
	
	Matrix classes
	- IntegerMatrix
	- NumericMatrix
	- LogicalMatrix
	- CharacterMatrix
*/



// In Rcpp, access R object attributes: can be queried and modified using .attr()
// .names() is an alias for the name attribute
// ::create() class method to create an R vector from C++ scalar values


// [[Rcpp::export]]
NumericVector attribs()
{
	NumericVector out = NumericVector::create(1,2,3);
	out.names() = CharacterVector::create("a", "b", "c");
	out.attr("my-attr") = "my-value";
	out.attr("class") = "my-class;
	return out;
}


/* 
 List and data frame
*/

// if the list has known structure, components can be extracted and converted using as<>

// [[Rcpp::export]]
double mpe(List mod)
{
	if(!mod.inherits("lm")) stop("Input must be a linear model");

	NumericVector resid = as<NumericVector>(mod["residuals"]);
	NumericVector fitted = as<NumericVector>(mod["fitted.values"]);

	int n = resid.size();
	double err = 0;
	for(int i = 0; i < n; i++)
	{
		err += resid[i] / (fitted[i] + resid[i]);
	}
	return err/n;
}


/*
 Function
*/


// [[Rcpp::export]]
RObject callWithOne(Function f)
{
	return f(1);
}
// call example: callWithOne(paste)


// [[Rcpp::export]]

List lapply1(List input, Function f)
{
	int n = input.size();
	List out(n);

	for(int i = 0; i < n; i++)
	{
		out[i] = f(input[i]);
	}

	return out;
}

// call example: f("y", 1)

// to use named argument: f(_["_x"] = "y", _["value"] = 1)

/*
 Missing scalars
*/

// [[Rcpp::export]]
List scalar_missings()
{
	int int_s = NA_INTEGER;
	String chr_s = NA_STRING;
	bool lgl_s = NA_LOGICAL;
	double num_s = NA_REAL;

	return List::create(int_s, chr_s, lgl_s, num_s);
}

/*
NaN
*/

evalCpp("NAN == 1")  // FALSE
evalCpp("NAN == NAN") // FALSE
// NAN propagates in numeric context:
evalCpp("NAN + 1" // NaN)


/*
 Missing values in vectors
*/

// should be of correct type

// [[Rcpp::export]]

List missing_sampler() {
  return List::create(
    NumericVector::create(NA_REAL),
    IntegerVector::create(NA_INTEGER),
    LogicalVector::create(NA_LOGICAL),
    CharacterVector::create(NA_STRING));
}

/*
 Check for missing values with is_na()
*/

// [[Rcpp::export]]

LogicalVector is_naC(NumericVector x) {
  int n = x.size();
  LogicalVector out(n);

  for (int i = 0; i < n; ++i) {
    out[i] = NumericVector::is_na(x[i]);
  }
  return out;
}

/*
	Rcpp sugars
*/

// sqrt(), pow()
// .is_true(), .is_false(), .is_na()

// [[Rcpp::export]]
bool any_naC(NumericVector x) {
  return is_true(any(is_na(x)));
}

// C++ functions that mimick R functions

// Math functions: abs(), acos(), asin(), atan(), beta(), ceil(), ceiling(), choose(), cos(), cosh(), digamma(), exp(), expm1(), factorial(), floor(), gamma(), lbeta(), lchoose(), 
//                 lfactorial(), lgamma(), log(), log10(), log1p(), pentagamma(), psigamma(), round(), signif(), sin(), sinh(), sqrt(), tan(), tanh(), tetragamma(), trigamma(), trunc().

// Scalar summaries: mean(), min(), max(), sum(), sd(), and (for vectors) var().

// Vector summaries: cumsum(), diff(), pmin(), and pmax().

// Finding values: match(), self_match(), which_max(), which_min().

// Dealing with duplicates: duplicated(), unique().

// Standard distributions: d/q/p/r.

//////////////////////////////////////////////// USING THE STL

/*
 Iterators
*/
// [[Rcpp::export]]
double sum3(NumericVector x) {
  double total = 0;
  
  NumericVector::iterator it;
  for(it = x.begin(); it != x.end(); ++it) {
    total += *it;
  }
  return total;
}


// .accumulate(): takes a starting and an ending iterator, and adds up all the values in the vector. The third argument to accumulate gives the initial value.

// [[Rcpp::export]]
double sum4(NumericVector x) {
  return std::accumulate(x.begin(), x.end(), 0.0);
}

// <algorithm> header provides large number of algorithms working with iterators

// [[Rcpp::export]]
IntegerVector findInterval2(NumericVector x, NumericVector breaks) {
  IntegerVector out(x.size());

  NumericVector::iterator it, pos;
  IntegerVector::iterator out_it;

  for(it = x.begin(), out_it = out.begin(); it != x.end(); 
      ++it, ++out_it) {
    pos = std::upper_bound(breaks.begin(), breaks.end(), *it);
    *out_it = std::distance(breaks.begin(), pos);
  }

  return out;
}

/* 
 other STL data structures
*/

// array, bitset, list, forward_list, map, multimap, multiset, priority_queue, queue, dequeue, set, stack, unordered_map, unordered_set, unordered_multimap, unordered_multiset, and vector

/*
  Vector
*/
// !!! need to add: [[Rcpp::plugins(cpp11)]] and #include <unordered_set> at the top of the file

// example: implementation run length encoding (rle()). It produces two vectors of output: a vector of values, and a vector lengths giving how many times each element is repeated. 

// [[Rcpp::export]]
List rleC(NumericVector x)
{
	std::vector<int> lengths;
	std::vector<double> values;

	// initialize first values	
	int i = 0;
	double prev = x[0];
	values.push_back(prev);
	lengths.push_back(1);

	NumericVector:: iterator it;
	for(it = x.begin() + 1; it != x.end(); it++)
	{
		if(prev == *it)
		{
			lengths[i]++;
		} else
		{
			values.push_back(*it);
			lengths.push_back(1);
			i++
			prev = *it;
		}
	}
	return List::create(_["lengths"] = lengths, _["values"] = values);
}

/* 
 Set
*/
// seen.insert(x[i]).second. 
// -> insert() returns a pair: 
//								1) the .first value is an iterator that points to element 
//								2) the .second value is a boolean that’s true if the value was a new addition to the set.

// [[Rcpp::export]]
LogicalVector duplicatedC(IntegerVector x)
{
	std::unordered_set<int> seen;
	int n = x.size();
	LogicalVector out(n);
	
	for(int i = 0; i < n; i++) 
	{
		out[i] = !seen.insert(x[i]).second;
	}
	return out;
}


/* 
 Map
*/


// example: implementation of table()

// [[Rcpp::export]]
std::map<double, int> tableC(NumericVector x)
{
	std::map<double, int> counts;

	int n = x.size();

	for(int i = 0; i < n; i ++)
	{
		counts[x[i]]++;
	}

	return counts;
}


```




