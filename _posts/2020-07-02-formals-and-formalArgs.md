#---
layout: post
title: "R - <em>formals()</em> and <em>formalArgs()</em>: access formal arguments of a function"
date: 2020-07-02
category: R
tags: [R, function]
---

Get or set the formal arguments of a function.

<em>formals</em> returns the formal argument list of the function specified, as a pairlist, or NULL for a non-function or primitive.

```

## If you just want the names of the arguments, use formalArgs instead.
names(formals(lm))
# [1] "formula"     "data"        "subset"      "weights"     "na.action"   "method"      "model"       "x"           "y"          
## [10] "qr"          "singular.ok" "contrasts"   "offset"      "..."        

methods:: formalArgs(lm)     # same
##  [1] "formula"     "data"        "subset"      "weights"     "na.action"   "method"      "model"       "x"           "y"          
## [10] "qr"          "singular.ok" "contrasts"   "offset"      "..."        
 

## formals returns a pairlist. Arguments with no default have type symbol (aka name).
> str(formals(lm))
# Dotted pair list of 14
# $ formula    : symbol 
# $ data       : symbol 
# $ subset     : symbol 
# $ weights    : symbol 
# $ na.action  : symbol 
# $ method     : chr "qr"
# $ model      : logi TRUE
# $ x          : logi FALSE
# $ y          : logi FALSE
# $ qr         : logi TRUE
# $ singular.ok: logi TRUE
# $ contrasts  : NULL
# $ offset     : symbol 
# $ ...        : symbol 

# formals returns NULL for primitive functions.  Use it in combination with
# args for this case.
is.primitive(`+`)
#[1] TRUE
formals(`+`)
# NULL
formals(args(`+`))
#$e1
#
#
#$e2
#
#
 
# You can overwrite the formal arguments of a function (though this is
# advanced, dangerous coding).
f <- function(x) a + b
formals(f) <- alist(a = , b = 3)
f    # function(a, b = 3) a + b
# function (a, b = 3) 
# a + b
f(2) # result = 5
#[1] 5


# Argument lists
f <- function() x
# Note the specification of a "..." argument:
formals(f) <- al <- alist(x = , y = 2+3, ... = )
f
al


```


