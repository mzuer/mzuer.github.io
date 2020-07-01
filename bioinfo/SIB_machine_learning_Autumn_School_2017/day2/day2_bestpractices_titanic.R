setwd("~/Documents/PhD_courses/ML_Autumn_School/Rscripts")

set.seed(54321)
# set.seed to reproduce ! get consistency in random number generation
# lot of randomness in machine learning, e.g. for randomly splitting datasets

library(caret)

# AIM: predict the survival according to the different features

train <- read.delim("day2_train.csv", header=T, sep=",", stringsAsFactors = F)
View(train)

boxplot(Age ~ Survived, data=train, main="Survival ~ age")

# Already some features to select that could 
# -> sex, age
# for NA -> correct, fill with values that make sense according to other variables
# Fare: how much the ticket costs for the person
# Cabin: too sparse, discard

#=================================================================================================
# Data Wrangling
#=================================================================================================
# look at city of embarcation
table(train$Embarked)
#     C   Q    S 
# 2 168  77   644 

# 2 passengers for which cities is missing
# (could be removed)
# instead of removing, as S is a very high number, we assign it to S

train$Embarked[train$Embarked == ""] <- "S"
table(train$Embarked)

# Add a feature for tracking missing age 
summary(train$Age)
train$MissingAge <- ifelse(is.na(train$Age), "Y", "N")
table(train$MissingAge)

# Combine # of spouses, sieblings, etc. to family size
# (1 for the passenger itself, then if there are sieblings and kids)
train$FamilySize <- 1 + train$SibSp + train$Parch

# Set to factor (for caret)
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)
train$MissingAge <- as.factor(train$MissingAge)


features <- c("Survived", "Pclass", "Sex", "Age", "SibSp", 
              "Parch", "Fare", "Embarked", "MissingAge", "FamilySize")

train <- train[, features]
str(train)

#=================================================================================================
# Input missing ages
#=================================================================================================
# Caret supports a number of mechanisms for imputing missing values
# leverage bagged decision trees to impute missing values for the Age feature

# convert to numeric data (dummy variable)
# (convert categorical data to number to be able to do the imputation)
# remove the 1st column, to remove the column with the survival
# 1st transform all features to dummy variables
dummy.vars <- dummyVars(~., data = train[,-1]) # say what you want to do
train.dummy <- predict(dummy.vars, train[,-1]) # execute what you want to do
View(train.dummy)

# now impute
pre.process <- preProcess(train.dummy, method="bagImpute")
imputed.data <- predict(pre.process, train.dummy)
View(imputed.data)

# replace the age in the dataset with the imputed ages
train$Age <-  imputed.data[,6]


#=================================================================================================
# Split data
#=================================================================================================

# Create 1st partition: training set vs. testing set
# take 70% of the dataset
# create 70%/30% split of the training data, keeping the proportions of the
# survived class label the same across splits

# also within cross-validation, it is important to keep the same proprotions !!!

# (randomness within)
indexes <- createDataPartition(train$Survived,
                               times = 1,
                               p = 0.7,
                               list=FALSE)

length(indexes)
# indexes of the passengers we want in the training set

titanic.train <- train[indexes,]
titanic.test <- train[-indexes,]

# By using createDataPartition => the proportions are conserved !!! IMPORTANT !!!
# (do not create partitions by yourselves)

# Examine the proportions of the Survived class label across the datasets
prop.table(table(train$Survived))
# 0.6161616 0.3838384
prop.table(table(titanic.train$Survived))
# 0.616 0.384
prop.table(table(titanic.test$Survived))
# 0.6165414 0.3834586

# => now ready to train models !

#=================================================================================================
# Split data
#=================================================================================================

# trainControl -> a way to describe what you want to do 
# method = repeatedcv = cross-validation repeated multiple times, as we have a big dataset, we can afford a repeated CV
# number = 10 => 10-fold cross validation
# repeates = 3 => 3 times 10'-fold cross validatino
# => lot of accuracy'

# 3 times 10-fold CV => you test 30x the accuracy of your model
# (you get an estimate of the performance of your model)

train.control <- trainControl(method = "repeatedcv", 
                              number = 10,
                              repeats=3
                              )

