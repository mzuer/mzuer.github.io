---
layout: post
title: "Bash (Linux) - problem mouse not working"
date: 2021-02-10
category: bash
tags: bash
---

in case mouse not responding, try:

```
sudo modprobe -r psmouse
sudo modprobe psmouse proto=imps
```


