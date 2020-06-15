---
layout: post
title: "bash: find recursively the largest file"
date: 2020-05-30
category: bash
tags: bash
---


Command to find recursively the largest file:

```
find . -type f -printf "%s\t%p\n" | sort -n | tail -1
```
