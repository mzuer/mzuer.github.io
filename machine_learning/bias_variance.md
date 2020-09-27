## The bias-variance trade-off

##### *(source: Neural Networks and Deep Learning - Aggarwal)*

The fact that more powerful models do not always win in terms of prediction accuracy with a finite
data set is the key take-away from the **bias-variance trade-off**.

The bias-variance trade-off states that the squared error of a learning algorithm can be partitioned into three components:

1. **Bias** = caused by the simplifying assumptions in the model, which
causes certain test instances to have *consistent errors* across different choices of training data sets. Even if the model has access to an infinite source of training data, the
bias cannot be removed. 

2. **Variance** = caused by the *inability to learn all the parameters* of the model
in a statistically robust way, especially when the data is limited and the model tends
to have a larger number of parameters. The presence of higher variance is manifested
by *overfitting* to the specific training data set at hand. Therefore, if different choices
of training data sets are used, different predictions will be provided for the same
test instance. 

3. **Noise** = caused by the *inherent error* in the data. 

