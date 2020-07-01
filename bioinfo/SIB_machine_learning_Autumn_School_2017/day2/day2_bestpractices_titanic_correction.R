#=======================================================================================
# Machine learning using caret.
#
# Predict who is going to survive the titanic
#=======================================================================================

## Setting up your seed is important to be able to reproduce your analysis
## Comments on how you should do your analysis
## Don't copy-paste code from your text editor
## At the end you should be able to reproducde your analysis
## by using the source function [this is the ultimate proof] 
set.seed(54321)

# Might need to install some packages.
#install.packages(c("e1071", "caret"))

library(caret)

#=================================================================
# Load Data
#=================================================================

## train <- read.csv("https://raw.githubusercontent.com/datasciencedojo/meetup/master/intro_to_ml_with_r_and_caret/train.csv", stringsAsFactors = FALSE)
train <- read.csv("train.csv", stringsAsFactors = FALSE)

View(train)

#=================================================================
# Data Wrangling
#=================================================================

# Replace missing embarked values with mode.
table(train$Embarked)
train$Embarked[train$Embarked == ""] <- "S"


# Add a feature for tracking missing ages.
summary(train$Age)
train$MissingAge <- ifelse(is.na(train$Age),
                           "Y", "N")

# Add a feature for family size.
train$FamilySize <- 1 + train$SibSp + train$Parch

# Set up factors.
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)
train$MissingAge <- as.factor(train$MissingAge)

# Subset data to features we wish to keep/use.
features <- c("Survived", "Pclass", "Sex", "Age", "SibSp",
              "Parch", "Fare", "Embarked", "MissingAge",
              "FamilySize")
train <- train[, features]
str(train)

#=================================================================
# Impute Missing Ages
#=================================================================

# Caret supports a number of mechanism for imputing (i.e., 
# predicting) missing values. Leverage bagged decision trees
# to impute missing values for the Age feature.

# First, transform all feature to dummy variables.
dummy.vars <- dummyVars(~ ., data = train[, -1])
train.dummy <- predict(dummy.vars, train[, -1])
View(train.dummy)

# Now, impute!
pre.process <- preProcess(train.dummy, method = "bagImpute")
imputed.data <- predict(pre.process, train.dummy)
View(imputed.data)

train$Age <- imputed.data[, 6]
View(train)


#=================================================================
# Split Data
#=================================================================

# Use caret to create a 70/30% split of the training data,
# keeping the proportions of the Survived class label the
# same across splits.

indexes <- createDataPartition(train$Survived,
                               times = 1,
                               p = 0.7,
                               list = FALSE)
titanic.train <- train[indexes,]
titanic.test <- train[-indexes,]

# Examine the proportions of the Survived class label across
# the datasets.
prop.table(table(train$Survived))
prop.table(table(titanic.train$Survived))
prop.table(table(titanic.test$Survived))

#=================================================================
# Train Models
#=================================================================

# Set up caret to perform 10-fold cross validation repeated 3 
# times and to use a grid search for optimal model hyperparamter
# values.
train.control <- trainControl(method = "repeatedcv",
                              number = 10,
                              repeats = 3)


## If you need speed!!!
## require(doSNOW)
# Use the doSNOW package to enable caret to train in parallel.
# While there are many package options in this space, doSNOW
# has the advantage of working on both Windows and Mac OS X.
#
# Create a socket cluster using 10 processes. 
#
# NOTE - Tune this number based on the number of cores/threads 
# available on your machine!!!
#
##  cl <- makeCluster(10, type = "SOCK")

# Register cluster so that caret will know to train in parallel.
## registerDoSNOW(cl)


## ALL the models
## names(getModelInfo())
## http://topepo.github.io/caret/available-models.html

caret.cv.knn <- train(Survived ~ ., 
                      data = titanic.train,
                      method = "knn",
                      trControl = train.control,
                      tuneLength = 10)

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

## variable importance ?
varImp(caret.cv.svmradial)
table(train$Sex,train$Survived)
boxplot(train$Fare ~ train$Survived)
table(train$Pclass,train$Survived)

## stopCluster(cl)

# Examine caret's processing results
caret.cv.svmradial

# Apply on test set
preds <- predict(caret.cv.svmradial, titanic.test)

# Use caret's confusionMatrix() function to estimate the 
# effectiveness of this model on unseen, new data.
confusionMatrix(preds, titanic.test$Survived)

#=================================================================
# ROC curves
#=================================================================
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


## Test for significance
t.test(results$values[,2],results$values[,4])
t.test(results$values[,2],results$values[,6])
t.test(results$values[,4],results$values[,6])

# Now repeat the same analysis on the segmentation dataset!
