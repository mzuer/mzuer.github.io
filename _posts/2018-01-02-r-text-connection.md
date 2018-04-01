---
layout: post
title: "R - <em>read.table</em> with <em>textConnection</em>"
date: 2018-01-02
category: R
tags: [R, function]
---

Pass raw text to <em>read.table</em> using <em>textConnection</em>:

```
read.table(textConnection(""),
           header=TRUE)

```

For example: 

```

dataDT <-	read.table(textConnection("
	filename    diff RMSD
	1bso.pdb    1.0 0.5645
	1cj51.9.pdb 2.0 3.5596
	1cj51.1.pdb 3.0 3.5573
	3qzj.pdb    3.0 0.8302
	1bsy.pdb    4.0 0.5387
	1cj51.5.pdb 8.0 3.9864
	2gj5.pdb    10.0    0.8446
	1cj51.10.pdb    11.0    3.5914
	1uz2.pdb    12.0    1.7741
	2blg.pdb    12.0    0.5449"),
		       header=TRUE)

```
