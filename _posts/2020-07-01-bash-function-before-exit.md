---
layout: post
title: "Bash - execute a function before exiting a script"
date: 2020-07-01
category: R
tags: [bash, function]
---


### Exite a function before exiting the script:

```{bash}
function mvBack {
  echo "... go back to my folder"
  cd $runDir  
}
trap mvBack EXIT
```
