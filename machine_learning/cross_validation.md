
############################ CROSS VALIDATION - DEEP LEARNING - Patterson Gibson


Cross-validation (also called rotation estimation) is a method to estimate howwell a model generalizes on a training dataset. In cross-validation we split thetraining dataset into N number of splits and then separate the splits into trainingand test groups. We train on the training group of splits and then test the modelon the test group of splits. We rotate the splits between the two groups manytimes until we’ve exhausted all the variations. There is no hard number for thenumber of splits to use but researchers have found 10 splits to work well inpractice. It also is common to see a separate portion of the held-out data used asa validation dataset during training


############################ Pattern recognition bishop


In many applications, however, the supply of data for training and testing will be
limited, and in order to build good models, we wish to use as much of the available
data as possible for training. However, if the validation set is small, it will give a
relatively noisy estimate of predictive performance. One solution to this dilemma is
to use cross-validation, which is illustrated in Figure 1.18. This allows a proportion
(S − 1)/S of the available data to be used for training while making use of all of the
data to assess performance. When data is particularly scarce, it may be appropriate
to consider the case S = N , where N is the total number of data points, which gives
the leave-one-out technique.
One major drawback of cross-validation is that the number of training runs that
must be performed is increased by a factor of S, and this can prove problematic for
models in which the training is itself computationally expensive. A further problem
with techniques such as cross-validation that use separate data to assess performance
is that we might have multiple complexity parameters for a single model (for in-
stance, there might be several regularization parameters). Exploring combinations
of settings for such parameters could, in the worst case, require a number of training
runs that is exponential in the number of parameters. Clearly, we need a better ap-
proach. Ideally, this should rely only on the training data and should allow multiple
hyperparameters and model types to be compared in a single training run. We there-
fore need to find a measure of performance which depends only on the training data
and which does not suffer from bias due to over-fitting.

The technique of S-fold cross-validation, illus-
trated here for the case of S = 4, involves tak-
ing the available data and partitioning it into S
groups (in the simplest case these are of equal
size). Then S − 1 of the groups are used to train
a set of models that are then evaluated on the re-
maining group. This procedure is then repeated
for all S possible choices for the held-out group,
indicated here by the red blocks, and the perfor-
mance scores from the S runs are then averaged.

############################ The Elements of Statistical Learning - Hastie et al.

7.10 Cross-Validation
Probably the simplest and most widely used method for estimating predic-
tion error is cross-validation. This method directly estimates the expected
extra-sample error Err = E[L(Y, f ˆ (X))], the average generalization error
when the method f ˆ (X) is applied to an independent test sample from the
joint distribution of X and Y . As mentioned earlier, we might hope that
cross-validation estimates the conditional error, with the training set T
held fixed. But as we will see in Section 7.12, cross-validation typically
estimates well only the expected prediction error.

7.10.1 K-Fold Cross-Validation
Ideally, if we had enough data, we would set aside a validation set and use
it to assess the performance of our prediction model. Since data are often
scarce, this is usually not possible. To finesse the problem, K-fold cross-
validation uses part of the available data to fit the model, and a different
part to test it. We split the data into K roughly equal-sized parts; for
example, when K = 5, the scenario looks like this:

For the kth part (third above), we fit the model to the other K − 1 parts
of the data, and calculate the prediction error of the fitted model when
predicting the kth part of the data. We do this for k = 1, 2, . . . , K and
combine the K estimates of prediction error.

Typical choices of K are 5 or 10 (see below). The case K = N is known
as leave-one-out cross-validation. In this case κ(i) = i, and for the ith
observation the fit is computed using all the data except the ith.



