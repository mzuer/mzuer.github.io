---
layout: post
title: "R - basic commands for creating R package"
date: 2021-02-10
category: R
tags: R package
---

https://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html


Inside parent folder, launch R and: 

```
devtools::create("myfirstpackage")
```

This ends up creating a folder with the same name as your package name with 4 files inside the folder:

    DESCRIPTION: This is where all the meta-data about your package goes. Rather than try to explain the contents, I will refer you to Hadley’s detailed explanation on the contents of this file.
    myfirstpackage.Rproj: This is a RStudio specific file. As I do not use RStudio, I will not comment on this file as I never use it.
    NAMESPACE: In short, this file indicates what needs to be exposed to users for your R package. From my experience, I’ve never edited this file as devtools takes care of the changes as you’ll see below.
    R: This is where all your R code goes for your package.
    
    In other words, specifically load the data.table package and thus save me the step of having to use the data.table::fread(). Doing this is actually a big no-no in R packages as using a library() in an R function can globally effect the availability of functions. To re-iterate:

    Never use library() or require() in a R package!

If your R functions require functions from external packages, the way to do this is to use the “double colon” approach. You also need to indicate that your R package depends on these external packages. To do this, you will need you add this information your DESCRIPTION file under the Imports content. For this case, we need the data.table R package, so we added the following to our DESCRIPTION file:

Imports:
	data.table (>= 1.9.4)

Notice how I also specified the version of the data.table. Basically I am saying that this package I am building requires the data.table package and specifically a version of it that is >= 1.9.4. You can indicate multiple external dependencies by just adding them in the next line:

Imports:
	data.table (>= 1.9.4),
	dplyr

Notice how I didn’t specify any version for dplyr which simply indicates that the package requires some version of dplyr. Also remember the comma between each dependency. I’ve been burned a few times by that!

You can additionally add packages to the Depends section of the DESCRIPTION file instead of the Imports section. What’s the difference? The only difference is that packages in the Depends section are loading and attached while packages in the Imports section are only loaded. For more details on this, I refer you to the namespace section of R packages.

once you have written and annotated the function, launch R and:


```
devtools::document()
# to create man pages

# then
devtools::build_vignettes()
```



