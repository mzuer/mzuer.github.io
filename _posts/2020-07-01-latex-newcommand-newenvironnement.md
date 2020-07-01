---
layout: post
title: "Latex - <em>newcommand</em> and <em>newenvironnement</em>"
date: 2020-07-01
category: R
tags: [latex, function, command]
---



```{latex}
\newcommand{\Hels}{Heisenberg group}
```

before begin document
-> like a macro, replace everywhere


```{latex}
\newcommand{\Hels}[1] {
Heisenberg group of type #1
}

\newenvironnement{myproof}{
this is the beginning of the proof.}{we are done}


\begin{myproof} Blablabla \end{myproof}
```
