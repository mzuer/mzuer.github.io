---
layout: post
title: "R - merge and update two lists into one with <em>modifyList()</em>"
date: 2021-02-10
category: R
tags: R plot ggplot2 function package
---

<a href="https://petermeissner.de/blog/2020/09/03/utils-treasures-moifyList/">https://petermeissner.de/blog/2020/09/03/utils-treasures-moifyList/</a>


The function offers a way to merge two lists into one similar to `c()`, the concatenate function. But other than with using `c()` items with the same keys will be updated instead of simply added. Thus `modifyList()` presents the answer to the question:

```
options_default <- 
    list(
        plots = TRUE,
        font_face = "Comic Sans",
        author = "No One In Particular"
    )


options_patch <- 
    list(
        author = "Me MySelf And I"
    )
    
options_to_use <- modifyList(options_default, options_patch)
options_to_use
# $plots
# [1] TRUE

# $font_face
# [1] "Comic Sans"

# $author
# [1] "Me MySelf And I"
```
