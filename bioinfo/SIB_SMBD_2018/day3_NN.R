library(keras)
install_keras()
library(keras)
use_session_with_seed(3)
data(iris)

library(ggfortify)
log.iris=log(iris[,1:4])
iris.pca=prcomp(log.iris,center=TRUE,scale.=TRUE) 
autoplot(iris.pca,data=iris,colour='Species',main="PCA of the iris dataset")

plot(iris$Sepal.Length,iris$Sepal.Width,pch=21,bg=c("red","green3","blue")[unclass(iris$Species)],xlab="Sepal Length",ylab="Sepal Width")
plot(iris$Petal.Length,iris$Petal.Width,pch=21,bg=c("red","green3","blue")[unclass(iris$Species)],xlab="Petal Length",ylab="Petal Width")


# Turn the “iris” dataset into a matrix:
  
iris[,5]=as.numeric(iris[,5])-1
iris=as.matrix(iris)
dimnames(iris)=NULL

# Split the “iris” dataset into training and test datasets (the validation set will be included in the train set later on):
  
set.seed(2)
ind=sample(2,nrow(iris),replace=TRUE,prob=c(0.80,0.20))

iris.training=iris[ind==1,1:4]
iris.test=iris[ind==2,1:4]

iris.trainingtarget=iris[ind==1,5]
iris.testtarget=iris[ind==2,5]

iris.trainLabels=to_categorical(iris.trainingtarget)
iris.testLabels=to_categorical(iris.testtarget)

# Initialize a sequential model:
  
model=keras_model_sequential()

# Add layers to the model with the “Glorot normal initializer” for the weights, a bias input node x0=1 and a bias hidden node z0=1:
  
model %>%
  layer_dense(input_shape=c(4),units=8,activation='relu',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=3,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model)


# There are 5x8=40 links between the input and the hidden layer (4 initial nodes + 1 bias node x0=1, and 8 nodes in the hidden layer). 
# There are 9x3=27 links between the hidden layer and the outer layer (9 nodes in the hidden layer including the bias z0=1, 
# and 3 nodes at the output layer). 
# Altogether there there 67 weight parameters to fit.


# Compile and fit the model:
  
model %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history=model %>% fit(iris.training,iris.trainLabels,epochs=200,batch_size=5,validation_split=0.2)

# Visualize the model training history:
  
plot(history)


# We see that at 200 epochs there is no sign of over-fitting, so we will take this value (if you try larger values of epochs, 
#  you will see no significant decrease in the loss function). Now that your model is created, compiled and has been fitted to the data, 
# it is time to actually use your model to predict the labels for your test set “iris.test”:

predicted.classes=model %>% predict_classes(iris.test)
table(iris.testtarget,predicted.classes)

# The above confusion matrix shows that the neural network has made only 3 mistakes in 35 predictions. 
# As expected there is some confusion between versicolor and virginica. Let us now compute the loss and accuracy values:
  
score=model %>% evaluate(iris.test,iris.testLabels)
print(score)



# (0) Play around with different hyperparameter values
# [activation (‘sigmoid’ or ‘tanh’), kernel_initializer (“glorot_uniform”), use_bias (FALSE), epochs, batch size, optimizer (“sgd”)] in the hope that your model will perform better.
# We may want to look at https://keras.rstudio.com/.
# _2: with different activation
model_2=keras_model_sequential()
model_2 %>%
  layer_dense(input_shape=c(4),units=8,activation='sigmoid',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=3,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model_2)
model_2 %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history_2=model_2 %>% fit(iris.training,iris.trainLabels,epochs=200,batch_size=5,validation_split=0.2)
plot(history_2)
predicted.classes=model_2 %>% predict_classes(iris.test)
table(iris.testtarget,predicted.classes)
score_2=model_2 %>% evaluate(iris.test,iris.testLabels)
print(score_2)

# _2b without bias
model_2b=keras_model_sequential()
model_2b %>%
  layer_dense(input_shape=c(4),units=8,activation='sigmoid',kernel_initializer="glorot_normal",use_bias=FALSE) %>%
  layer_dense(units=3,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model_2b)
model_2b %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history_2b=model_2b %>% fit(iris.training,iris.trainLabels,epochs=200,batch_size=5,validation_split=0.2)
plot(history_2b)
predicted.classes=model_2b %>% predict_classes(iris.test)
table(iris.testtarget,predicted.classes)
score_2b=model_2b %>% evaluate(iris.test,iris.testLabels)
print(score_2b)



# (1) Try adding more hidden units to the model. 
model_3=keras_model_sequential()
model_3 %>%
  layer_dense(input_shape=c(4),units=10,activation='sigmoid',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=3,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model_3)
model_3 %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history_3=model_3 %>% fit(iris.training,iris.trainLabels,epochs=200,batch_size=5,validation_split=0.2)
plot(history_3)
predicted.classes=model_3 %>% predict_classes(iris.test)
table(iris.testtarget,predicted.classes)
score_3=model_3 %>% evaluate(iris.test,iris.testLabels)
print(score_3)

# (2) Try adding another layer to your model.  
model_4=keras_model_sequential()
model_4 %>%
  layer_dense(input_shape=c(4),units=8,activation='sigmoid',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(input_shape=c(4),units=8,activation='sigmoid',kernel_initializer="glorot_normal",use_bias=TRUE) %>%
  layer_dense(units=3,activation='softmax',kernel_initializer="glorot_normal",use_bias=TRUE)
summary(model_4)
model_4 %>% compile(loss='categorical_crossentropy',optimizer='adam',metrics='accuracy')
history_4=model_4 %>% fit(iris.training,iris.trainLabels,epochs=200,batch_size=5,validation_split=0.2)
plot(history_4)
predicted.classes=model_4 %>% predict_classes(iris.test)
table(iris.testtarget,predicted.classes)
score_4=model_4 %>% evaluate(iris.test,iris.testLabels)
print(score_4)
