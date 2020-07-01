#********************************************************************************************************
#**************************************** PRACTICAL 1
#********************************************************************************************************

library(ggplot2)
library(reshape2)

library(caret)
# -> knn3 function used for k-Nearest Neighbour model
# check website https://topepo.github.io/caret/
# package that "wraps" a lot of different methods 

library(MASS)
# -> lda function for LDA

library(ROCR)
# -> plotting ROC curves

#**********************************************************************
#********************************************************************** K-nearest neighbors
#**********************************************************************

#############################################################
# 1. Simulating data
#############################################################

n <- 500
set.seed(1)    # Set the random number generator
x1 <- runif(n) # Get values between 0 and 1
x2 <- runif(n) # Get values between 0 and 1
g <- rep(1, n)
# Set group to 2 if we are within the circle
g[ (x1*1.3)^2+(x2*1.3)^2 < 1] <- 2   
x1 <- x1 + rnorm(n)/20  # Add some noise
x2 <- x2 + rnorm(n)/20  # Add some noise
data <- data.frame(group=g, x=x1, y=x2)

#############################################################
# 2. Making a testing/learning set
#############################################################

# randomly sample data points to form a learning set and a testing set:
  
learning_index <- sample(1:n, n/2)
learning_data  <- data[ learning_index,]
testing_data   <- data[-learning_index,]

# In this case, since we know that the dataset was randomly created, we can simply take the first 250 data points
# (do the same as it is what was done for the course)
learning_data  <- data[1:250,]
testing_data   <- data[251:500,]
data$set <- c(rep("learning", 250), rep("testing", 250))

#############################################################
# 3. Plotting the data
#############################################################

plot(data$y~data$x, 
main = "all data",
ylab="y", xlab="x",
pch=16, cex =0.7,
col = ifelse(data$group == 2, "red", "blue"))

plot(learning_data$y~learning_data$x, 
main = "learning data",
ylab="y", xlab="x",
pch=16, cex =0.7,
col = ifelse(learning_data$group == 2, "red", "blue"))

plot(testing_data$y~testing_data$x, 
     main = "learning data",
     ylab="y", xlab="x",
     pch=16, cex =0.7,
     col = ifelse(testing_data$group == 2, "red", "blue"))

plot(data$y~data$x, 
     main = "all data",
     ylab="y", xlab="x",
     pch=ifelse(data$set == "learning", 16,  17),
     cex =0.7,
     col = ifelse(data$group == 2, "red", "blue"))
legend("topleft", legend = c("learning", "testing"),
       pch = c(16,17), bty="n")  

#############################################################
# 4. Fitting a model
#############################################################

### Fit a k-Nearest Neighbour model by using the knn3 function (from "caret" package) 

# a- Fit the model:

fit <- knn3(group ~ x + y, data=learning_data, k=5)

# knn3 returns the vote percentages for each class

# b- Get the predictions from the model:
# each row is a data point, the 1st column gives the %age of votes for class1, the 2nd column %age for class2
learning_votes <- predict(fit, newdata=learning_data)
testing_votes  <- predict(fit, newdata=testing_data)
# e.g. if one row: 0.4 0.6 => 2/5 for group1, 3/5 for group2
# if the 2nd column (group 2) is greater than 0.5 => assign to group 2
# (can never be 0.5 because odd number as NN)
testing_predictions <- as.numeric(testing_votes[,2]>0.5)+1

# c- Create the confusion matrix:
# table(TESTING, PREDICTION)
  # 121 true group 2, 113 predictions group 2
table(testing_data$group, testing_predictions)
#           predict. 1     predict. 2
# true 1    125             4
# true 2    12              109

#           Predic. 1 	Predic. 2
# true 1     	TP 				 	FN
# true 2    	FP 					TN

TP <- sum(testing_data$group == 1 & testing_predictions == 1)
FP <- sum(testing_data$group == 2 & testing_predictions == 1)
FN <- sum(testing_data$group == 1 & testing_predictions == 2)
TN <- sum(testing_data$group == 2 & testing_predictions == 2)

