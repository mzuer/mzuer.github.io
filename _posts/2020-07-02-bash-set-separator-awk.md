---
layout: post
title: "Bash - specify separator for <em>awk</em>"
date: 2020-07-02
category: bash
tags: [bash]
---


```{bash}
awk -v OFS="\t" '{ print "chr"$1,$2,$3,$4,$5}' CDB.txt >CDB.bed
sed -i  's/chr23/chrX/g' CDB.bed
```


