---
layout: post
title: "Bash - launch a command in a new byobu session"
date: 2020-07-01
category: R
tags: [bash]
---

### Launch a command in a new byobu session

To start a new session (new byobu instance you can attach to) with a command you can:
```
byobu new-session -s "session name" "ls -la && sleep 5"
```
To create it already detached:
```
byobu new-session -d -s "session name" "ls -la && sleep 5"
```

To attach to a session by name:
```
byobu attach -t "session name"
```

### Example
```
byobu new-window "./ezh2_workflow_flexible.sh KARPAS DMSORep2Rep2AB 10000 TopDom 06_12_10kb_REPLICATES" 
```
