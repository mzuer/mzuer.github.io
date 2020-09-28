
## Cross-validation

<style>body {text-align: justify}</style>

##### *(source: Deep learning: a practitioner's approach - Gibson and Patterson)*

**Cross-validation** (also called **rotation estimation**) is a *method to estimate how well a model generalizes on a training dataset*. 

- Split the training dataset into *N* number of *splits* and then separate the splits into *training* and *test* groups. 
- Train on the training group of splits and then test the model on the test group of splits. 
- Rotate the splits between the two groups many times until all the variations are exhausted. 

There is no hard number for the number of splits to use but researchers have found 10 splits to work well in practice. It also is common to see a separate portion of the held-out data used asa validation dataset during training

##### *(source: Pattern recognition and machine learning - Bishop)*

In many applications the supply of data for training and testing will be
limited, and in order to build good models, we wish to use as much of the available
data as possible for training. However, if the validation set is small, it will give a
relatively noisy estimate of predictive performance. 

One solution to this dilemma is
to use **cross-validation**, which allows a proportion
*(S − 1)/S* of the available data to be used for training while making use of all of the
data to assess performance. 

When data is particularly scarce, it may be appropriate
to consider the case *S = N* , where *N* is the total number of data points, which gives
the **leave-one-out** technique.


One major drawback of cross-validation is that the number of training runs that
must be performed is increased by a factor of *S*, and this can prove problematic for
models in which the training is itself *computationally expensive*. 

A further problem
with techniques such as cross-validation that use separate data to assess performance
is that we might have multiple complexity parameters for a single model (for instance, there might be several regularization parameters). Exploring combinations
of settings for such parameters could, in the worst case, require *a number of training
runs that is exponential in the number of parameters*. Clearly, we need a better approach. Ideally, this should rely only on the training data and should allow multiple
hyperparameters and model types to be compared in a single training run. We therefore need to find a measure of performance which depends only on the training data
and which does not suffer from bias due to over-fitting.

The technique of S-fold cross-validation:
- take the available data and partition it into *S* groups (in the simplest case these are of equal
size);
- then *S − 1* of the groups are used to train a set of models that are then evaluated on the remaining group;
- then repeat the procedure for all *S* possible choices for the held-out group;
- average the performance scores from the *S* runs.

##### *(source: The elements of statistical learning - Hastie et al.)*

**Cross-validation**
Probably the simplest and most widely used method for estimating prediction error.
This method directly estimates the expected
extra-sample error.


**K-fold cross-validation**
Ideally, if we had enough data, we would set aside a validation set and use
it to assess the performance of our prediction model. Since data are often
scarce, this is usually not possible. 

To finesse the problem, **K-fold cross-
validation** uses part of the available data to fit the model, and a different
part to test it. 
- split the data into *K* roughly equal-sized parts;
- for the *k*-th part, fit the model to the other *K − 1* parts
of the data, and calculate the prediction error of the fitted model when
predicting the *k*-th part of the data; 
- do this for *k = 1, 2, . . . , K* and
combine the *K* estimates of prediction error.

Typical choices of *K* are 5 or 10. The case *K = N* is known
as **leave-one-out cross-validation**. In this case for the *i*-th
observation the fit is computed using all the data except the *i*-th.


If the learning curve has a considerable slope at the given
training set size, five- or tenfold cross-validation will overestimate the true
prediction error. Whether this bias is a drawback in practice depends on
the objective. On the other hand, leave-one-out cross-validation has low
bias but can have high variance. Overall, five- or tenfold cross-validation
are recommended as a good compromise.

Generalized cross-validation provides a convenient approximation to leave-
one out cross-validation, for linear fitting under squared-error loss.

**The wrong and right way to do cross-validation**

Consider a classification problem with a large number of predictors. A typical strategy
for analysis might be as follows:
1. Screen the predictors: find a subset of "good" predictors that show
fairly strong (univariate) correlation with the class labels
2. Using just this subset of predictors, build a multivariate classifier.
3. Use cross-validation to estimate the unknown tuning parameters and
to estimate the prediction error of the final model.

Is this a correct application of cross-validation? Consider a scenario with
N = 50 samples in two equal-sized classes, and p = 5000 quantitative
predictors (standard Gaussian) that are independent of the class labels.
The true (test) error rate of any classifier is 50%. We carried out the above
recipe, choosing in step (1) the 100 predictors having highest correlation
with the class labels, and then using a 1-nearest neighbor classifier, based
on just these 100 predictors, in step (2). Over 50 simulations from this
setting, the average CV error rate was 3%. This is far lower than the true
error rate of 50%.

What has happened? The problem is that the predictors have an unfair
advantage, as they were chosen in step (1) on the basis of *all* of the samples.
Leaving samples out after the variables have been selected does not correctly mimic the application of the classifier to a completely independent
test set, since *these predictors “have already seen” the left out samples*.