# d- Calculate the values discussed during the course:
# total number of errors:
sum(testing_data$group != testing_predictions)
# 16
# false positive rate (1-specificity) FP/(FP+TN)
FP/(FP+TN)
# 0.0992
# true positive rate (sensitivity) TP/(TP+FN)
TP/(TP+FN)
# 0.9690
# positive predictive value (PPV, precision) TP/(TP+FP)
TP/(TP+FP)
# 0.9124
# negative predictive value (NPV) TN/(TN+FN)
TN/(TN+FN)
# 0.9646

# ... confusion matrix using the caret function - provides also many many different statistics
# NB: check nice website with tutos https://topepo.github.io/caret/
confusionMatrix(data = testing_data$group, reference = testing_predictions)
# nb: positive argument can be used to specifiy which one is the positive class

#############################################################
# 5. Finding the right k
#############################################################

# In order to find the right number of neighbours, vary this number 
# (going through the values 1, 3, 5, 7, etc, using a for() loop in R).
# For each possible k, calculate the error and plot the relationship between k and the error 
# (it is up to you to choose the error you want to use). Do you see any candidate value that is better than the others ?

all_k <- seq(1,50,by=2)
toterr <- fpr <- tpr <- ppv <- npv <- numeric(length(all_k))
for(i in seq_along(all_k)) {
  cat(paste0("... start k = ", all_k[i], "\n"))
  # a- Fit the model:
  fit <- knn3(group ~ x + y, data=learning_data, k=all_k[i])
  # b- Get the predictions from the model:
  testing_votes  <- predict(fit, newdata=testing_data)
  testing_predictions <- as.numeric(testing_votes[,2]>0.5)+1
  TP <- sum(testing_data$group == 1 & testing_predictions == 1)
  FP <- sum(testing_data$group == 2 & testing_predictions == 1)
  FN <- sum(testing_data$group == 1 & testing_predictions == 2)
  TN <- sum(testing_data$group == 2 & testing_predictions == 2)
  # total number of errors:
  toterr[i] <- sum(testing_data$group != testing_predictions)/length(testing_predictions)
  # false positive rate (1-specificity) FP/(FP+TN)
  fpr[i] <- FP/(FP+TN)
  # true positive rate (sensitivity) TP/(TP+FN)
  tpr[i] <- TP/(TP+FN)
  # positive predictive value (PPV, precision) TP/(TP+FP)
  ppv[i] <- TP/(TP+FP)
  # negative predictive value (NPV) TN/(TN+FN)
  npv[i] <- TN/(TN+FN)
}

plot(NULL, xlim = c(1,length(all_k)), ylim=c(0,1), 
     xlab="k", ylab="ratio", bty="l",
     axes=F)
axis(1, at=1:length(all_k),labels = all_k)
axis(2)
box(bty="l")
lines(x=all_k, y = toterr, col ="dodgerblue")
lines(x=all_k, y = fpr, col ="indianred1")
lines(x=all_k, y = tpr, col ="limegreen")
lines(x=all_k, y = ppv, col ="peru")
lines(x=all_k, y = npv, col ="violetred")

legend("center", legend = c("toterr", "fpr", "tpr", "ppv", "npv"), 
       col = c("dodgerblue", "indianred1", "limegreen", "peru", "violetred"),
         lty=1, bty="n")

plot(NULL, xlim = c(1,length(all_k[1:10])), ylim=c(0,1), 
     xlab="k", ylab="ratio", bty="l",
     axes=F)
axis(1, at=1:length(all_k[1:10]),labels = all_k[1:10])
axis(2)
box(bty="l")
lines(x=all_k[1:10], y = toterr[1:10], col ="dodgerblue")
lines(x=all_k[1:10], y = fpr[1:10], col ="indianred1")
lines(x=all_k[1:10], y = tpr[1:10], col ="limegreen")
lines(x=all_k[1:10], y = ppv[1:10], col ="peru")
lines(x=all_k[1:10], y = npv[1:10], col ="violetred")

