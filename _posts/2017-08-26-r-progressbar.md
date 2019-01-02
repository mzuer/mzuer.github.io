---
layout: post
title: "R - <em>txtProgressBar()</em> and <em>setTxtProgressBar()</em>: progress bar for a loop"
date: 2017-08-26
category: R
tags: [R, loop, function]
---

create a progress bar for a loop and print the progress during the loop:

```
SEQ  <- seq(1,100)
pb   <- txtProgressBar(1, 100, style=3)
for(i in SEQ){
   Sys.sleep(0.02)
   setTxtProgressBar(pb, i)
}
```


<small> viewed on http://www.rfunction.com/ </small>
