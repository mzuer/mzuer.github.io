############################ TRAIN VALIDATION TEST  VALIDATION ************************************* DEEP LEARNING - Patterson Gibson

Training, validation, and test data
It’s considered a best practice to not only split out the training data into training
and test splits, but validation splits, as well. We use validation splits to guide our
efforts in possibly stopping training early.

############################ Pattern recognition bishop

<NONE>


############################ The Elements of Statistical Learning - Hastie et al.

<NONE>

############################

Validation DatasetIn principle we should not touch our test set until after we have chosen all our hyperparameters.Were we to use the test data in the model selection process, there is a risk that we might overfitthe test data. Then we would be in serious trouble. If we overfit our training data, there is alwaysthe evaluation on test data to keep us honest. But if we overfit the test data, how would we everknow?Thus, we should never rely on the test data for model selection. And yet we cannot rely solely onthe training data for model selection either because we cannot estimate the generalization erroron the very data that we use to train the model.In practical applications, the picture gets muddier. While ideally we would only touch the testdata once, to assess the very best model or to compare a small number of models to each other,real-world test data is seldom discarded after just one use. We can seldom afford a new test set foreach round of experiments.The common practice to address this problem is to split our data three ways, incorporating avali-dation dataset(orvalidation set) in addition to the training and test datasets. The result is a murkypractice where the boundaries between validation and test data are worryingly ambiguous. Un-less explicitly stated otherwise, in the experiments in this book we are really working with whatshould rightly be called training data and validation data, with no true test sets. Therefore, theaccuracy reported in each experiment of the book is really the validation accuracy and not a truetest set accuracy.


############################ Deep Learning - Goodfellow

<none>

############################ Neural Networks and Deep Learning - Nielsen

<none>

############################ Neural Networks and Deep Learning - Aggarwal

Because of the large gaps between training and test error, models are often tested on unseen
portions of the training data. These unseen portions of the test data are often held out early
on, and then used in order to make different types of algorithmic decisions such as parameter
tuning. This set of points is referred to as the validation set. The final accuracy is tested on a
fully out-of-sample set of points that was not used for either model building or for parameter
tuning. The error on out-of-sample test data is also referred to as the generalization error.



There are several practical issues in the training of neural network models that one must be
careful of because of the bias-variance trade-off. The first of these issues is associated with
model tuning and hyperparameter choice. For example, if one tuned the neural network with
the same data that were used to train it, one would not obtain very good results because of
overfitting. Therefore, the hyperparameters (e.g., regularization parameter) are tuned on a
separate held-out set than the one on which the weight parameters on the neural network
are learned.
Given a labeled data set, one needs to use this resource for training, tuning, and testing
the accuracy of the model. Clearly, one cannot use the entire resource of labeled data for
model building (i.e., learning the weight parameters). For example, using the same data set
for both model building and testing grossly overestimates the accuracy. This is because the
main goal of classification is to generalize a model of labeled data to unseen test instances.
Furthermore, the portion of the data set used for model selection and parameter tuning also
needs to be different from that used for model building. A common mistake is to use the
same data set for both parameter tuning and final evaluation (testing). Such an approach
partially mixes the training and test data, and the resulting accuracy is overly optimistic.
A given data set should always be divided into three parts defined according to the way in
which the data are used:
1. Training data: This part of the data is used to build the training model (i.e., during
the process of learning the weights of the neural network). Several design choices may
be available during the building of the model. The neural network might use different
hyperparameters for the learning rate or for regularization. The same training data
set may be tried multiple times over different choices for the hyperparameters or
completely different algorithms to build the models in multiple ways. This process
allows estimation of the relative accuracy of different algorithm settings. This process
sets the stage for model selection, in which the best algorithm is selected out of these
different models. However, the actual evaluation of these algorithms for selecting the
best model is not done on the training data, but on a separate validation data set to
avoid favoring overfitted models.
2. Validation data: This part of the data is used for model selection and parameter
tuning. For example, the choice of the learning rate may be tuned by constructing
the model multiple times on the first part of the data set (i.e., training data), and
then using the validation set to estimate the accuracy of these different models. As
discussed in Section 3.3.1 of Chapter 3, different combinations of parameters are sam-
pled within a range and tested for accuracy on the validation set. The best choice
of each combination of parameters is determined by using this accuracy. In a sense,
validation data should be viewed as a kind of test data set to tune the parameters of
the algorithm (e.g., learning rate, number of layers or units in each layer), or to select
the best design choice (e.g., sigmoid versus tanh activation).
3. Testing data: This part of the data is used to test the accuracy of the final (tuned)
model. It is important that the testing data are not even looked at during the process
of parameter tuning and model selection to prevent overfitting. The testing data are
used only once at the very end of the process. Furthermore, if the analyst uses the
results on the test data to adjust the model in some way, then the results will be
contaminated with knowledge from the testing data. The idea that one is allowed
to look at a test data set only once is an extraordinarily strict requirement (and an
important one). Yet, it is frequently violated in real-life benchmarks. The temptation
to use what one has learned from the final accuracy evaluation is simply too high.

The division of the labeled data set into training data, validation data, and test data is
shown in Figure 4.4. Strictly speaking, the validation data is also a part of the training
data, because it influences the final model (although only the model building portion is
often referred to as the training data). The division in the ratio of 2:1:1 is a conventional
rule of thumb that has been followed since the nineties. However, it should not be viewed as
a strict rule. For very large labeled data sets, one needs only a modest number of examples
to estimate accuracy. When a very large data set is available, it makes sense to use as much
of it for model building as possible, because the variance induced by the validation and
evaluation stage is often quite low. A constant number of examples (e.g., less than a few
thousand) in the validation and test data sets are sufficient to provide accurate estimates.
Therefore, the 2:1:1 division is a rule of thumb inherited from an era in which data sets
were small. In the modern era, where data sets are large, almost all of the points are used
for training, and a modest (constant) number are used for testing. It is not uncommon to
have divisions such as 98:1:1.


