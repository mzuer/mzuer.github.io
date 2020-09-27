## Mini-batch


##### *(source: Deep learning: a practitioner's approach - Gibson and Patterson)*

**Mini-batch training and stochastic gradient descent (SGD)**
Another variant of SGD is to use more than a single training example to compute
the gradient but less than the full training dataset. This variant is referred to as
the **mini-batch** size of training with SGD.

It has been shown to be *more
performant* than using only single training instances. Applying mini-batch to
stochastic gradient descent has also shown to lead to *smoother convergence*
because *the gradient is computed at each step it uses more training examples to
compute the gradient*. As the mini-batch size increases the gradient computed is closer to the "true"
gradient of the entire training set. This also gives us the advantage of *better
computational efficiency*. 

If our mini-batch size is too small (e.g., 1 training
record), we're not using hardware as effectively as we could, especially for
situations such as GPUs. Conversely, making the mini-batch size larger (beyond
a point) can be inefficient, as well, because we can produce the same gradient
with less computational effort (in some cases) with regular gradient descent.

**Backpropagation and mini-batch SGD**
In mini-batch SGD, we train the model on
multiple examples at once as opposed to a single example at a time. We see mini-batch used with
backpropagation and SGD in neural networks as well to improve training.
Under the hood, we're computing *the average of the gradient across all the the examples inside the
mini-batch*. Specifically, we compute the forward pass for all of the examples to get their output scores
as a batch linear algebra matrix operation. During the backward pass for each layer, we are computing
the average of the gradient (for the layer). By doing backpropagation this way, we're able to get a
*better gradient approximation* and use our hardware more efficiently at the same time.

**Mini-batching**
With mini-batching, we send more than one input vector (a group or batch of
vectors) to be trained in the learning system. This allows us to use hardware and
resources more efficiently at the computer-architecture level. This method also
allows us to compute certain linear algebra operations (specifically matrix-to-matrix multiplications) in a vectorized fashion. In this scenario we also have the
option of sending the vectorized computations to GPUs if they are present.

**Batch normalization and layers**
To accelerate training in CNNs we can *normalize the activations of the previous
layer at each batch*. This technique applies a transformation that keeps the
mean activation close to 0.0 while also keeping the activation standard deviation
close to 1.0.

Batch normalization in CNNs has shown to speed up training by making
normalization part of the network architecture. By applying normalization for
each training mini-batch of input records, we can use much *higher learning rates*.
Batch normalization also *reduces the sensitivity of training toward weight
initialization* and acts as a *regularizer* (reducing the need for other types of
regularization). Batch normalization has also been applied to LSTM networks.

**Controlling epochs and mini-batch size**
It has been shown that
dividing the training input dataset into mini-batches allows us to more efficiently
train the network. A mini-batch tends to be anywhere from 10 input vectors up to
the full input dataset.

This method also allows us to compute certain linear algebra operations
(specifically matrix–matrix multiplications) in a vectorized fashion. In this
scenario, we also have the option of sending the vectorized computations to
GPUs if they are present.

Here are a couple of key terms to understand with respect to how we control
training:
- **Epoch** = an epoch is a full pass over the entire input dataset. Many times we train on
multiple epochs of a dataset before finding training convergence.
- **Mini-batch size** = the number of records (or vectors) we pass into our
learning algorithm at the same time. This contrasts with where we'd pass in
a single input record on which to train.
The relationship between how fast our algorithm can learn the model is typically
U-shaped (batch size versus training speed). This means that initially as the
batch size becomes larger, the training time will decrease. Eventually, we'll see
the training time begin to increase when we exceed a certain batch size that is
too large.
WARNING: As mini-batch size increases, more computation means gradients might be smoother but are
more costly to compute.
Ideally, each mini-batch trained on should contain an example of each class to
reduce the sampling error when estimating the gradient for the entire training set.

**Understanding mini-batch size trade-offs**
In principle (with appropriate tuning), a neural network can learn with any mini-
batch size. In practice, we need to choose a mini-batch size that balances the
following:
- Memory requirements
- Computational efficiency
- Optimization efficiency

Regarding computational efficiency, DL4J (and other modern deep learning
libraries) parallelize learning at the level of mathematical operations such as
matrix multiplications and vector operations (additions, element-wise
multiplications, etc.). This means that too small a mini-batch size results in poor
hardware utilization (especially on GPUs), and too large a mini-batch size can be
inefficient — again, we average gradients over all examples in the mini-batch,
which means eventually the computational cost of adding more gradients
outweighs the benefit.

For performance (this is most important in the case of GPUs), *we should use a
multiple of 32 for the batch size*, or multiples of 16, 8, 4, or 2 if multiples of 32
can't be used (or result in too large a change given other requirements). In short,
the reason for this is simple: memory access and hardware design is better
optimized for operating on arrays with dimensions that are powers of two,
compared to other sizes.


