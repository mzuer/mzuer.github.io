---
layout: post
title: "bash - install python module in specific folder"
date: 2017-11-25
category: bash
tags: [bash, python, module]
---


Pour installer openconnect:
```
sudo add-apt-repository ppa:openconnect/daily
sudo apt-get update
sudo apt-get install openconnect
```

Pour se connecter à openconnect:
```
sudo openconnect --juniper crypto.unil.ch
# ou
sudo /usr/sbin/openconnect --juniper crypto.unil.ch
```


 