all_ratios <- c("toterr", "fpr", "tpr", "ppv", "npv")
all_col <- setNames( c("dodgerblue", "indianred1", "limegreen", "peru", "violetred"), all_ratios)

for(curr in all_ratios) {
  plot(x=all_k,y= eval(parse(text = curr)), lty=1,
       main = curr, type="l",
       xlab="k", ylab="ratio", bty="l", col = all_col[curr])
}

# if k too small -> lot of errors, separation if not smooth enough
# then errors start increasing again, because overfitting, works very well on the training data but not on novel data
# but depends on the way we split the data => this is why we do cross-validation, to be sure that the results
# do not just depend on the way we split the data.

# tip for plotting the colors:
plot(data$x,data$y,col=c("red", "blue")[data$group])


# This way of proceeding only uses one experiment -- and the choice of k could depend strongly on chance 
# (how the split learning/testing set was done). In order to obtain a more robust answer, use cross-validation 
# to obtain different occurences of error for each value of k. What results do you see ?
fold_cv <- 5
data_idx <- createFolds(1:nrow(data), fold_cv)
# data_idx holds for the # fold_cv the row index of the dataframe that will be use for testing
# each element of data_idx will be in turn the test dataset

# !!! for the cross-validation, be careful to not take split in such way to take the first X data, 
# then the following X data, etc.

# two loops -> loop over the fold and loop over the k

# For each value of k
res <- lapply(all_k, function(k) {
  # loop over the cross-validation
  res.k <- sapply(seq_along(data_idx), function(i) {
    # select the training and testing data for this iteration
    learning_data  <- data[-data_idx[[i]] ,]
    testing_data   <- data[data_idx[[i]] ,]
    fit <- knn3(group ~ x + y, data=learning_data, k=k)
    testing_votes  <- predict(fit, newdata=testing_data)
    testing_predictions <- as.numeric(testing_votes[,2]>0.5)+1
    # total number of errors:
    toterr <- sum(testing_data$group != testing_predictions)/length(testing_predictions)
    toterr
  })
  ##average over the 10 folds
  #mean(res.k)
  res.k
})

cvDT <- data.frame(res)
colnames(cvDT) <- paste0("k_", all_k)

cvDT_m <- melt(cvDT)
cvDT_m$variable <- gsub("k_", "", cvDT_m$variable)

ggplot(cvDT_m, aes(x=variable, y = value)) + 
  geom_boxplot()+ 
  xlab("k values") + 
  ylab("Tot. error rate")+
  theme( # Increase size of axis lines
    panel.grid = element_blank(),
    axis.line.x = element_line(size = .2, color = "black"),
    axis.line.y = element_line(size = .3, color = "black"),
    axis.text.y = element_text(color="black", hjust=1,vjust = 0.5),
    axis.text.x=element_text(size=10, vjust=0.5, hjust=0.5),
    axis.title.y = element_text(color="black", size=14),
    axis.title.x = element_text(color="black", size=14),
    panel.border = element_blank(),
    panel.background = element_rect(fill = "transparent"),
    legend.background =  element_rect(),
    legend.key = element_blank())
  

# => most important thing here: for a given k, lot of variability between the folds (height of the boxplot)
# just relying on 1 cut of training vs. learning is not enough !!!
# betw. 19 and 25 => seems to be the best, give very similar results

# => with CV as a result, we don't get a single model, but gives an indication to which models we should look at
# (e.g. here k = 19-25)
# for reproducibility and not to be accused of cheating (choice of the seed that gives the reesult that we want),
# good practice could be to choose seed like "201711201" (year-month-day-number), good because transparent
# besides, if different seeds lead to different results, it is not good sign (pick noise everytime)

