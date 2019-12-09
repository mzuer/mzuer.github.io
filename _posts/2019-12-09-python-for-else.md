---
layout: post
title: "python - <em>for</em>/<em>else</em> control flow"
date: 2019-12-09
category: python
tags: [python, loops, control flow]
---

<em>for</em> loops also have an <em>else</em>, which executes after the loop completes normally (i.e. if the loop did not encounter a break statement)


The common construct is to run a loop and search for an item. If the item is found, we break out of the loop using the break statement. 

Loop ends in 2 scenarios:

1) the item is found and break is encountered
2) the loop ends without encountering a break statement

<em>else</em> can be used to know which one of these is the reason for a loop’s completion

Example:

```
for item in container:
    if search_something(item):
        # Found it!
        process(item)
        break
else:
    # Didn't find anything..
    not_found_in_container()

```


