---
layout: post
title: "Bash - find file with specific content (<em>find</em>)"
date: 2017-08-26
category: bash
tags: [bash]
---

```
find . -type f -name '*.R' -exec grep "pattern"
```

similar to:

```
find folder -type f -name '*.R' | xargs  grep "pattern"
```

