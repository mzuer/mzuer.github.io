---
layout: post
title: "R - S3 objects and generic methods"
date: 2019-05-31
category: R
tags: R function S3 objects
---

### What is <em>factor</em> in R ?

```
x <- factor(c("apple", "orange", "orange", "pear"))
typeof(x)
## [1] "integer"
attributes(x)
## $levels
## [1] "apple"  "orange" "pear"  
## 
## $class
## [1] "factor"
unclass(x)
## [1] 1 2 2 3
## attr(,"levels")
## [1] "apple"  "orange" "pear"
```

-> factors are just integer vectors with some metadata stored as an attribute named levels. 


### Create variable with <em>structure()</em>

```
  structure(x, errors=abs(value), class="errors")
  # equivalent to:
  # attr(x, "errors") <- abs(value)
  # class(x) <- "errors"
  # x
```

### Generic functions 

Many (most?) of the functions you daily use are generics 
(or internal generics, which are internally implemented functions that mostly behave like generics).


```
isS3stdGeneric(print)
## print 
##  TRUE

isS3stdGeneric(mean)
## mean 
## TRUE

.S3PrimitiveGenerics
##  [1] "anyNA"          "as.character"   "as.complex"     "as.double"     
##  [5] "as.environment" "as.integer"     "as.logical"     "as.numeric"    
##  [9] "as.raw"         "c"              "dim"            "dim<-"         
## [13] "dimnames"       "dimnames<-"     "is.array"       "is.finite"     
## [17] "is.infinite"    "is.matrix"      "is.na"          "is.nan"        
## [21] "is.numeric"     "length"         "length<-"       "levels<-"      
## [25] "names"          "names<-"        "rep"            "seq.int"       
## [29] "xtfrm"
```

-> we can write methods for those generics to implement how they behave when they are applied to a particular object class.

A method can be more specific than the generic, but cannot lose generality. Some examples (<em>foo()</em> being a generic function):

- foo(x): method must be foo.bar(x).
- foo(x, y, z): method can be foo.bar(x, y, z) or foo.bar(x, ...)
- foo(x, ...): method can be foo.bar(x, ...) or can be more specific and take some arguments out of the dots foo.bar(x, y, z, ...) 


Example: define <em>print()</em> for the <em>errors</em> objects:

```
print.errors <- function(x, ...) {

}
```


R defines what is called S3 group generics (4 pre-specificed groups): 

1) Group Math: mathematical functions (e.g. <em>abs</em>, <em>min</em>, <em>sqrt</em>, <em>cos</em>)

1) Group Ops: arithmetic operations (e.g.addition, substraction, boolean operators)

1) Group Summary (e.g. <em>all</em>, <em>any</em>, <em>sum</em>, <em>range</em>)

4) Group Complex: functions to work with complex numbers (e.g. Argument, <em>conjugate</em>, real/imaginary parts)



The existence of these groups means that we can simply write a single method for a whole category to provide for all the functions included. 
And this is what the errors package does by implementing Math.errors, Ops.errors and Summary.errors. We can take a glimpse into one of these methods:

```
errors:::Ops.errors

## function (e1, e2) 
## {
##     if (.Generic %in% c("&", "|", "!", "==", "!=", "<", ">", 
##         "<=", ">=")) {
##         warn_once("boolean operators not defined for 'errors' objects, uncertainty dropped", 
##             fun = .Generic, type = "bool")
##         return(NextMethod())
##     }
##     if (!missing(e2)) {
##         coercion <- cond2int(!inherits(e1, "errors"), !inherits(e2, 
##             "errors"))
##         if (coercion) {
##             warn_once("non-'errors' operand automatically coerced to an 'errors' object with no uncertainty", 
##                 fun = "Ops", type = "coercion")
##             switch(coercion, e1 <- set_errors(e1), e2 <- set_errors(e2))
##         }
##     }
##     deriv <- switch(.Generic, `+` = , `-` = if (missing(e2)) {
##         e2 <- NA
##         list(do.call(.Generic, list(1)), NA)
##     } else list(1, do.call(.Generic, list(1))), `*` = list(.v(e2), 
##         .v(e1)), `/` = , `%%` = , `%/%` = list(1/.v(e2), -.v(e1)/.v(e2)^2), 
##         `^` = list(.v(e1)^(.v(e2) - 1) * .v(e2), .v(e1)^.v(e2) * 
##             log(abs(.v(e1)))))
##     propagate(unclass(NextMethod()), e1, e2, deriv[[1]], deriv[[2]])
## }
## 
## 
```


To be able to do different things depending on which one was called: S3 dispatching mechanism sets 

<em>.Generic</em> contains the name of the generic function.
<em>.Method</em> contains the name of the method.
<em>.Class</em> contains the class(es) of the object.