# just run again to store the right model in the variables
learning_data  <- data[1:250,]
testing_data   <- data[251:500,]
fit <- knn3(group ~ x + y, data=learning_data, k=5)
learning_votes <- predict(fit, newdata=learning_data)
testing_votes  <- predict(fit, newdata=testing_data)
testing_predictions <- as.numeric(testing_votes[,2]>0.5)+1
table(testing_data$group, testing_predictions)

#**********************************************************************
#********************************************************************** Linear discriminant analysis
#**********************************************************************
# fit an LDA model using lda() from MASS package 
learning_data  <- data[1:250,]
ldafit <- lda(group ~ x + y, data=learning_data)
# print the result, including the linear combination of the variables
ldafit
# find the predicted values (on the learning set) 
ldapredict <- predict(ldafit)
# -> returns 3 components:
# 1- ldapredict$class: the predicted class (here, 1 or 2)
# 2- ldapredict$posterior: the probability of being in class 1 or 2
# 3- ldapredict$x: the score obtained after the linear combination.

# the same prediction on the testing data can also be obtained in the following way:
lda_testing_predictions <- predict(ldafit, newdata=testing_data)$class

# Create the confusion matrix, and compare the results with those obtained with the k-NN classifier.
table(testing_data$group, lda_testing_predictions)

#           predict. 1     predict. 2
# true 1    108             21
# true 2    13              108


#**********************************************************************
#********************************************************************** Quadratic discriminant analysis
#**********************************************************************

# fit an LDA model using lda() from MASS package 
learning_data  <- data[1:250,]
qdafit <- qda(group ~ x + y, data=learning_data)
# print the result, including the linear combination of the variables
qdafit
# find the predicted values (on the learning set) 
qdapredict <- predict(qdafit)
# -> returns 3 components:
# 1- ldapredict$class: the predicted class (here, 1 or 2)
# 2- ldapredict$posterior: the probability of being in class 1 or 2
# 3- ldapredict$x: the score obtained after the linear combination.

# the same prediction on the testing data can also be obtained in the following way:
qda_testing_predictions <- predict(qdafit, newdata=testing_data)$class

# Create the confusion matrix, and compare the results with those obtained with the k-NN classifier.
table(testing_data$group, qda_testing_predictions)

#           predict. 1     predict. 2
# true 1    119             10
# true 2    14              107


#**********************************************************************
#********************************************************************** Plotting ROC curves
#**********************************************************************

# plot the ROC curves for the LDA
learning_data  <- data[1:250,]
testing_data  <- data[251:500,]
fit <- lda(group ~ x + y, data=learning_data)

# Get the group information -- transform "1 and 2" into "0 and 1"
G_learning <- as.numeric(learning_data$group)-1
G_testing  <- as.numeric(testing_data$group)-1

# !!! here, we need to take the "posterior", the probabilities
# to be assigned to a given class, not the predicted class
# because we want to iterate over all possible thresholds
# (if we take the predicted class -> it is like we take a unique threshold of 0.5)

# Get the scores ["fit" should be LDA object !]
# posterior = 1 column for each class, probability that the observation belongs to that class
# -> so here, probability of belonging to class 1 (row sum is 1)
# (take the 1st or 2nd column, is the same, everything is reversed)
# (everywhere above: higher probab = class 2 -> why we take 2nd column  here)
score_l <- predict(fit,newdata=learning_data)$posterior[,2]
score_t <-  predict(fit,newdata=testing_data)$posterior[,2]
# Create a prediction object (required by ROCR)
pred_l <- prediction( score_l, G_learning )
pred_t <- prediction( score_t, G_testing )

# Calculate the TPR and FPR for plotting the ROC curve
perf_l <- performance( pred_l, "tpr", "fpr" ) 
perf_t <- performance( pred_t, "tpr", "fpr" )

# Plot the ROC curve for the testing set first,
# then (in gray) for the learning set
plot( perf_t ) 
plot( perf_l, add=TRUE, col="grey")

# Calculate the AUC
auc_l <- performance(pred_l, measure ="auc")
auc_t <- performance(pred_t, measure ="auc")



