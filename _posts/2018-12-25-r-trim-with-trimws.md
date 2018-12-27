---
layout: post
title: "R - trim strings with <em>trimws()</em>"
date: 2018-12-25
category: R
tags: R strings function
---

Use of <em>trimws</em> for trimming character vectors:

```
### Remove all leading and trailing whitespaces
trimws(" This has trailing spaces.  ")
# [1] "This has trailing spaces."

### Remove leading whitespaces
trimws(" This has trailing spaces.  ", which = "left")
# [1] "This has trailing spaces.  "

### Remove trailing whitespaces
trimws(" This has trailing spaces.  ", which = "right")
# [1] " This has trailing spaces."
```



See also <em>strtrim</em> to trim character strings to specified display widths.

