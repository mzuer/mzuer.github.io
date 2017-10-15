---
layout: post
title: "Bash - store results of a command into variable"
date: 2017-10-15
category: bash
tags: [bash]
---


```
OUTPUT="$(ls -1)"
echo "${OUTPUT}"
```

or equivalent

```
OUTPUT=`ls -1`
```

Store into an array:

```
array=($(ls -d */))
```

