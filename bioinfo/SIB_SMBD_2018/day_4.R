#====================================================================================
#========================================================= DECISION TREE
#====================================================================================

library("rpart")
library("rpart.plot")

# Load the iris dataset and split it into a training set and test set:
data(iris)

set.seed(2)
ind <- sample(2,nrow(iris),replace=TRUE,prob=c(0.80,0.20))

iris.training <- iris[ind==1,]
iris.test <- iris[ind==2,]

#************************************************************************************* TREE 1

# Make the decision tree model using the entropy as the impurity index:
  
# fit the rpart model

# minbucket = minimum number of samples in any terminal leaf
# minsplit = minimum number of samples that must exist in a node in order for a split to be attempted

tree <- rpart(data=iris.training,
              formula = Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
              method="class",
              control=rpart.control(minsplit=10,minbucket=5),
              parms=list(split="information"))
rpart.plot(tree,main="Classification tree for the iris data (using 80% of data as training set)",extra=101)

# We see that the first two splits of the decision tree use Petal.Length and Petal.Width. 
# We may want to look again at the exploratory analysis that we have done before building the neural network. 
# This may help you to understand better the iris tree structure. At least let us plot Petal.Width versus Petal.Length:
library(ggplot2)
qplot(Petal.Length, Petal.Width, data=iris, colour=Species, size=I(4))

# We clearly see the three groups (setosa, versicolor, virginica) are well separated by using only Petal.Length and Petal.Width.

# Predict the species for the “iris.training” dataset:
  
predictions <- predict(tree,newdata=iris.training,type="class")
actuals <- iris.training$Species
table(actuals,predictions)

##             predictions
## actuals      setosa versicolor virginica
##   setosa         36          0         0
##   versicolor      0         40         1
##   virginica       0          3        35

# Predict the species for the “iris.test” dataset:
  
predictions <- predict(tree,newdata=iris.test,type="class")
actuals <- iris.test$Species
confusion.matrix <- table(actuals,predictions)
print(confusion.matrix)

##             predictions
## actuals      setosa versicolor virginica
##   setosa         14          0         0
##   versicolor      0          9         0
##   virginica       0          2        10

# This confusion matrix shows that the decision tree has made 2 mistakes in 35 preditions. 
# The test sets used for the neural network and the decision tree are the same, so we may compare their performances.

# Let us finally compute the accuracy of the tree:
  
accuracy <- sum(diag(confusion.matrix))/sum(confusion.matrix)
print(accuracy)
# 0.9428571


#************************************************************************************* TREE 2
# use the pruning method instead to find the best tree:
  
tree2 <- rpart(data=iris,
               formula = Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                 method="class",
               control=rpart.control(minsplit=1,minbucket=1,cp=0.000001),
                 parms=list(split="information"))
rpart.plot(tree2,main="Bigest Tree",extra=101)

# Prints a table of optimal prunings based on a complexity parameter.
printcp(tree2)
plotcp(tree2)
ptree <- prune(tree2,cp=2.0e-02)
rpart.plot(ptree,main="Pruned Tree",extra=101)


predictions2 <- predict(ptree,newdata=iris.test,type="class")
actuals2 <- iris.test$Species
confusion.matrix2 <- table(actuals2,predictions2)
print(confusion.matrix2)

accuracy2 <- sum(diag(confusion.matrix2))/sum(confusion.matrix2)
print(accuracy2)
# 0.9429

# Questions: Play around with different hyperparameter values [split (“gini”), minsplit, minbucket, Species (Petal.Length+Petal.Width)] 
# in the hope that your model will perform better. Use the test set as a validation set.


#************************************************************************************* TREE 3 - Gini
# use the pruning method instead to find the best tree:

tree3 <- rpart(data=iris.training,
              formula = Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
              method="class",
              control=rpart.control(minsplit=10,minbucket=5),
              parms=list(split="gini"))
rpart.plot(tree3,main="Classification tree for the iris data (using 80% of data as training set) - split=Gini",extra=101)

predictions3 <- predict(tree3,newdata=iris.test,type="class")
actuals3 <- iris.test$Species
confusion.matrix3 <- table(actuals3,predictions3)
print(confusion.matrix3)

accuracy3 <- sum(diag(confusion.matrix3))/sum(confusion.matrix3)
print(accuracy3)
# 0.9429

#************************************************************************************* TREE 4 - petals only
# use the pruning method instead to find the best tree:

tree4 <- rpart(data=iris.training,
               formula = Species~Petal.Length+Petal.Width,
               method="class",
               control=rpart.control(minsplit=10,minbucket=5),
               parms=list(split="information"))
rpart.plot(tree4,main="Classification tree for the iris data (using 80% of data as training set) - Petal features only",extra=101)

