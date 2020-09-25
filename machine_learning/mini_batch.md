############################ MINI-BATCH ************************************* DEEP LEARNING - Patterson Gibson

Mini-batch training and SGD 
Another variant of SGD is to use more than a single training example to compute
the gradient but less than the full training dataset. This variant is referred to as
the mini-batch size of training with SGD and has been shown to be more
performant than using only single training instances. Applying mini-batch to
stochastic gradient descent has also shown to lead to smoother convergence
because the gradient is computed at each step it uses more training examples to
compute the gradient.
As the mini-batch size increases the gradient computed is closer to the “true”
gradient of the entire training set. This also gives us the advantage of better
computational efficiency. If our mini-batch size is too small (e.g., 1 training
record), we’re not using hardware as effectively as we could, especially for
situations such as GPUs. Conversely, making the mini-batch size larger (beyond
a point) can be inefficient, as well, because we can produce the same gradient
with less computational effort (in some cases) with regular gradient descent.


BACKPROPAGATION AND MINI-BATCH STOCHASTIC GRADIENT DESCENT
In Chapter 1, we learned about a variant of SGD called mini-batch, in which we train the model on
multiple examples at once as opposed to a single example at a time. We see mini-batch used with
backpropagation and SGD in neural networks as well to improve training.
Under the hood, we’re computing the average of the gradient across all the the examples inside the
mini-batch. Specifically, we compute the forward pass for all of the examples to get their output scores
as a batch linear algebra matrix operation. During the backward pass for each layer, we are computing
the average of the gradient (for the layer). By doing backpropagation this way, we’re able to get a
better gradient approximation and use our hardware more efficiently at the same time.

Mini-batching
With mini-batching, 16 we send more than one input vector (a group or batch of
vectors) to be trained in the learning system. This allows us to use hardware and
resources more efficiently at the computer-architecture level. This method also
allows us to compute certain linear algebra operations (specifically matrix-to-
201matrix multiplications) in a vectorized fashion. In this scenario we also have the
option of sending the vectorized computations to GPUs if they are present.

Batch normalization and layers
To accelerate training in CNNs we can normalize the activations of the previous
layer at each batch. 12 This technique applies a transformation that keeps the
mean activation close to 0.0 while also keeping the activation standard deviation
close to 1.0.
Batch normalization in CNNs has shown to speed up training by making
normalization part of the network architecture. By applying normalization for
each training mini-batch of input records, we can use much higher learning rates.
Batch normalization also reduces the sensitivity of training toward weight
initialization and acts as a regularizer (reducing the need for other types of
regularization). Batch normalization has also been applied to LSTM networks, 13
264which is another type of deep network we’ll discuss later in the chapter.


Controlling Epochs and Mini-Batch Size
In Chapter 2, we introduced the concept of the mini-batch. It’s been shown that
dividing the training input dataset into mini-batches allows us to more efficiently
train the network. A mini-batch tends to be anywhere from 10 input vectors up to
the full input dataset.
This method also allows us to compute certain linear algebra operations
(specifically matrix–matrix multiplications) in a vectorized fashion. In this
scenario, we also have the option of sending the vectorized computations to
GPUs if they are present.
Here are a couple of key terms to understand with respect to how we control
training:
Epoch
An epoch is a full pass over the entire input dataset. Many times we train on
multiple epochs of a dataset before finding training convergence.
Mini-batch size
Mini-batch size is the number of records (or vectors) we pass into our
learning algorithm at the same time. This contrasts with where we’d pass in
a single input record on which to train.
The relationship between how fast our algorithm can learn the model is typically
U-shaped (batch size versus training speed). This means that initially as the
batch size becomes larger, the training time will decrease. Eventually, we’ll see
the training time begin to increase when we exceed a certain batch size that is
too large.
WARNING
As mini-batch size increases, more computation means gradients might be smoother but are
more costly to compute.
Ideally, each mini-batch trained on should contain an example of each class to
reduce the sampling error when estimating the gradient for the entire training set.


Understanding Mini-Batch Size Trade-Offs
In principle (with appropriate tuning), a neural network can learn with any mini-
batch size. In practice, we need to choose a mini-batch size that balances the
following:
Memory requirements
Computational efficiency
Optimization efficiency
Memory requirements have been covered in an earlier section, so we won’t talk
about them here.
Regarding computational efficiency, DL4J (and other modern deep learning
libraries) parallelize learning at the level of mathematical operations such as
matrix multiplications and vector operations (additions, element-wise
multiplications, etc.). This means that too small a mini-batch size results in poor
hardware utilization (especially on GPUs), and too large a mini-batch size can be
inefficient — again, we average gradients over all examples in the mini-batch,
which means eventually the computational cost of adding more gradients
outweighs the benefit.
For performance (this is most important in the case of GPUs), we should use a
multiple of 32 for the batch size, or multiples of 16, 8, 4, or 2 if multiples of 32
can’t be used (or result in too large a change given other requirements). In short,
the reason for this is simple: memory access and hardware design is better
optimized for operating on arrays with dimensions that are powers of two,
compared to other sizes.
NOTE
We should also consider powers of two when setting our layer sizes. For example, we should
use a layer size of 128 over size 125, or size 256 over size 250, and so on.
With regard to optimization efficiency, it’s sufficient to note that we cannot
choose the mini-batch size totally in isolation from the other hyperparameters
such as learning rate — a larger mini-batch size means smoother gradients (i.e.,
more accurate/consistent gradients), which, in conjunction with appropriate
tuning, allow for faster learning for a given number of parameter updates. The
trade-off of course is that each parameter update will take longer to compute.
Using a larger mini-batch size might help our network to learn in some difficult
cases, such as for noisy or imbalanced datasets.
So, what mini-batch size should we choose? In practice, 32 to 256 is common
for CPU training, and 32 to 1,024 is common for GPU training. Usually,
something in this range is good enough for smaller networks, though you should
probably test this for larger ones (where training time can be prohibitive).
However, memory requirements can limit the maximum batch size for large
networks anyway.
NOTE
For distributed training, it’s not uncommon to use smaller mini-batch sizes per executor on
shared hardware (such as when training on Spark with multiple executors per machine).
Finally, don’t forget that the number of parameter updates per epoch is reduced
when we increase the mini-batch size (where an epoch refers to one full pass of
the training data). The number of parameter updates per epoch is just the total
number of examples in our training set divided by the mini-batch size.

THE RELATIONSHIP BETWEEN MINI-BATCH SIZE
AND EPOCHS
If we increase our mini-batch size by a factor of two, we need to increase the number of
epochs by a factor of two in order to maintain the same number of parameter updates.