# speed up things to run parallel
require(doSNOW)
cl <- makeCluster(2, type="SOCK")
registerDoSNOW(cl)
# then caret will be able to run on multi cpu

### ALL THE MODELS
names(getModelInfo())
# see: topepo.github.io/caret/available-models.html
# some algorithms good for both classification and regression
# some are better for one than for the other

caret.cv.knn <- train(Survived ~ .,
                      data = titanic.train,
                      method = "knn",
                      trControl = train.control,
                      tuneLength = 10
                      )

# tuneLength => what k you test (5,7,9 by default)
# try KNN model using 3 times 10-CV

caret.cv.lda <- train(Survived ~ ., 
                      data = titanic.train,
                      method = "lda")

caret.cv.nb <- train(Survived ~ ., 
                     data = titanic.train,
                     method = "naive_bayes",
                     trControl = train.control,
                     tuneLength = 10)

caret.cv.rf <- train(Survived ~ ., 
                     data = titanic.train,
                     method = "rf",
                     trControl = train.control)

caret.cv.svm <- train(Survived ~ ., 
                      data = titanic.train,
                      method = "svmLinear",
                      trControl = train.control)

caret.cv.svmradial <- train(Survived ~ ., 
                            data = titanic.train,
                            method = "svmRadial",
                            trControl = train.control)

caret.cv.pls <- train(Survived ~ ., 
                            data = titanic.train,
                            method = "pls",
                            trControl = train.control)

# in practice:
# keep to the ones of this list
# here not so much features, not really need to regularized
# glmnet -> lasso
# depend on the input data
# (e.g. their distribution, for data transformation)
# (try to transform, look if it looks better)
# method like booting can be good if data very heterogeneous (as it weight "individually" the data points)

# issue of multiple testing caused by the number of models you try ?
# each model you try, everytime assessed with cross-validation
# the cross-validation is unbiased
# => so it is fine because of cross-validation
# test how many models as long as you test accuracy with cross-validation

## variable importance ?
# => which features are important in the model
# (you can already see by looking at table())
varImp(caret.cv.svmradial)
table(train$Sex,train$Survived)
boxplot(train$Fare ~ train$Survived)
boxplot(train$Fare ~ train$Survived, outline=F)
table(train$Pclass,train$Survived)

# do not use these models to learn something 
# ask directly
# do not use machine learning to get the importance
# and these features and the data, but rather directly
# look association between these variables and the data points
# machine learning as a tool to predict future
# but no use machine learning to learn something about the data

stopCluster(cl)

# Examine caret's processing results
caret.cv.svmradial

# Apply on test set
preds <- predict(caret.cv.svmradial, titanic.test)

# Use caret's confusionMatrix() function to estimate the 
# effectiveness of this model on unseen, new data.
confusionMatrix(preds, titanic.test$Survived)

# in the case of imbalanced dataset:
# compare performance you will get for higher classe
# because at random
# classifier juste telling e.g.
# be careful with metrics like accuracy not to be fool by artifiical performance !
# no information rate => comparing performance against a stupid classifier 
# that classifies passengers as the most abundand class
# => compare Accuracy to No information rate
# specificity => also you should look at in the case of imbalanced classes



#=================================================================
# ROC curves
#=================================================================
# now use the test data to see the predictions
preds.prob <- predict(caret.cv.nb, titanic.test,type="prob")

require(ROCR)
rocr.p = prediction(preds.prob[,2],titanic.test$Survived)
rocr.perf = performance(rocr.p,"tpr","fpr")
plot(rocr.perf,colorize=T,lwd=5)
abline(a=0,b=1)

performance(rocr.p,"auc")

#=================================================================
# Compare different approaches
#=================================================================
results <- resamples(list(KNN=caret.cv.knn, SVM=caret.cv.svmradial, PLS=caret.cv.pls))
summary(results)
diff.results = diff(results)
bwplot(diff.results)
head(results$values)

## Test for significance
# for 
t.test(results$values[,2],results$values[,4]) # e.g. for testing KNN vs. SVM
t.test(results$values[,2],results$values[,6])
t.test(results$values[,4],results$values[,6])

# Now repeat the same analysis on the segmentation dataset!