We should also consider *powers of two when setting our layer sizes*. For example, we should
use a layer size of 128 over size 125, or size 256 over size 250, and so on.
With regard to optimization efficiency, it's sufficient to note that we cannot
choose the mini-batch size totally in isolation from the other hyperparameters
such as learning rate - a larger mini-batch size means smoother gradients (i.e.,
more accurate/consistent gradients), which, in conjunction with appropriate
tuning, allow for faster learning for a given number of parameter updates. The
trade-off of course is that each parameter update will take longer to compute.
Using a larger mini-batch size might help our network to learn in some difficult
cases, such as for noisy or imbalanced datasets.


So, what mini-batch size should we choose? In practice, 32 to 256 is common
for CPU training, and 32 to 1024 is common for GPU training. Usually,
something in this range is good enough for smaller networks, though you should
probably test this for larger ones (where training time can be prohibitive).
However, memory requirements can limit the maximum batch size for large
networks anyway.


For distributed training, it's not uncommon to use smaller mini-batch sizes per executor on
shared hardware (such as when training on Spark with multiple executors per machine).
Finally, don't forget that *the number of parameter updates per epoch is reduced
when we increase the mini-batch size* (where an epoch refers to one full pass of
the training data). The number of parameter updates per epoch is just the total
number of examples in our training set divided by the mini-batch size.

**The relationship between mini-batch size and epochs**
If we increase our mini-batch size by a factor of two, we need to increase the number of
epochs by a factor of two in order to maintain the same number of parameter updates.


##### *(source: Pattern recognition - Bishop)*

(NB not to confound with **batch methods**)

Techniques that use the *whole data set at once* are called **batch methods**. At each step the weight
vector is moved in the direction of the greatest rate of decrease of the error function,
and so this approach is known as gradient descent or steepest descent.

**On-line** gradient descent, also known as **sequential** gradient descent or **stochastic**
gradient descent, makes an update to the weight vector based on *one data point at a
time*.

One advantage of on-line methods compared to batch methods is that the former
*handle redundancy in the data much more efficiently*. To see, this consider an ex-
treme example in which we take a data set and double its size by duplicating every
data point. Note that this simply multiplies the error function by a factor of 2 and so
is equivalent to using the original error function. Batch methods will require double
the computational effort to evaluate the batch error function gradient, whereas on-
line methods will be unaffected. Another property of on-line gradient descent is the
*possibility of escaping from local minima*, since a stationary point with respect to
the error function for the whole data set will generally not be a stationary point for
each data point individually.

If the data set is *sufficiently large*,
it may be worthwhile to use sequential algorithms, also known as on-line algorithms,
in which the data points are considered one at a time, and the model parameters updated after each such presentation. Sequential learning is also appropriate for real-
time applications in which the data observations are arriving in a *continuous stream*,
and predictions must be made before all of the data points are seen.
We can obtain a sequential learning algorithm by applying the technique of
stochastic gradient descent, also known as sequential gradient descent.


##### *(source: Dive into deep learning - Zhang et al.)*


**Minibatch stochastic gradient descent**

Even in cases where we cannot solve the models analytically, it turns out that we can still train models effectively in practice. Moreover, for many tasks, those difficult-to-optimize models turnout to be so much better that figuring out how to train them ends up being well worth the trouble.The key technique for optimizing nearly any deep learning model consists of *iteratively reducing the error by updating the parameters in the direction that incrementally lowers the loss function*. This algorithm is called **gradient descent**.The most naive application of gradient descent consists of taking the derivative of the loss funcion, which is an average of the losses computed on every single example in the dataset. In practice, this can be extremely slow: we must pass over the entire dataset before making a single update. Thus, we will often settle for *sampling a random minibatch of examples every time we need to compute the update*, a variant called **minibatch stochastic gradient descent**.In each iteration:
- first randomly sample a minibatch *B* consisting of a fixed number of training examples;
- then compute the derivative (gradient) of the average loss on the minibatch with regard to the model parameters;
- finally, multiply the gradient by a predetermined positivevalue and subtract the resulting term from the current parameter values.

The values of the batch size and learning rate are manually pre-specified and not typically learned through model training. These parameters that are tunable but not updated in the training loop are called **hyperparameters**. *Hyperparameter tuning* is the process by which hyperparameters are chosen, and typically requires that we adjust them based on the results of the training loop as assessed on a separate **validation** dataset (or validation set). After training for some predetermined number of iterations (or until some other stopping criteria are met), we record the estimated model parameters. Note that even if our function is truly linear and noiseless, these parameters will not be the exact minimizers of the loss because, although the algorithm converges slowly towards the minimizers it cannot achieve it exactly in a finite number of steps. Linear regression happens to be a learning problem where there is only one minimum over the entire domain. However, for more complicated models, like deep networks, the loss surfaces contain many minima. Fortunately, for reasons that are not yet fully understood, deep learning practitioners seldom struggle to find parameters that minimize the losson training sets. The more formidable task is to *find parameters that will achieve low loss on data that we have not seen before*, a challenge called **generalization**. 

##### *(source: Neural networks and deep learning - Nielsen)*

**Stochastic gradient descent** works by randomly picking
out a small number m of randomly chosen training inputs. We'll refer to those random training
inputs as a **mini-batch**.
The stochastic gradient descent works by picking
out a randomly chosen mini-batch of training inputs, and training with those.
Then we
pick out another randomly chosen mini-batch and train with those. And so on, until we've
exhausted the training inputs, which is said to complete an *epoch* of training. At that point
we start over with a new training epoch.