This way, checking .Generic allows us to issue a warning if a non-supported method is called, and then delegate to NextMethod.

Note also that the Ops group is pretty special for two reasons: first, there are unary operators (e.g., -1), so sometimes the second argument is missing, and we need to take that into account; secondly, these operators are commutative, and therefore S3 supports double dispatch in this case.

Finally, Ops.errors addresses all the arithmetic operators in a unified way: it computes two derivatives depending on .Generic and then propagates the uncertainty using an auxiliary function that implements the Taylor Series Method.

### Implement your own generics. 

Implementing a new generic is as easy as defining a function that calls <em>UseMethod()</em> with the name of the generic. 

```
# constructors
circle    <- function(r)    structure(list(r=r),      class="circle")
rectangle <- function(a, b) structure(list(a=a, b=b), class="rectangle")

# generics
perimeter <- function(shape) UseMethod("perimeter")
area      <- function(shape) UseMethod("area")

# methods
print.circle        <- function(x, ...) with(x, cat("r =", r, "\n"))
perimeter.circle    <- function(shape)  with(shape, 2 * pi * r)
area.circle         <- function(shape)  with(shape, pi * r^2)

print.rectangle     <- function(x, ...) with(x, cat("a =", a, ", b =", b, "\n"))
perimeter.rectangle <- function(shape)  with(shape, 2 * (a + b))
area.rectangle      <- function(shape)  with(shape, a * b)

# usage example
(x <- circle(5))

## r = 5

(y <- rectangle(10, 5))

## a = 10 , b = 5

perimeter(x)

## [1] 31.41593

perimeter(y)

## [1] 30

area(x)

## [1] 78.53982

area(y)

## [1] 50
```


### Inheritance


Instead of assigning a single class, there may be multiple classes defined as a character vector. 
When this happens, R dispatches the first class, and subsequent calls to NextMethod look for other methods in the class vector. 
This means that, if we want our object to resemble parent-child relationships, parent classes must go first in the class vector.

```
# constructor
shape <- function(name, ..., color) {
  shape <- do.call(name, list(...))
  shape$color <- color
  structure(shape, class=c("shape", class(shape)))
}

# methods
print.shape <- function(x, ...) {
  cat(x$color, .Class[2], "\n")
  cat("parameters: ")
  NextMethod() # call that particular shape's print method
}

# usage example
(x <- shape("circle", 5, color="red"))

## red circle 
## parameters: r = 5

(y <- shape("rectangle", 10, 5, color="blue"))

## blue rectangle 
## parameters: a = 10 , b = 5

class(x)

## [1] "shape"  "circle"

class(y)

## [1] "shape"     "rectangle"

perimeter(x)

## [1] 31.41593

perimeter(y)

## [1] 30

area(x)

## [1] 78.53982

area(y)

## [1] 50

This is exactly what the package quantities does to combine the functionality of packages errors and units. As we have seen, errors defines uncertainty metadata for R vectors, and units does the same for measurement units. To achieve a complete calculus system, quantities prepends a superclass to be able to orchestrate units and errors while keeping them completely independent.

library(quantities)

## Loading required package: units

## udunits system database from /usr/share/udunits

# start with a units object and add errors
(x <- set_units(1:5, "m"))

## Units: [m]
## [1] 1 2 3 4 5

class(x)

## [1] "units"

(x <- set_errors(x, 0.1))

## Units: [m]
## Errors: 0.1 0.1 0.1 0.1 0.1
## [1] 1 2 3 4 5

class(x)

## [1] "quantities" "units"      "errors"

# start with an errors object and add units
(x <- set_errors(1:5, 0.1))

## Errors: 0.1 0.1 0.1 0.1 0.1
## [1] 1 2 3 4 5

class(x)

## [1] "errors"

(x <- set_units(x, "m"))

## Units: [m]
## Errors: 0.1 0.1 0.1 0.1 0.1
## [1] 1 2 3 4 5

class(x)

## [1] "quantities" "units"      "errors"

# both at the same time
(y <- set_quantities(1:5, "s", 0.1))

## Units: [s]
## Errors: 0.1 0.1 0.1 0.1 0.1
## [1] 1 2 3 4 5

class(x)

## [1] "quantities" "units"      "errors"

# and everything just works
(z <- x / (y*y))

## Units: [m/s^2]
## Errors: 0.223606798 0.055901699 0.024845200 0.013975425 0.008944272
## [1] 1.0000000 0.5000000 0.3333333 0.2500000 0.2000000

correl(x, z)

## [1] 0.4472136 0.4472136 0.4472136 0.4472136 0.4472136

sum(z)

## 2.3(2) [m/s^2]
```



