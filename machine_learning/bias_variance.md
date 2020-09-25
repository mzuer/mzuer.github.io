############################ Neural Networks and Deep Learning - Aggarwal

The Bias-Variance Trade-Off
The introduction section provides an example of how a polynomial model fits a smaller
training data set, leading to the predictions on unseen test data being more erroneous than
are the predictions of a (simpler) linear model. This is because a polynomial model requires
more data in order to not be misled by random artifacts of the training data set. The fact
that more powerful models do not always win in terms of prediction accuracy with a finite
data set is the key take-away from the bias-variance trade-off.
The bias-variance trade-off states that the squared error of a learning algorithm can be
partitioned into three components:
1. Bias: The bias is the error caused by the simplifying assumptions in the model, which
causes certain test instances to have consistent errors across different choices of train-
ing data sets. Even if the model has access to an infinite source of training data, the
bias cannot be removed. For example, in the case of Figure 4.2, the linear model has
a higher model bias than the polynomial model, because it can never fit the (slightly
curved) data distribution exactly, no matter how much data is available. The predic-
tion of a particular out-of-sample test instance at x = 2 will always have an error in a
particular direction when using a linear model for any choice of training sample. If we
assume that the linear and curved lines in the top left of Figure 4.2 were estimated
using an infinite amount of data, then the difference between the two at any particular
values of x is the bias. An example of the bias at x = 2 is shown in Figure 4.2.
2. Variance: Variance is caused by the inability to learn all the parameters of the model
in a statistically robust way, especially when the data is limited and the model tends
to have a larger number of parameters. The presence of higher variance is manifested
by overfitting to the specific training data set at hand. Therefore, if different choices
of training data sets are used, different predictions will be provided for the same
test instance. Note that the linear prediction provides similar predictions at x = 2 in
Figure 4.2, whereas the predictions of the polynomial model vary widely over different
choices of training instances. In many cases, the widely inconsistent predictions at
x = 2 are wildly incorrect predictions, which is a manifestation of model variance.
Therefore, the polynomial predictor has a higher variance than the linear predictor in
Figure 4.2.
3. Noise: The noise is caused by the inherent error in the data. For example, all data
points in the scatter plot vary from the true model in the upper-left corner of Fig-
ure 4.2. If there had been no noise, all points in the scatter plot would overlap with
the curved line representing the true model.
