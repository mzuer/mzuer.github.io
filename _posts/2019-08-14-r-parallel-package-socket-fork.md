---
layout: post
title: "R - <em>parallel</em> package: socket or fork"
date: 2019-08-14
category: R
tags: R function package parallelization
---


<a href="https://statcompute.wordpress.com/2019/06/30/parallel-r-socket-or-fork">https://statcompute.wordpress.com/2019/06/30/parallel-r-socket-or-fork</a>



2 implementations of parallelism in the package <em>parallel</em>.

* <em>fork</em>: each parallel thread is a complete duplication of the master process with the shared environment, including objects or variables defined prior to the kickoff of parallel threads. Fast, but doesn’t work on Windows.

* <em>socket</em>: each thread runs separately without sharing objects or variables, which can only be passed from the master process explicitly. Slower, but works on all operating systems.


