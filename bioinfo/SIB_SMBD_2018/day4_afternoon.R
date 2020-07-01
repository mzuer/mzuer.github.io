data <- read.delim("diabetes.csv", sep=",", stringsAsFactors = F)


data2 <- data[data$BMI != 0,]

respVar <- colnames(data)[colnames(data) != "Outcome"]

#################################  
### DATA EXPLORATION
#################################

# look at the distribution of the variables
for(i in respVar) {
  plot(density(data[,i]), main = i)
  plot(density(log10(data[,i]+0.001)), main = paste0("log ", i))
}
dim(data)

# look at the boxplot (si on veut faire des tests -> transformer en dist. normale !!!)
for(i in respVar) {
  tmpData <- data[,c(i, "Outcome")]
  boxplot(as.formula(paste0(i, "~ Outcome")), data =tmpData, main = i)
}
dim(data)


pairs(data[,respVar])
pairs(data)

#################################  
### DATA EXPLORATION - PCA
#################################

# PCA
pcaData <- prcomp(data[,-which(colnames(data) == "Outcome")], center = TRUE, scale = TRUE) 
#coordinate of sample on components were identified 
#Importance of components 
summary(pcaData) 
plot(pcaData$x, col = data$Outcome+1) 
summary(pcaData)



#################################  
### DATA EXPLORATION - LDA
#################################

# !!! transformer !!!

library(MASS) 


train <- sample(1:nrow(data), nrow(data)/2)

lda_data <- lda(formula = Outcome ~ ., data = data,
         prior = c(1,1)/2, subset = train) 

lda_data$prior

lda_data$counts    #means for each covariate 

lda_data$means     #with 3 classes we have at most two linear discriminants

# a matrix which transforms observations to discriminant functions, normalized so that within groups covariance matrix is spherical.
lda_data$scaling   

#the singular values (svd) that gives the ratio of the between-  
# and within-group standard deviations on the linear discriminant  variables. 
lda_data$svd

# amount of the between-group variance that is explained by each  linear discriminant 
prop <- lda_data$svd^2/sum(lda_data$svd^2) 
print(prop)

pred_lda_data <- predict(object = lda_data, newdata = data[-train, ]) 
head(pred_lda_data$class) 
head(pred_lda_data$posterior, 3) 

sum( as.numeric(as.numeric(as.character(pred_lda_data$class)) == 1) == data$Outcome )
# 434
sum( as.numeric(as.numeric(as.character(pred_lda_data$class)) == 0) == data$Outcome )
# 334
#-> so the 2 correspond to outcome 1

lda_clust <- as.numeric(as.character(pred_lda_data$class))
sum(lda_clust == data$Outcome) / nrow(data)
#0.5651042

#################################  
### kmeans
#################################  


kmean_data <- kmeans(data[,respVar], centers=2, iter.max = 100)

sum( as.numeric(kmean_data$cluster == 1) == data$Outcome )
# 261
sum( as.numeric(kmean_data$cluster == 2) == data$Outcome )
# 507
#-> so the 2 correspond to outcome 1

kmean_clust <- kmean_data$cluster - 1
sum(kmean_clust == data$Outcome) / nrow(data)
#0.66

#################################  
### logit model
#################################  

# pas trop mal même sans transformation
# LDA marcherait mieux avec transform

logitMod <- glm(Outcome ~ Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age,
                data= data, family="binomial")
summary(logitMod)

# remove the least signif (skin thickness)
logitMod2 <- glm(Outcome ~ Pregnancies + Glucose + BloodPressure  + Insulin + BMI + DiabetesPedigreeFunction + Age,
                data= data, family="binomial")
summary(logitMod2)

# remove the least signif (skin thickness + insulin)
logitMod3 <- glm(Outcome ~ Pregnancies + Glucose + BloodPressure   + BMI + DiabetesPedigreeFunction + Age,
                 data= data, family="binomial")
summary(logitMod3)

# remove the least signif (skin thickness + insulin + age)
logitMod4 <- glm(Outcome ~ Pregnancies + Glucose + BloodPressure   + BMI + DiabetesPedigreeFunction ,
                 data= data, family="binomial")
summary(logitMod4)

# number of right predictions:
sum(as.numeric(fitted(logitMod4) > 0.5) == data$Outcome) / nrow(data)
# 0.77

