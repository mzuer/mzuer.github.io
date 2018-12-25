---
layout: post
title: "R - <em>adist</em> to compute Levenshtein distance between strings"
date: 2018-12-25
category: R
tags: R function string distance
---


Levenshtein distance between strings with <em>adist</em>:

```
adist(c("lazy", "lasso", "lassie"), c("lazy", "lazier", "laser"))
#      [,1] [,2] [,3]
# [1,]    0    3    3
# [2,]    3    4    2
# [3,]    4    3    3

```

Wikipédia: La distance de Levenshtein est une distance, au sens mathématique du terme, donnant une mesure de la différence entre deux chaînes de caractères. 
Elle est égale au nombre minimal de caractères qu'il faut supprimer, insérer ou remplacer pour passer d’une chaîne à l’autre. 
