---
layout: post
title: "Bash - <em>tee</em> save data in middle of pipeline"
date: 2020-07-02
category: bash
tags: [bash]
---

<em>tee</em> (Parker, Stallman, and MacKenzie 2012) to save the result of csvcut in the middle of the pipeline:


```
$ < data/tips.csv csvcut -c bill,tip | tee data/bills.csv | head -n 3 | csvlook
```
