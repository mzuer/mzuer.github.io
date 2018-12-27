---
layout: post
title: "R - file manipulation with <em>file.<...>()</em> functions"
date: 2018-12-27
category: R
tags: R function files
---

Various functions for direct file manipulation (e.g. avoid use of <em>system(<...command...>)</em>)


See ?files for more information

```
file.create(..., showWarnings = TRUE)
file.exists(...)
file.remove(...)
file.rename(from, to)
file.append(file1, file2)
file.copy(from, to, overwrite = recursive, recursive = FALSE,
          copy.mode = TRUE, copy.date = FALSE)
file.symlink(from, to)
file.link(from, to)
```


<em>file.create</em> to create filesystem


<em>file.exists</em> to test existence of file(s)


<em>file.remove</em> to delete file(s)


<em>file.rename</em> to rename file(s)


<em>file.append</em> to append the file(s) named by its second argument to those named by its first


<em>file.copy</em> similar to <em>file.append()</em> but with arguments in the natural order for copying


<em>file.symlink</em> to create symbolic links


<em>file.link</em> to create hard links





