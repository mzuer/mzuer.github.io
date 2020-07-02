---
layout: post
title: "R - <em>map()</em> and helper functions from <em>purrr</em> package"
date: 2020-07-02
category: R
tags: [R, package, function, loops]
---


http://perso.ens-lyon.fr/lise.vaudor/iterer-des-fonctions-avec-purrr/


https://stackoverflow.com/questions/45101045/why-use-purrrmap-instead-of-lapply


If the only function you're using from purrr is map(), then no, the advantages are not substantial. As Rich Pauloo points out, the main advantage of map() is the helpers which allow you to write compact code for common special cases:

    ~ . + 1 is equivalent to function(x) x + 1

    list("x", 1) is equivalent to function(x) x[["x"]][[1]]. These helpers are a bit more general than [[ - see ?pluck for details. For data rectangling, the .default argument is particularly helpful.

But most of the time you're not using a single *apply()/map() function, you're using a bunch of them, and the advantage of purrr is much greater consistency between the functions. For example:

    The first argument to lapply() is the data; the first argument to mapply() is the function. The first argument to all map functions is always the data.

    With vapply(), sapply(), and mapply() you can choose to suppress names on the output with USE.NAMES = FALSE; but lapply() doesn't have that argument.

    There's no consistent way to pass consistent arguments on to the mapper function. Most functions use ... but mapply() uses MoreArgs (which you'd expect to be called MORE.ARGS), and Map(), Filter() and Reduce() expect you to create a new anonymous function. In map functions, constant argument always come after the function name.

    Almost every purrr function is type stable: you can predict the output type exclusively from the function name. This is not true for sapply() or mapply(). Yes, there is vapply(); but there's no equivalent for mapply().

You may think that all of these minor distinctions are not important (just as some people think that there's no advantage to stringr over base R regular expressions), but in my experience they cause unnecessary friction when programming (the differing argument orders always used to trip me up), and they make functional programming techniques harder to learn because as well as the big ideas, you also have to learn a bunch of incidental details.

Purrr also fills in some handy map variants that are absent from base R:

    modify() preserves the type of the data using [[<- to modify "in place". In conjunction with the _if variant this allows for (IMO beautiful) code like modify_if(df, is.factor, as.character)

    map2() allows you to map simultaneously over x and y. This makes it easier to express ideas like map2(models, datasets, predict)

    imap() allows you to map simultaneously over x and its indices (either names or positions). This is makes it easy to (e.g) load all csv files in a directory, adding a filename column to each.

    dir("\\.csv$") %>%
      set_names() %>%
      map(read.csv) %>%
      imap(~ transform(.x, filename = .y))

    walk() returns its input invisibly; and is useful when you're calling a function for its side-effects (i.e. writing files to disk).

Not to mention the other helpers like safely() and partial().

Personally, I find that when I use purrr, I can write functional code with less friction and greater ease; it decreases the gap between thinking up an idea and implementing it. But your mileage may vary; there's no need to use purrr unless it actually helps you.


