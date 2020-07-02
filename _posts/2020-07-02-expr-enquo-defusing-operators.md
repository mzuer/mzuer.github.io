#---
layout: post
title: "R - <em>expr()</em> and <em>enquo()</em> defusing operators"
date: 2020-07-02
category: R
tags: [R, functions]
---

The defusing operators expr() and enquo() prevent the evaluation of R code. Defusing is also known as quoting, and is done in base R by quote() and substitute(). When a function argument is defused, R doesn't return its value like it normally would but it returns the R expression describing how to make the value. These defused expressions are like blueprints for computing values.

The defusing operators expr() and enquo() prevent the evaluation of R code. Defusing is also known as quoting, and is done in base R by quote() and substitute(). When a function argument is defused, R doesn't return its value like it normally would but it returns the R expression describing how to make the value. These defused expressions are like blueprints for computing values.

There are two main ways to defuse expressions, to which correspond the two functions expr() and enquo(). Whereas expr() defuses your own expression, enquo() defuses expressions supplied as argument by the user of a function. See section on function arguments for more on this distinction.

The main purpose of defusing evaluation of an expression is to enable data-masking, where an expression is evaluated in the context of a data frame so that you can write var instead of data$var. The expression is defused so it can be resumed later on, in a context where the data-variables have been defined.

Defusing prevents the evaluation of R code, but you can still force evaluation inside a defused expression with the forcing operators !! and !!!.


Defusing function arguments

There are two points of view when it comes to defusing an expression:

You can defuse expressions that you supply with expr(). This is one way of creating symbols and calls (see previous section).

You can defuse the expressions supplied by the user of your function with the operators starting with en like ensym(), enquo() and their plural variants. They defuse function arguments .


The defusing operator expr() is similar to quote(). Like bquote(), it allows forcing evaluation of parts of an expression.

The plural variant exprs() is similar to alist().

The argument-defusing operator enquo() is similar to substitute().

``` 

# expr() and exprs() capture expressions that you supply:
expr(symbol)
exprs(several, such, symbols)

# enexpr() and enexprs() capture expressions that your user supplied:
expr_inputs <- function(arg, ...) {
  user_exprs <- enexprs(arg, ...)
  user_exprs
}
expr_inputs(hello)
expr_inputs(hello, bonjour, ciao)

# ensym() and ensyms() provide additional type checking to ensure
# the user calling your function has supplied bare object names:
sym_inputs <- function(...) {
  user_symbols <- ensyms(...)
  user_symbols
}
sym_inputs(hello, "bonjour")
## sym_inputs(say(hello))  # Error: Must supply symbols or strings
expr_inputs(say(hello))


# All these quoting functions have quasiquotation support. This
# means that you can unquote (evaluate and inline) part of the
# captured expression:
what <- sym("bonjour")
expr(say(what))
expr(say(!!what))

# This also applies to expressions supplied by the user. This is
# like an escape hatch that allows control over the captured
# expression:
expr_inputs(say(!!what), !!what)


# Finally, you can capture expressions as quosures. A quosure is an
# object that contains both the expression and its environment:
quo <- quo(letters)
quo

get_expr(quo)
get_env(quo)

# Quosures can be evaluated with eval_tidy():
eval_tidy(quo)

# They have the nice property that you can pass them around from
# context to context (that is, from function to function) and they
# still evaluate in their original environment:
multiply_expr_by_10 <- function(expr) {
  # We capture the user expression and its environment:
  expr <- enquo(expr)

  # Then create an object that only exists in this function:
  local_ten <- 10

  # Now let's create a multiplication expression that (a) inlines
  # the user expression as LHS (still wrapped in its quosure) and
  # (b) refers to the local object in the RHS:
  quo(!!expr * local_ten)
}
quo <- multiply_expr_by_10(2 + 3)

# The local parts of the quosure are printed in colour if your
# terminal is capable of displaying colours:
quo

# All the quosures in the expression evaluate in their original
# context. The local objects are looked up properly and we get the
# expected result:
eval_tidy(quo)
``` 