#################################  
### decision tree
#################################  
library("rpart")
library("rpart.plot")

# split it into a training set and test set:
set.seed(2)
ind <- sample(2,nrow(data),replace=TRUE,prob=c(0.80,0.20))

data_training <- data[ind==1,]
data_test <- data[ind==2,]

data_training$Outcome <- as.factor(data_training$Outcome)
data_test$Outcome <- as.factor(data_test$Outcome)

#************************************************************************************* TREE 1:  all features

data_tree <- rpart(data=data_training,
              formula = Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age,
              method="class",
              control=rpart.control(minsplit=10,minbucket=5),
              parms=list(split="information"))
rpart.plot(data_tree,main="Classification tree for the data data (using 80% of data as training set) - all features",extra=101)

predictionsA <- predict(data_tree, newdata = data_training, type="class")
actualsA <- data_training$Outcome
table(actualsA,predictionsA)

predictionsA2 <- predict(data_tree,newdata=data_test,type="class")
actualsA2 <- data_test$Outcome
confusion.matrixA <- table(actualsA2,predictionsA2)
print(confusion.matrixA)


# This confusion matrix shows that the decision tree has made 2 mistakes in 35 preditions. 
# The test sets used for the neural network and the decision tree are the same, so we may compare their performances.

# Let us finally compute the accuracy of the tree:

accuracyTree <- sum(diag(confusion.matrixA))/sum(confusion.matrixA)
print(accuracyTree)
# 0.8253012

#************************************************************************************* TREE 2:  features from logreg

data_tree2 <- rpart(data=data_training,
                   formula = Outcome ~  Pregnancies + Glucose + BloodPressure   + BMI + DiabetesPedigreeFunction ,
                   method="class",
                   control=rpart.control(minsplit=10,minbucket=5),
                   parms=list(split="information"))
rpart.plot(data_tree2,main="Classification tree for the data data (using 80% of data as training set) - all features",extra=101)

predictionsB <- predict(data_tree2, newdata = data_training, type="class")
actualsB <- data_training$Outcome
table(actualsB,predictionsB)

predictionsB2 <- predict(data_tree2,newdata=data_test,type="class")
actualsB2 <- data_test$Outcome
confusion.matrixB <- table(actualsB2,predictionsB2)
print(confusion.matrixB)


# This confusion matrix shows that the decision tree has made 2 mistakes in 35 preditions. 
# The test sets used for the neural network and the decision tree are the same, so we may compare their performances.

# Let us finally compute the accuracy of the tree:

accuracyTreeB <- sum(diag(confusion.matrixB))/sum(confusion.matrixB)
print(accuracyTreeB)
# 0.7831325

#################################  
### random forest
#################################  

#************************************************************************************* RANDOM FOREST - all features
library(randomForest)

# !!! Outcome should be factor !!!

random_forest1 <- randomForest(data=data_training,
                               Outcome~Pregnancies + Glucose + BloodPressure + SkinThickness + Insulin + BMI + DiabetesPedigreeFunction + Age,
                               impurity='entropy',
                               ntree=25,
                               replace=TRUE)

# Predict the species for the “data_training” dataset (using all trees in the random forest):
predictionsC <- predict(random_forest1, newdata=data_training,type="class")
actualsC <- data_training$Outcome
table(actualsC,predictionsC)

# We see 100% accuracy: the random forest has perfecly learned the training data.

# Predict the species for the “data_test” dataset:
predictionsC <- predict(random_forest1, newdata=data_test, type="class")
actualsC <- data_test$Outcome
confusion.matrixC <- table(actualsC, predictionsC)
print(confusion.matrixC)

# Finally the accuracy:
accuracyC <- sum(diag(confusion.matrixC))/sum(confusion.matrixC)
print(accuracyC)
## [1] 0.8192771

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the data data) is small.

# Compute and plot the importance (of all the variables):
importance(random_forest1)
varImpPlot(random_forest1)


#************************************************************************************* RANDOM FOREST - features from logreg
# !!! Outcome should be factor !!!

random_forest2 <- randomForest(data=data_training,
                               Outcome~Pregnancies + Glucose + BloodPressure   + BMI + DiabetesPedigreeFunction ,
                               impurity='entropy',
                               ntree=25,
                               replace=TRUE)

