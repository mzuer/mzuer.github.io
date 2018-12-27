---
layout: post
title: "R - <em>unlink()</em> to delete file(s) or directory(ies)"
date: 2018-12-27
category: R
tags: R function files directory
---

<em>unlink()</em> can be used to delete the file(s) or directories.

<em>file.remove()</em> may be more appropriate (see below).


Wildcard expansion is done by the internal code of Sys.glob. Wildcards never match a leading ‘.’ in the filename, and files ‘.’ and ‘..’ will never be considered for deletion. 
Wildcards will only be expanded if the system supports it. Most systems will support not only ‘*’ and ‘?’ but also character classes such as ‘[a-z]’ (see the man pages for the system call glob on your OS). 
The metacharacters * ? [ can occur in Unix filenames, and this makes it difficult to use unlink to delete such files (see file.remove), although escaping the metacharacters by backslashes usually works. 
If a metacharacter matches nothing it is considered as a literal character. 

```
unlink(x, recursive = FALSE, force = FALSE)
```


