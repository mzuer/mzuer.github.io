---
layout: post
title: "Bash - change many file names in one-line for loop (<em>for</em> and <em>mv</em>)"
date: 2018-01-21
category: bash
tags: [bash, loop]
---


```
for file in *.jpg ; do mv $file ${file//IMG/NEWPAT} ; done


NB to create array on the fly:
for chromo in ( "chr"{1..22} ); do echo $chromo; done

```