On the other hand, with K = 5 say, cross-validation has lower variance.
But bias could be a problem, depending on how the performance of the
learning method varies with the size of the training set. Figure 7.8 shows
a hypothetical “learning curve” for a classifier on a given task, a plot of
1 − Err versus the size of the training set N . The performance of the
classifier improves as the training set size increases to 100 observations;
increasing the number further to 200 brings only a small benefit. If our
training set had 200 observations, fivefold cross-validation would estimate
the performance of our classifier over training sets of size 160, which from
Figure 7.8 is virtually the same as the performance for training set size
200. Thus cross-validation would not suffer from much bias. However if the
training set had 50 observations, fivefold cross-validation would estimate
the performance of our classifier over training sets of size 40, and from the
figure that would be an underestimate of 1 − Err. Hence as an estimate of
Err, cross-validation would be biased upward.
To summarize, if the learning curve has a considerable slope at the given
training set size, five- or tenfold cross-validation will overestimate the true
prediction error. Whether this bias is a drawback in practice depends on
the objective. On the other hand, leave-one-out cross-validation has low
bias but can have high variance. Overall, five- or tenfold cross-validation
are recommended as a good compromise: see Breiman and Spector (1992)
and Kohavi (1995).

Generalized cross-validation provides a convenient approximation to leave-
one out cross-validation, for linear fitting under squared-error loss.

7.10.2 The Wrong and Right Way to Do Cross-validation
Consider a classification problem with a large number of predictors, as may
arise, for example, in genomic or proteomic applications. A typical strategy
for analysis might be as follows:
1. Screen the predictors: find a subset of “good” predictors that show
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
advantage, as they were chosen in step (1) on the basis of all of the samples.
Leaving samples out after the variables have been selected does not cor-
rectly mimic the application of the classifier to a completely independent
test set, since these predictors “have already seen” the left out samples.
Figure 7.10 (top panel) illustrates the problem. We selected the 100 pre-
dictors having largest correlation with the class labels over all 50 samples.
Then we chose a random set of 10 samples, as we would do in five-fold cross-
validation, and computed the correlations of the pre-selected 100 predictors
with the class labels over just these 10 samples (top panel). We see that
the correlations average about 0.28, rather than 0, as one might expect.
Here is the correct way to carry out cross-validation in this example:
1. Divide the samples into K cross-validation folds (groups) at random.
2. For each fold k = 1, 2, . . . , K
(a) Find a subset of “good” predictors that show fairly strong (uni-
variate) correlation with the class labels, using all of the samples
except those in fold k.
(b) Using just this subset of predictors, build a multivariate classi-
fier, using all of the samples except those in fold k.
(c) Use the classifier to predict the class labels for the samples in
fold k.
The error estimates from step 2(c) are then accumulated over all K folds, to
produce the cross-validation estimate of prediction error. The lower panel
of Figure 7.10 shows the correlations of class labels with the 100 predictors
chosen in step 2(a) of the correct procedure, over the samples in a typical
fold k. We see that they average about zero, as they should.
In general, with a multistep modeling procedure, cross-validation must
be applied to the entire sequence of modeling steps. In particular, samples
must be “left out” before any selection or filtering steps are applied. There
is one qualification: initial unsupervised screening steps can be done be-
fore samples are left out. For example, we could select the 1000 predictors


NB: cv and bootstraps

7.11 Bootstrap Methods
The bootstrap is a general tool for assessing statistical accuracy. First we
describe the bootstrap in general, and then show how it can be used to
estimate extra-sample prediction error. As with cross-validation, the boot-
strap seeks to estimate the conditional error Err T , but typically estimates
well only the expected prediction error Err.
Suppose we have a model fit to a set of training data. We denote the
training set by Z = (z 1 , z 2 , . . . , z N ) where z i = (x i , y i ). The basic idea is
to randomly draw datasets with replacement from the training data, each
sample the same size as the original training set. This is done B times
(B = 100 say), producing B bootstrap datasets, as shown in Figure 7.12.
Then we refit the model to each of the bootstrap datasets, and examine
the behavior of the fits over the B replications.
In the figure, S(Z) is any quantity computed from the data Z, for ex-
ample, the prediction at some input point. From the bootstrap sampling
we can estimate any aspect of the distribution of S(Z), for example, its
variance,

By mimicking cross-validation, a better bootstrap estimate can be ob-
tained. For each observation, we only keep track of predictions from boot-
strap samples not containing that observation. The leave-one-out bootstrap

############################ Dive into Deep Learning - Zhang

