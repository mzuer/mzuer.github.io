---
layout: post
title: "Bash - read lines from file"
date: 2020-07-01
category: R
tags: [bash, loop]
---



```{bash}
cat ./SAMPLES.txt| while read SAMPLE
do
    mkdir ${OUTDIR}/${SAMPLE}
done
```