Incidentally, it's worth noting that conventions vary about scaling of the cost function and
of mini-batch updates to the weights and biases. Summing over the costs of individual
training examples instead of averaging is particularly useful when the total number
of training examples isn't known in advance. This can occur if more training data is being
generated in real time, for instance. 

We can think of stochastic gradient descent as being like political polling: it's much easier
to sample a small mini-batch than it is to apply gradient descent to the full batch, just as
carrying out a poll is easier than running a full election. For example, if we have a training
set of size n=60,000, as in MNIST, and choose a mini-batch size of (say) m = 10, this means
we'll get a factor of 6,000 speedup in estimating the gradient! Of course, the estimate won't
be perfect – there will be statistical fluctuations – but it doesn't need to be perfect: all we
really care about is moving in a general direction that will help decrease C, and that means
we don't need an exact computation of the gradient. In practice, stochastic gradient descent
is a commonly used and powerful technique for learning in neural networks.

An extreme version of gradient descent is to use a *mini-batch size of just 1*. This
procedure is known as **online, on-line, or incremental learning**. In online learning, a
neural network learns from just one training input at a time (just as human beings
do). 


##### *(source: Neural networks and deep learning - Aggarwal)*


**Mini-batch stochastic gradient descent**

When all updates to the weights are performed in point-
specific fashion, this is referred to as **stochastic gradient descent**. Such an approach is
common in machine learning algorithms. 

Most machine learning problems can be recast as optimization problems over specific
objective functions. For example, the objective function in neural networks can be defined
in terms optimizing a loss function L, which is often a linearly separable sum of the loss
functions on the individual training data points. For example, in a linear regression application, one minimizes the sum of the squared prediction errors over the training data points.
In a dimensionality reduction application, one minimizes the sum of squared representation
errors in the reconstructed training data points. 

In gradient descent, one tries to minimize the loss function of the neural network by
moving the parameters along the negative direction of the gradient. Therefore, one would
try to compute the loss of the underlying objective function over all points simultaneously
and perform gradient descent. 


The number of parameters to be updated by backpropagation can easily be on the order of millions
in large-scale applications, and one needs to simultaneously run all examples forwards and
backwards through the network in order to compute the backpropagation updates. It is,
however, impractical to simultaneously run all examples through the network to compute
the gradient with respect to the entire data set in one shot. Note that even the memory
requirements of all intermediate/final predictions for each training instance would need to
be maintained by gradient descent. This can be exceedingly large in most practical settings.
At the beginning of the learning process, the weights are often incorrect to such a degree that
even a small sample of points can be used to create an excellent estimate of the gradient's
direction. The additive effect of the updates created from such samples can often provide
an accurate direction of movement. This observation provides a practical foundation for the
success of the stochastic gradient-descent method and its variants.


The loss function of most optimization problems can be expressed as a linear sum
of the losses with respect to individual points.
In this case, *updating the full gradient with respect to all the points sums up the individual
point-specific effects*. Machine learning problems inherently have a high level of redundancy
between the knowledge captured by different training points, and one can often more efficiently undertake the learning process with the *point-specific updates of stochastic gradient*.
This type of gradient descent is referred to as **stochastic** because one cycles through the
points in some random order. Note that the long-term effect of repeated updates is ap-
proximately the same, although each update in stochastic gradient descent can only be
viewed as a probabilistic approximation. Each local gradient can be computed efficiently,
which makes stochastic gradient descent fast, albeit at the expense of accuracy in gradient
computation. However, one interesting property of stochastic gradient descent is that even
though it might not perform as well on the training data (compared to gradient descent),
it often performs comparably (and sometimes even better) on the test data. Stochastic gradient descent has the indirect effect of regularization.
However, it can occasionally provide very poor results with certain orderings of training
points.


In **mini-batch stochastic descent**, one uses a batch *B* of training points for
the update. Mini-batch stochastic gradient descent often provides the *best trade-off between stability,
speed, and memory requirements*. When using mini-batch stochastic gradient descent, the
outputs of a layer are matrices instead of vectors, and forward propagation requires the multiplication of the weight matrix with the activation matrix. The same is true for backward
propagation in which matrices of gradients are maintained. Therefore, *the implementation
of mini-batch stochastic gradient descent increases the memory requirements, which is a
key limiting factor on the size of the mini-batch*.
The size of the mini-batch is therefore regulated by the amount of memory available on
the particular hardware architecture at hand. Keeping a batch size that is too small also
results in constant overheads, which is inefficient even from a computational point of view.
Beyond a certain batch size (which is typically of the order of a few hundred points), one
does not gain much in terms of the accuracy of gradient computation. It is common to
use *powers of 2 as the size of the mini-batch*, because this choice often provides the best
efficiency on most hardware architectures; commonly used values are 32, 64, 128, or 256.
Although the use of mini-batch stochastic gradient descent is ubiquitous in neural network
learning, most of this book will use a single point for the update (i.e., pure stochastic
gradient descent) for simplicity in presentation.


