---
layout: post
title: "R - <em>fixed</em> argument in <em>gsub()</em>: match as is"
date: 2018-12-25
category: R
tags: R string regexpr
---

myStrings <- c("20.january", "4.april", "5.may")

# fixed will match the first argument as is
# Replace literal dots with 0
gsub(".", "0", myStrings, fixed = TRUE)
# [1] "200january" "40april"    "50may"

# This will replace all characters with zeros
gsub(".", "0", myStrings)
# [1] "0000000000" "0000000"    "00000"     

