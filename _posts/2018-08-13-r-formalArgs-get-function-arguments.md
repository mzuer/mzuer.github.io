---
layout: post
title: "<em>formalArgs</em> and <em>args</em>: functions retrieve the formal arguments of a function"
date: 2018-08-13
category: R
tags: R function
---

Aim: retrieving formal arguments of a function

If the function of is not a primitive, use <em>formalArgs</em>:
---
formalArgs(ls)
# [1] "name"      "pos"       "envir"     "all.names" "pattern"   "sorted"
---

But <em>formalArgs</em> will return <code>NULL</code> if the function is a primitive (primitives don't have formals):
---
formalArgs(abs)
NULL
---

Check if the function is a primitive:
--- 
is.primitive(abs)
# [1] TRUE
---

If the function is a primitive, use <em>args</em>, and pass the output of <em>args</em> to <em>formals</em> or <em>formalArgs</em>:

---
args(abs)
#   function (x) 
# NULL
---

---
formalArgs(args(abs))
# [1] "x"
---

<em>formalArgs(args())</em> works for both primitives and non primitives:

---
formalArgs(args("ls"))
# [1] "name"      "pos"       "envir"     "all.names" "pattern"   "sorted" 
---
