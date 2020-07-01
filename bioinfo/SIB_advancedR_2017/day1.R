
#=========================================================================================
# Exercice 0 - S3 and S4 classes
#=========================================================================================

# A) S3 class example

tad <- function(chromo, start, end, tissue=NULL) {
  mytad <- list(chromo = chromo, 
                start = start,
                end = end)
  if(!is.null(tissue)) 
    mytad$tissue <- tissue
  class(mytad) <- "tad"
  return(mytad)
}

x1 <- tad(chromo="chr1", start=1, end=40000)

print.tad <- function(object) {
  if(!any(class(object) == "tad")) {
    stop("Error: object is not tad object !\n")
  }
  cat("TAD from chromosome: ", object$chromo, "\n")
  cat("TAD start position: ", object$start, "\n")
  cat("TAD end position: ", object$end, "\n")
  if(!is.null(object$tissue))
    cat("TAD from tissue: ", object$tissue, "\n")
}
print(x1)


findMiddle.tad <- function(object) {
  if(!any(class(object) == "tad")) {
    stop("Error: object is not tad object !\n")
  }
  return(round(0.5*(object$end+object$start)))
}
# for the moment can be used as findMiddle.tad(x1) but not findMiddle(x1)
findMiddle <- function(object) UseMethod("findMiddle")
# after dispatch, can be used as findMiddle(x1)
findMiddle(x1)


# B) S4 class example

setClass("tad",
         representation(chromo = "character", 
                        start = "numeric",
                        end = "numeric",
                        tissue = "character"),
         validity=function(object){
           object@end > object@start &
           object@start %% 1 == 0 & 
            object@end %% 1 == 0
         })

new("tad", chromo ="chr1", start = 5, end = 10)
new("tad", chromo ="chr1", start = 5, end = 0)
new("tad", chromo ="chr1", start = 5, end = 10.5)
new("tad", chromo ="chr1", start = 5, end = "e")

#=========================================================================================
# Exercice 1
#=========================================================================================

# Suppose that you are given information about the amount of fertilizer used on several parts of a field, in the form of a factor:
  
fert <- factor( c(10, 20, 50, 30, 10, 20, 10, 45) )

as.numeric(fert) # => you get integers "pointers" pointing to character string

# Starting from the factor, how would you calculate the mean amount of fertilizer used ?
mean(as.numeric(as.character(fert)))
  
#=========================================================================================
# Exercice 2
#=========================================================================================

# The table() function allows you to count the number of occurrences of each value in a vector ; for example :
  
set.seed(1)
data <- sample(1:10, 10, replace=T)
table(data)

# How could we obtain the same result, but including all numbers from 1 to 10, with a count of ‘0’
# when the value does not appear in the vector ?
table(factor(data, levels=1:10))

# use factor to show some categories, even if you don't have them in your data

# or tabulate function !!! ONLY IF GAPS NOT AT THE END !!!
tabulate(data) # we loose the names
tab <- tabulate(data); names(tab) <- 1:10
# !!! BUT tabulate DOES NOT WORK IF THE GAPS ARE AT THE BEGINNING OR END

# 5 will be the first the one, all the other come after
data <- relevel(data, ref = 5)



#=========================================================================================
# Exercise 3
#=========================================================================================
# A) 
#The following R code generates random data and fits a linear model:
set.seed(1)
x <- runif(10)
y <- 2*x + rnorm(10)
model <- lm(y~x)
summary(model)

# summary function also do some calculation (values not provided by lm())
# coef() function adds model$coefficients, but better to use coef() !!

# How would you copy into a variable "slope" the slope of the regression line (the second regression coefficient) ?
# And how would you extract in a variable "pvalue" the p-value associated with it ?

# 

slope <- coef(model)["x"]
# pvalue <- summary(model)$coefficients[2,4]
pvalue <-  coef(summary(model))["x","Pr(>|t|)"]
# => cleaner and more reproducible to use the true column names instead of just numbers !

# B) The following code fits an ANOVA model:
set.seed(1)
groups <- rep(LETTERS[1:3], each=5 )
data <- rnorm( length(groups) )
model_anova <- aov( data ~ groups )
summary(model_anova)[[1]][1,5]
# How would you extract the p-value provided by this model into a "pvalue" variable ?

#=========================================================================================
# Exercise 4
#=========================================================================================

# The summary() function, when applied to numeric values, displays the "five-number summary" of the values, 
# as in the following example:
summary(runif(100))
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.0006386 0.2646350 0.5089532 0.5088928 0.7493618 0.9828082 

# Modify the summary function so that the output also adds a column containing the standard deviation of the data.

summary <- function(x) {
  c("Min." = min(x), "1st Qu." = as.numeric(quantile(x, 0.25)), "Median" = median(x),
    "Mean" = mean(x), "3rd Qu." = as.numeric(quantile(x, 0.75)), "Max." = max(x),
    "sd." = sd(x))
}

summary(runif(100))

#=========================================================================================
# Exercise 5
#=========================================================================================
# Create an S3 class from scratch; imagine the name of the class, a function that creates it
# (and includes some data in it), and define at least a print(), a summary() and a plot() methods for it.



partition <- function(chromo, start, end, tissue=NULL) {
  mypartition <- list(chromo = chromo, 
                start = start,
                end = end)
  if(!is.null(tissue)) 
    mypartition$tissue <- tissue
  class(mypartition) <- "partition"
  return(mypartition)
}

x1 <- partition(chromo="chr1", start=seq(1,100000,40000), end=seq(40000, 140000, 40000))

print.partition <- function(object) {
  if(!any(class(object) == "partition")) {
    stop("Error: object is not partition object !\n")
  }
  cat("Partition from chromosome: ", object$chromo, "\n")
  cat("# start position: ", length(object$start), "\n")
  cat("# end position: ", length(object$end), "\n")
  if(!is.null(object$tissue))
    cat("Partition from tissue: ", object$tissue, "\n")
}
print(x1)

summary.partition <- function(object) {
  if(!any(class(object) == "partition")) {
    stop("Error: object is not partition object !\n")
  }
  c("# TADs" = length(object$start), "mean TAD size" = mean(c(object$end-object$start+1)))
}
summary(x1)

plot.partition <- function(object) {
  if(!any(class(object) == "partition")) {
    stop("Error: object is not partition object !\n")
  }
  plot(object$end,object$start) 
}
plot(x1)


  