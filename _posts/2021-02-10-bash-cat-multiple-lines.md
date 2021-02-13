---
layout: post
title: "Bash - <em>cat</em> multiple lines to file"
date: 2021-02-10
category: bash
tags: bash
---

```
	cat >> ${new_out_file} <<- EOM
	- img: $sp_name
	  url: /assets/gallery/thumbnails/$sp_name
	  title: $out_name
	  caption: >
	    $out_name
	EOM
```


