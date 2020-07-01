
#=========================================================================================
# Exercice 1
#=========================================================================================

# Create a long vector in R, for example

d <- 1:10000

# A) How would efficiently calculate the sum of every 5 adjacent values in the vector 
# (without overlap: the sum of the first five elements, the sum of the next five, etc) ?
start_pos <- seq(1, max(d)-4, by=5)
fiveSum <- sapply(start_pos, function(x) sum(d[x:(x+4)]))

# B) How would you calculate the overlapping sum of 5 adjacent values: the sum of the first five, 
# the sum of the 5 elements starting at the 2nd position, etc)
fiveSum <- sapply(1:(max(d)-4), function(x) sum(d[x:(x+4)]))

#=========================================================================================
# Exercice 2
#=========================================================================================

# The following dataset describes the content of a 1024x1024 matrix

n <- 1024 
y <- rep( 1:n, each=n ) 
x <- rep( 1:n, times=n ) 
value <- rnorm( length(x) )
data <- data.frame(x, y, value)

# Each row of the data frame describes one element of the matrix: its row number (x), column number (y), and the actual value.

# How would you transform this data frame into an actual matrix containing the values (value) 
# at the correct position (as given by each x and y) ?
library(Matrix)
mat <- as.matrix(sparseMatrix(i = x, j = y, x = value))

mat2 <- do.call(cbind, lapply(1:max(data$y), function(i) {
  tmpDT <- data[data$y == i, c("x", "value")]
  tmpDT <- tmpDT[order(tmpDT$x),]
  tmpDT$value
}))

#=========================================================================================
# Exercice 3
#=========================================================================================

# The following code creates a dataset:

set.seed(1) 
data <- data.frame(y=rnorm(100), x1=rnorm(100), x2=rnorm(100), group=sample(1:10, 100, replace=T) ) 
data[ data$group==5, "y" ] <- data[ data$group==5, "x2" ] + rnorm( sum(data$group==5) )/10

# Write an R program that will:
# 
#     - fit a linear model of the form y ~ x1 + x2 separately to the data corresponding to each group
#     - return a vector (or another appropriate data structure) containing the p-values for significance of the 
#       x2 variable in each model
#     - single out the group that produced the lowest such p-value
# 
# If you used a for loop (over all groups) in your program, rewrite it without using the for loop.
data$group <- factor(data$group, levels=rev(1:10))

pval_groups <- do.call('c', list(by(data, data$group, function(dt) {
  mylm <- lm(y ~ x1 + x2, data =dt) 
  coef(summary(mylm))["x2", "Pr(>|t|)"]
})))

names(pval_groups)[which.min(pval_groups)] 

#=========================================================================================
# Exercice 4
#=========================================================================================

# This is a follow-up to exercise 2; this time, our data frame has gaps (it does not describe all the elements of the matrix). 
# Create a dataframe with the following code:

n <- 1024 
y <- rep( 1:n, each=n ) 
x <- rep( 1:n, times=n )

value <- rep(0, length(x)) 
data <- data.frame(x, y, value) 
data <- within(data, value[ x>n/4 & x<n*3/4 & y>n/4 & y<n*3/4 ] <- 1 ) 
data <- within(data, value[ x>n*3/8 & x<n*5/8 & y>n*3/8 & y<n*5/8 ] <- 0 ) 
data <- data[ data$value > 0, ]

# How do you transform this data.frame into a matrix ?
# When you are done, plot the matrix using the image() function, and check whether your result is correct.


library(Matrix)
mat <- as.matrix(sparseMatrix(i = data$x, j = data$y, x = data$value))
image(mat)


mat2 <- matrix(rep(0, n*n), nrow= n)
# ! not efficient
# foo <- sapply(1:nrow(data), function(i) {
#   mat2[data$x[i], data$y[i]] <- data$value[i]
# })

foo <- sapply(1:ncol(mat2), function(i) {
  tmpDT <- data[data$y == i, c("x", "value")]
  miss_tmpDT <- data.frame(x = c(1:ncol(mat2))[!c(1:ncol(mat2)) %in% tmpDT],
                           value = NA)
  full_tmpDT <- rbind(tmpDT, miss_tmpDT)
  full_tmpDT <- full_tmpDT[order(full_tmpDT$x),]
  mat2[,i] <- full_tmpDT
})
image(mat2)