Here is the correct way to carry out cross-validation in this example:
1. Divide the samples into *K* cross-validation folds (groups) at random.
2. For each fold *k = 1, 2, . . . , K*
(a) Find a subset of "good" predictors that show fairly strong (univariate) correlation with the class labels, using all of the samples
*except* those in fold *k*.
(b) Using just this subset of predictors, build a multivariate classifier, using all of the samples *except* those in fold *k*.
(c) Use the classifier to predict the class labels for the samples in fold *k*.

The error estimates from step 2(c) are then accumulated over all *K* folds, to
produce the cross-validation estimate of prediction error. 

In general, with a multistep modeling procedure, *cross-validation must
be applied to the entire sequence of modeling steps*. In particular, samples
must be *"left out" before any selection or filtering steps are applied*. 

**Bootstrap Methods**
The bootstrap is a general tool for *assessing statistical accuracy*. 
It can be used to
estimate extra-sample prediction error. As with cross-validation, the bootstrap seeks to estimate the conditional error, but typically estimates
well only the expected prediction error.

Suppose we have a model fit to a set of training data. The basic idea is:
- randomly draw datasets with replacement from the training data, each
sample the same size as the original training set. This is done *B* times, producing *B* bootstrap datasets.
- then refit the model to each of the bootstrap datasets, and examine
the behavior of the fits over the *B* replications.

By mimicking cross-validation, a better bootstrap estimate can be obtained. For each observation, we only keep track of predictions from bootstrap samples not containing that observation (**leave-one-out bootstrap**).

##### *(source: Dive into deep learning - Zhang et al.)*

**K-Fold Cross-Validation**

When training data is scarce, we might not even be able to afford to hold out enough data to constitute a proper validation set. One popular solution to this problem is to employ **K-fold cross-validation**: 
- the original training data is split into *K* non-overlapping subsets;
- then model training and validation are executed *K* times, each time training on *K*.

##### *(source: Deep learning - Goodfellow)*
Cross-Validation
Dividing the dataset into a fixed training set and a fixed test set can be problematic if it results in the test set being small. A *small test set implies statistical uncertainty around the estimated average test error*,making it difficult to claim that algorithm A works better than algorithm B on the given task. 

When the dataset has hundreds of thousands ofexamples or more,this is nota serious issue. When the dataset is too small, alternative procedures enable one to use all of the examples in the estimation of the mean test error, at the price of increased computational cost.These procedures are based on the idea of *repeating the training and testing computation on different randomly chosen subsets or splits of the original dataset*. The most common of these is the **k-fold cross-validation** procedure,in which *a partition of the dataset is formed by splitting it into k non-overlapping subsets*.The test error may then be estimated by *taking the average test error across* k *trials*. On trial *i*, the *i*-th subset of the data is used as the test set and the rest of the data is used as the training set. 

One problem is that there exist noun *biased estimators of the variance* of such average error estimators, but approximations are typically used.

##### *(source: Neural Networks and Deep Learning - Aggarwal)*

**Evaluating with hold-out and cross-validation**

Segmenting the labeled data into various portions: 
- training data is first divided into two parts for training and testing;
- the testing part is then
carefully hidden away from any further analysis until the very end where it can be used only
once;
- the remainder of the data set is then divided again into the training and validation
portions. 

A key point is that *the types of division at both levels of the hierarchy are conceptually
identical* (first-level: division into "training" and "testing" data; second-level: division into model building and validation portions)

**Hold-Out**
- A fraction of the instances are used to build the training model.
- The remaining instances, which are also referred to as the *held-out instances*, are used for
testing. 
- The accuracy of predicting the labels of the held-out instances is then reported as
the overall accuracy. 

Such an approach ensures that the reported accuracy is not a result
of overfitting to the specific data set, because different instances are used for training and
testing. The approach, however, *underestimates the true accuracy*. Consider the case where
the held-out examples have a higher presence of a particular class than the labeled data
set. This means that the held-in examples have a lower average presence of the same class,
which will cause a mismatch between the training and test data. Furthermore, the class-wise
frequency of the held-in examples will always be inversely related to that of the held-out
examples. This will lead to a consistent pessimistic bias in the evaluation. 

In spite of these
weaknesses, the hold-out method has the advantage of being simple and efficient, which
makes it a popular choice in large-scale settings. 

**Cross-Validation**
- The labeled data is divided into *q* equal segments. 
- One of
the *q* segments is used for testing, and the remaining *(q − 1)* segments are used for training.
- This process is repeated *q* times by using each of the *q* segments as the test set. 
- The average
accuracy over the *q* different test sets is reported. 

Note that this approach can closely
estimate the true accuracy when the value of *q* is large. 

A special case is one where *q* is
chosen to be equal to the number of labeled data points and therefore a *single point is used
for testing*. Since this single point is left out from the training data, this approach is referred
to as **leave-one-out cross-validation**. Although such an approach can closely approximate
the accuracy, it is usually too expensive to train the model a large number of times. In fact,
cross-validation is sparingly used in neural networks because of efficiency issues.