predictions4 <- predict(tree4,newdata=iris.test,type="class")
actuals4 <- iris.test$Species
confusion.matrix4 <- table(actuals4,predictions4)
print(confusion.matrix4)

accuracy4 <- sum(diag(confusion.matrix4))/sum(confusion.matrix4)
print(accuracy4)
# 0.9429

#************************************************************************************* TREE 4b - sepals only
# use the pruning method instead to find the best tree:

tree4b <- rpart(data=iris.training,
               formula = Species~Sepal.Length+Sepal.Width,
               method="class",
               control=rpart.control(minsplit=10,minbucket=5),
               parms=list(split="information"))
rpart.plot(tree4b,main="Classification tree for the iris data (using 80% of data as training set) - Sepal features only",extra=101)

predictions4b <- predict(tree4b,newdata=iris.test,type="class")
actuals4b <- iris.test$Species
confusion.matrix4b <- table(actuals4b,predictions4b)
print(confusion.matrix4b)

accuracy4b <- sum(diag(confusion.matrix4b))/sum(confusion.matrix4b)
print(accuracy4b)
# 0.6


#************************************************************************************* TREE 5 - minsplit=5
# use the pruning method instead to find the best tree:

tree5 <- rpart(data=iris.training,
               formula = Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
               method="class",
               control=rpart.control(minsplit=5,minbucket=5),
               parms=list(split="information"))
rpart.plot(tree5,main="Classification tree for the iris data (using 80% of data as training set) - minsplit=5",extra=101)

predictions5 <- predict(tree5,newdata=iris.test,type="class")
actuals5 <- iris.test$Species
confusion.matrix5 <- table(actuals5,predictions5)
print(confusion.matrix5)

accuracy5 <- sum(diag(confusion.matrix5))/sum(confusion.matrix5)
print(accuracy5)
# 0.9429

#************************************************************************************* TREE 6 - minbucket=10
# use the pruning method instead to find the best tree:

tree6 <- rpart(data=iris.training,
               formula = Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
               method="class",
               control=rpart.control(minsplit=10,minbucket=10),
               parms=list(split="information"))
rpart.plot(tree6,main="Classification tree for the iris data (using 80% of data as training set) - minbucket=10",extra=101)

predictions6 <- predict(tree6,newdata=iris.test,type="class")
actuals6 <- iris.test$Species
confusion.matrix6 <- table(actuals6,predictions6)
print(confusion.matrix6)

accuracy6 <- sum(diag(confusion.matrix6))/sum(confusion.matrix6)
print(accuracy6)
# 0.9429

print(accuracy)
print(accuracy2) # tree pruning
print(accuracy3) # Gini
print(accuracy4) # petals only
print(accuracy4b) # sepals only
print(accuracy4) # minsplit=5
print(accuracy6) # minbucket=10


#====================================================================================
#========================================================= RANDOM FOREST
#====================================================================================

library(randomForest)

random_forest <- randomForest(data=iris.training,
                              Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                              impurity='gini',
                              ntree=200,
                              replace=TRUE)
print(random_forest)

# The above confusion matrix and the out-of-bag (OOB) error rate [6/115*100=5.22%] are obtained as follows: 
# -> for each plant in the training dataset, make a random forest prediction using only the trees that did not use that particular 
# plant in their bootstrap training subset. The random forest model is thus used to predict the data NOT drawn (the “out-of-bag” sample).

# Let us plot the misclassification error rate as a function of the number of trees used in the random forest:
  
plot(random_forest)
legend("top",cex=0.8,legend=colnames(random_forest$err.rate),lty=c(1,2,3),col=c(1,2,3),horiz=T)

# The x-axis is the “number of trees” and the y-axis is the “misclassification error rate”. 
# The black solid line represents the overall OOB error. 
# The colour lines are the class errors (one for each species: red=Setosa, green=Versicolor and blue=Virginica). 
# We see that we should use about 25 trees:
  
random_forest <- randomForest(data=iris.training,
                           Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                           impurity='gini',ntree=25,replace=TRUE)

# Predict the species for the “iris.training” dataset (using all trees in the random forest):
  
predictions <- predict(random_forest,newdata=iris.training,type="class")
actuals <- iris.training$Species
table(actuals,predictions)

# We see 100% accuracy: the random forest has perfecly learned the training data.

# Predict the species for the “iris.test” dataset:
  
predictions <- predict(random_forest,newdata=iris.test,type="class")
actuals <- iris.test$Species
confusion.matrix <- table(actuals,predictions)
print(confusion.matrix)

# Finally the accuracy:
accuracy <- sum(diag(confusion.matrix))/sum(confusion.matrix)
print(accuracy)
## [1] 0.9142857

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the iris data) is small.

# Compute and plot the importance (of all the variables):
importance(random_forest)
varImpPlot(random_forest)
  