# Predict the species for the “data_training” dataset (using all trees in the random forest):
predictionsD <- predict(random_forest2, newdata=data_training,type="class")
actualsD <- data_training$Outcome
table(actualsD,predictionsD)

# Predict the species for the “data_test” dataset:
predictionsD <- predict(random_forest2, newdata=data_test, type="class")
actualsD <- data_test$Outcome
confusion.matrixD <- table(actualsD, predictionsD)
print(confusion.matrixD)

# Finally the accuracy:
accuracyD <- sum(diag(confusion.matrixD))/sum(confusion.matrixD)
print(accuracyD)
## [1] 0.813253

# We see that the accuracy of the random forest is slighly lower than that of the decision tree. 
# This may happen when the number of feature variables (4 for the data data) is small.

# Dompute and plot the importance (of all the variables):
importance(random_forest2)
varImpPlot(random_forest2)



#################################  
### neural network
#################################  

library(keras)
library(keras)
use_session_with_seed(3)
library(ggfortify)

data_matrix <- as.matrix(data)

set.seed(2)
ind <- sample(2,nrow(data_matrix),replace=TRUE,prob=c(0.80,0.20))

data.training <- data_matrix[ind==1, respVar]
data.test <- data_matrix[ind==2, respVar]

data.trainingtarget <- data_matrix[ind==1,"Outcome"]
data.testtarget <- data_matrix[ind==2,"Outcome"]

data.trainLabels=to_categorical(data.trainingtarget)
data.testLabels=to_categorical(data.testtarget)

#************************************************************************************* NN 1
# Initialize a sequential model:
model <- keras_model_sequential()

# Add layers to the model with the “Glorot normal initializer” for the weights, a bias input node x0=1 and a bias hidden node z0=1:

# input_shape -> how many features as input
# units 20 => can be chosen
# units last layer = # of labels

model %>%
  layer_dense(input_shape=c(length(respVar)),units=20,activation='relu',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=2,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model)

# Compile and fit the model:

model %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history <- model %>% fit(data.training,data.trainLabels,epochs=200,batch_size=5,validation_split=0.2)

# Visualize the model training history:
plot(history)

predicted.classes <- model %>% predict_classes(data.test)
table(data.testtarget, predicted.classes)

score <- model %>% evaluate(data.test,data.testLabels)
print(score)

# $loss
# [1] 0.6636791
# 
# $acc
# [1] 0.7650602



#************************************************************************************* NN 2 with an additional layer
# Initialize a sequential model:
model2 <- keras_model_sequential()

# Add layers to the model with the “Glorot normal initializer” for the weights, a bias input node x0=1 and a bias hidden node z0=1:

# input_shape -> how many features as input
# units 20 => can be chosen
# units last layer = # of labels

model2 %>%
  layer_dense(input_shape=c(length(respVar)),units=20,activation='relu',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=20,activation='relu',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=2,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model2)

# Compile and fit the model:

model2 %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history2 <- model2 %>% fit(data.training,data.trainLabels,epochs=200,batch_size=5,validation_split=0.2)

# Visualize the model2 training history:
plot(history2)

predicted.classes2 <- model2 %>% predict_classes(data.test)
table(data.testtarget, predicted.classes)

score2 <- model2 %>% evaluate(data.test,data.testLabels)
print(score2)

# $loss
# [1] 0.5454347
# 
# $acc
# [1] 0.7650602


#************************************************************************************* NN 2 with an additional layer and sigmoid
# Initialize a sequential model:
model3 <- keras_model_sequential()

# Add layers to the model with the “Glorot normal initializer” for the weights, a bias input node x0=1 and a bias hidden node z0=1:

# input_shape -> how many features as input
# units 20 => can be chosen
# units last layer = # of labels

model3 %>%
  layer_dense(input_shape=c(length(respVar)),units=20,activation='relu',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=20,activation='relu',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=2,activation='sigmoid',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model3)

# Compile and fit the model:

model3 %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history3 <- model3 %>% fit(data.training,data.trainLabels,epochs=200,batch_size=5,validation_split=0.2)

# Visualize the model3 training history:
plot(history3)

predicted.classes3 <- model3 %>% predict_classes(data.test)
table(data.testtarget, predicted.classes)

score3 <- model3 %>% evaluate(data.test,data.testLabels)
print(score3)

# $loss
# [1] 0.5454347
# 
# $acc
# [1] 0.7650602
