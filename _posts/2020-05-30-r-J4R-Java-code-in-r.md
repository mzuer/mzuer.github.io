---
layout: post
title: "R - <em>J4R</em> package to use Java code in R"
date: 2020-05-30
category: R
tags: R package
---


J4R: Create 'Java' Objects and Execute 'Java' Methods

Makes it possible to create 'Java' objects and to execute 'Java' methods from the 'R' environment. The 'Java' Virtual Machine is handled by a gateway server. Commands are sent to the server through a socket connection from the 'R' environment. Calls to 'Java' methods allow for vectors so that a particular method is iteratively run on each element of the vector. A score algorithm also makes the calls to 'Java' methods less restrictive. The gateway server relies on the runnable 'Java' library 'j4r.jar'. This library is licensed under the LGPL-3. Its sources are included in this package. 
