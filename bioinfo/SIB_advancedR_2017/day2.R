library(multcomp)

set.seed(1); x <- runif(100)
microbenchmark( sqrt(x), x^0.5 )

Rprof()
pvalues <- NULL
for (i in 1:1000) {
  a <- runif(6)
  ttest <- t.test( a[1:3], a[4:6])
  pval <- ttest$p.value
  pvalues <- c(pvalues, pval)
}
Rprof(NULL)
summaryRprof()

# if the package multcomp is available -> add cld column with the ranking

#=========================================================================================
# Exercice 1
#=========================================================================================

# A) During the course, we discussed how to improve the efficiency of the following expression:
  
n <- 10000
m <- 100

results <- NULL
v0 <- system.time(
for (i in 1:n) { 
  result <- mean( runif( m ) )
  results <- c(results, result)
}
)
# Do you have any ideas how you could potentially improve it? 
# (if not, ask for advice or look at exercice 3). 
# Try these, and time them in comparison to the two versions described in the course.

results <- numeric(n)
v1 <- system.time(
for (i in 1:n) { 
  results[i] <- mean( runif( m ) )
}
)
# appel de fonction -> + long (e.g. passage de l'argument sur la pile,etc.) => appel de fonction est coûteux !
# apply serait utile si on fait qqh avec n (avantage si on va chercher qh e.g. dans la matrice, etc.)
v2 <- system.time(unlist(sapply(1:n, function(x) mean(runif(m)))))
results <- unlist(sapply(1:n, function(x) mean(runif(m))))

# => remplacer mean par sum/len
results <- numeric(n)
v3 <- system.time(
  for (i in 1:n) { 
    results[i] <- sum(runif(m))/m
  }
)

# user  system elapsed 
# 0.264   0.000   0.262 
# user  system elapsed 
# 0.088   0.000   0.088 
# user  system elapsed 
# 0.092   0.000   0.093 
# user  system elapsed 
# 0.056   0.000   0.056 

# B) If we create the vector with the right size before the loop, does it make a difference if we
# initially fill it with NAs or with zeros ?

results <- numeric(n)
v0 <- system.time(for (i in 1:n) { 
  results[i] <- mean( runif( m ) )
}
)

results <- rep(NA, n)
v1 <- system.time(for (i in 1:n) { 
  results[i] <- mean( runif( m ) )
}
)
# peut-être plus direct pour R ?
results <- rep(0, n)
v2 <- system.time(
for (i in 1:n) { 
  results[i] <- mean( runif( m ) )
}
)
# > v0
# user  system elapsed 
# 0.088   0.000   0.087 
# > v1
# user  system elapsed 
# 0.012   0.000   0.013 
# > v2
# user  system elapsed 
# 0.016   0.000   0.014 

#=========================================================================================
# Exercice 2
#=========================================================================================
# Create an expression similar to the one described in exercise 1 but which returns data in a matrix or dataframe, 
# and compare its performances when the matrix is increased by one row at each iteration, compared to when the matrix
# is created first and then filled in row by row.

v2 <- system.time(unlist(sapply(1:n, function(x) mean(runif(m)))))
results <- unlist(sapply(1:n, function(x) mean(runif(m))))

# first output is a single row, then do it a second time

#=========================================================================================
# Exercice 3
#=========================================================================================
# Go back to exercice 1 (calculating many times the mean of several random numbers). 
# Test if you can obtain further improvements in speed by making the following changes:
  
# a)- create a matrix containing all the random numbers, and use the apply command instead of a loop.
# create matrix with all random numbers
randNumb <- sapply(1:n, function(x) runif(m)) # returns a m x n matrix


v4 <- system.time(
apply(randNumb, 2, function(x) mean(x))
)
# user  system elapsed 
# 0.060   0.000   0.061 

# b)- do not use the mean() function, but calculate the mean manually (using the sum() function for example)

v5 <- system.time(
  apply(randNumb, 2, function(x) 0.5*sum(x))
)

#=========================================================================================
# Exercice 4
#=========================================================================================

# Improve as much as possible the execution time of the following piece of code (seen in the course):
  
system.time({
pvalues <- NULL
for (i in 1:10000) {
  a <- runif(6)
  ttest <- t.test( a[1:3], a[4:6])
  pval <- ttest$p.value
  pvalues <- c(pvalues, pval)
}
})

system.time({
all_rand <- unlist(sapply(1:10000, function(x) runif(6)))
# dim(all_rand) 6x10000
pvalues <- unlist(sapply(1:10000, function(x){
  ttest <- t.test( all_rand[1:3,x], all_rand[4:6,x])
  ttest$p.value
}))
})

# user  system elapsed 
# 1.304   0.000   1.301 
# user  system elapsed 
# 1.272   0.000   1.274 
