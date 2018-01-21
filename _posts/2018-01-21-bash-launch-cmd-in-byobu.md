---
layout: post
title: "Bash - launch command from terminal into byobu"
date: 2018-01-21
category: bash
tags: [bash]
---

To launch a command in a new byobu window

```
byobu new-window "./mon_script.sh param1 param2" 
```


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