K-Fold Cross-ValidationWhen training data is scarce, we might not even be able to afford to hold out enough data to con-stitute a proper validation set. One popular solution to this problem is to employK-fold cross-validation. Here, the original training data is split intoKnon-overlapping subsets. Then modeltraining and validation are executedKtimes, each time training onK

############################ Deep Learning - Goodfellow
Cross-ValidationDividingthedatasetintoafixedtrainingsetandafixedtestsetcanbeproblematicifitresultsinthetestsetbeingsmall.Asmalltestsetimpliesstatisticaluncertaintyaroundtheestimatedaveragetesterror,makingitdifficulttoclaimthatalgorithmAworksbetterthanalgorithmonthegiventask.BWhenthedatasethashundredsofthousandsofexamplesormore,thisisnotaseriousissue.Whenthedatasetistoosmall,arealternativeproceduresenableonetousealloftheexamplesintheestimationofthemeantesterror,atthepriceofincreasedcomputationalcost.Theseproceduresarebasedontheideaofrepeatingthetrainingandtestingcomputationondifferentrandomlychosensubsetsorsplitsoftheoriginaldataset.Themostcommonoftheseisthek-foldcross-validationprocedure,showninalgorithm,inwhichapartitionofthedatasetisformedby5.1splittingitintoknon-overlappingsubsets.Thetesterrormaythenbeestimatedbytakingtheaveragetesterroracrossktrials.Ontriali,thei-thsubsetofthedataisusedasthetestsetandtherestofthedataisusedasthetrainingset.Oneproblemisthatthereexistnounbiasedestimatorsofthevarianceofsuchaverageerrorestimators(BengioandGrandvalet2004,),butapproximationsaretypicallyused.



############################ Neural Networks and Deep Learning - Nielsen
<none>

############################ Neural Networks and Deep Learning - Aggarwal

Evaluating with Hold-Out and Cross-Validation
The aforementioned description of partitioning the labeled data into three segments is an
implicit description of a method referred to as hold-out for segmenting the labeled data into
various portions. However, the division into three parts is not done in one shot. Rather, the
training data is first divided into two parts for training and testing. The testing part is then
carefully hidden away from any further analysis until the very end where it can be used only
once. The remainder of the data set is then divided again into the training and validation
portions. This type of recursive division is shown in Figure 4.5.
A key point is that the types of division at both levels of the hierarchy are conceptually
identical. In the following, we will consistently use the terminology of the first level of
division in Figure 4.5 into “training” and “testing” data, even though the same approach

can also be used for the second-level division into model building and validation portions.
This allows us to provide a common description of evaluation processes at both levels of the
division.
Hold-Out
In the hold-out method, a fraction of the instances are used to build the training model.
The remaining instances, which are also referred to as the held-out instances, are used for
testing. The accuracy of predicting the labels of the held-out instances is then reported as
the overall accuracy. Such an approach ensures that the reported accuracy is not a result
of overfitting to the specific data set, because different instances are used for training and
testing. The approach, however, underestimates the true accuracy. Consider the case where
the held-out examples have a higher presence of a particular class than the labeled data
set. This means that the held-in examples have a lower average presence of the same class,
which will cause a mismatch between the training and test data. Furthermore, the class-wise
frequency of the held-in examples will always be inversely related to that of the held-out
examples. This will lead to a consistent pessimistic bias in the evaluation. In spite of these
weaknesses, the hold-out method has the advantage of being simple and efficient, which
makes it a popular choice in large-scale settings. From a deep-learning perspective, this is
an important observation because large data sets are common.
Cross-Validation
In the cross-validation method, the labeled data is divided into q equal segments. One of
the q segments is used for testing, and the remaining (q − 1) segments are used for training.
This process is repeated q times by using each of the q segments as the test set. The average
accuracy over the q different test sets is reported. Note that this approach can closely
estimate the true accuracy when the value of q is large. A special case is one where q is
chosen to be equal to the number of labeled data points and therefore a single point is used
for testing. Since this single point is left out from the training data, this approach is referred
to as leave-one-out cross-validation. Although such an approach can closely approximate
the accuracy, it is usually too expensive to train the model a large number of times. In fact,
cross-validation is sparingly used in neural networks because of efficiency issues.




