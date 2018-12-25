---
layout: post
title: "R - custom character translation (<em>chartr</em>)"
date: 2018-12-25
category: R
tags: R strings function
---

Custom character translation with <em>chartr</em> function, example:

```
chartr("OIZEASGTC", "01234567(" , toupper(month.name))
# [1] "J4NU4RY"   "F3BRU4RY"  "M4R(H"     "4PR1L"     "M4Y"       "JUN3"      "JULY"     
# [8] "4U6U57"    "53P73MB3R" "0(70B3R"   "N0V3MB3R"  "D3(3MB3R" 
```