# As in the decision tree, we see that the Petal.Length and Petal.Width are the most important predictors.
  
#   Questions: Play around with different parameter values 
#   (impurity (‘entropy’), ntree, replace (FALSE), 
#   sampsize (size of sample to draw; default: N if replace=TRUE, 0.63*N otherwise), 
#     mtry (the number of variables randomly sampled as candidates at each split; default: sqrt(4)=2)] 
# in the hope that your model will perform better.


#************************************************************************************* RF2 - impurity = entropy
random_forest2 <- randomForest(data=iris.training,
                              Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                              impurity='entropy',
                              ntree=25,
                              replace=TRUE)

# Predict the species for the “iris.training” dataset (using all trees in the random forest):
predictions2 <- predict(random_forest2, newdata=iris.training,type="class")
actuals2 <- iris.training$Species
table(actuals2,predictions2)

# We see 100% accuracy: the random forest has perfecly learned the training data.

# Predict the species for the “iris.test” dataset:
predictions2 <- predict(random_forest2, newdata=iris.test, type="class")
actuals2 <- iris.test$Species
confusion.matrix2 <- table(actuals2, predictions2)
print(confusion.matrix2)

# Finally the accuracy:
accuracy2 <- sum(diag(confusion.matrix2))/sum(confusion.matrix2)
print(accuracy2)
## [1] 0.9428571

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the iris data) is small.

# Compute and plot the importance (of all the variables):
importance(random_forest2)
varImpPlot(random_forest2)


#************************************************************************************* RF3 - ntree = 50
random_forest3 <- randomForest(data=iris.training,
                               Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                               impurity='entropy',
                               ntree=50,
                               replace=TRUE)

# Predict the species for the “iris.training” dataset (using all trees in the random forest):
predictions3 <- predict(random_forest3, newdata=iris.training,type="class")
actuals3 <- iris.training$Species
table(actuals3,predictions3)

# We see 100% accuracy: the random forest has perfecly learned the training data.

# Predict the species for the “iris.test” dataset:
predictions3 <- predict(random_forest3, newdata=iris.test, type="class")
actuals3 <- iris.test$Species
confusion.matrix3 <- table(actuals3, predictions3)
print(confusion.matrix3)

# Finally the accuracy:
accuracy3 <- sum(diag(confusion.matrix3))/sum(confusion.matrix3)
print(accuracy3)
## [1] 0.9142857

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the iris data) is small.

# Compute and plot the importance (of all the variables):
importance(random_forest3)
varImpPlot(random_forest3)


#************************************************************************************* RF4 - replace=FALSE
random_forest4 <- randomForest(data=iris.training,
                               Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                               impurity='entropy',
                               ntree=25,
                               replace=FALSE)

# Predict the species for the “iris.training” dataset (using all trees in the random forest):
predictions4 <- predict(random_forest4, newdata=iris.training,type="class")
actuals4 <- iris.training$Species
table(actuals4,predictions4)

# We see 100% accuracy: the random forest has perfecly learned the training data.

# Predict the species for the “iris.test” dataset:
predictions4 <- predict(random_forest4, newdata=iris.test, type="class")
actuals4 <- iris.test$Species
confusion.matrix4 <- table(actuals4, predictions4)
print(confusion.matrix4)

# Finally the accuracy:
accuracy4 <- sum(diag(confusion.matrix4))/sum(confusion.matrix4)
print(accuracy4)
## [1] 0.9428571

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the iris data) is small.

# Compute and plot the importance (of all the variables):
importance(random_forest4)
varImpPlot(random_forest4)

#************************************************************************************* RF5 - replace=FALSE
random_forest4 <- randomForest(data=iris.training,
                               Species~Sepal.Width+Sepal.Length+Petal.Length+Petal.Width,
                               impurity='entropy',
                               ntree=25,
                               replace=FALSE)

# Predict the species for the “iris.training” dataset (using all trees in the random forest):
predictions4 <- predict(random_forest4, newdata=iris.training,type="class")
actuals4 <- iris.training$Species
table(actuals4,predictions4)

# We see 100% accuracy: the random forest has perfecly learned the training data.

# Predict the species for the “iris.test” dataset:
predictions4 <- predict(random_forest4, newdata=iris.test, type="class")
actuals4 <- iris.test$Species
confusion.matrix4 <- table(actuals4, predictions4)
print(confusion.matrix4)

# Finally the accuracy:
accuracy4 <- sum(diag(confusion.matrix4))/sum(confusion.matrix4)
print(accuracy4)
## [1] 0.9428571

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the iris data) is small.

# Compute and plot the importance (of all the variables):
importance(random_forest4)
varImpPlot(random_forest4)



##################
print(accuracy)
print(accuracy2) # impurity = entropy
print(accuracy3) # ntree=50
print(accuracy4)  # replace=FALSE
