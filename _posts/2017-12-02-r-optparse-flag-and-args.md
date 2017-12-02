---
layout: post
title: "R - parse command line with both flags and arguments"
date: 2017-12-02
category: R
tags: [R, command line]
---


Parse both flags and additional arguments from command line:

```
# ex: a command line Rscript myscript.R -f myfile1 -F myfile2 fold1 fold2 fold3

opt_parser <- OptionParser(option_list=option_list);
cmdline <- parse_args(opt_parser, positional_arguments = TRUE);

# store the flags in a variable
opt <- cmdline$options
file1 <- opt$file1 # for the -f flag
file2 <- opt$file2 # for the -F flag

# store all arguments without flags
all_folders <- cmdline$args   # will store c(fold1, fold2, fold3)
```
