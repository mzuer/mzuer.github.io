---
layout: post
title: "Bash - number arithmetic in bash scripts"
date: 2020-07-02
category: bash
tags: [bash]
---


Using the $(( )) arithmetic expansion.
```
num=$(( $num + $metab ))
```


For integers:

    Use arithmetic expansion: $((EXPR))
```
    num=$((num1 + num2))
    num=$(($num1 + $num2))       # Also works
    num=$((num1 + 2 + 3))        # ...
    num=$[num1+num2]             # Old, deprecated arithmetic expression syntax
```
    Using the external expr utility. Note that this is only needed for really old systems.
```
    num=`expr $num1 + $num2`     # Whitespace for expr is important
```
For floating point:

Bash doesn't directly support this, but there are a couple of external tools you can use:
```
num=$(awk "BEGIN {print $num1+$num2; exit}")
num=$(python -c "print $num1+$num2")
num=$(perl -e "print $num1+$num2")
num=$(echo $num1 + $num2 | bc)   # Whitespace for echo is important
```
You can also use scientific notation (for example, 2.5e+2).

Common pitfalls:

    When setting a variable, you cannot have whitespace on either side of =, otherwise it will force the shell to interpret the first word as the name of the application to run (for example, num= or num)

    bc and expr expect each number and operator as a separate argument, so whitespace is important. They cannot process arguments like 3+ +4.



```
A=1
B=1
let "C = $A + $B"
echo $C # C == 2
```



```
echo $num1 $num2 + p | dc
```




```
dc <<<"$num1 $num2 + p"
```




```
num=$(dc <<<"$num $metab + p")
```
