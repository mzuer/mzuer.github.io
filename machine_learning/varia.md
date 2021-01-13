## Varia

<style>body {text-align: justify}</style>



https://www.institutdesactuaires.com/global/gene/link.php?doc_id=16271&fg=1 
II.2.a. Random Forest (RF) :Random Forestcombine plusieurs arbres de décisions sous la forme d’un algorithme produisant de façon répétée des prédictionsd’un même phénomène. Chacun de ces arbres de décisions est basé sur un échantillon de données et un nombre de variablessélectionnés aléatoirement.


II.2.b. Gradient Boosting (GB) :Le modèleGradient Boostingest aussi basé sur des arbres de décisions, mais diffère du modèle Random Forest du fait qu’ilconsiste à créer des arbres de décisions dans le but d’obtenir l’arbre le plus efficace. Le modèle va ainsi créer un premier arbrede décisions qu’il va ensuite corriger graduellement de manière séquentielle tout en pondérant les erreurs entre les différentsfacteurs. Le modèle final résulte de l’agrégation et l’optimisation des différentes branches.


https://stackoverflow.com/questions/38213291/why-not-optimize-hyperparameters-on-train-dataset


Why not optimize hyperparameters on train dataset?
Asked 4 years, 6 months ago
Active 3 months ago
Viewed 4k times
3

When developing a neural net one typically partitions training data into Train, Test, and Holdout datasets (many people call these Train, Validation, and Test respectively. Same things, different names). Many people advise selecting hyperparameters based on performance in the Test dataset. My question is: why? Why not maximize performance of hyperparameters in the Train dataset, and stop training the hyperparameters when we detect overfitting via a drop in performance in the Test dataset? Since Train is typically larger than Test, would this not produce better results compared to training hyperparameters on the Test dataset?

UPDATE July 6 2016

Terminology change, to match comment below. Datasets are now termed Train, Validation, and Test in this post. I do not use the Test dataset for training. I am using a GA to optimize hyperparameters. At each iteration of the outer GA training process, the GA chooses a new hyperparameter set, trains on the Train dataset, and evaluates on the Validation and Test datasets. The GA adjusts the hyperparameters to maximize accuracy in the Train dataset. Network training within an iteration stops when network overfitting is detected (in the Validation dataset), and the outer GA training process stops when overfitting of the hyperparameters is detected (again in Validation). The result is hyperparameters psuedo-optimized for the Train dataset. The question is: why do many sources (e.g. https://www.cs.toronto.edu/~hinton/absps/JMLRdropout.pdf, Section B.1) recommend optimizing the hyperparameters on the Validation set, rather than the Train set? Quoting from Srivasta, Hinton, et al (link above): "Hyperparameters were tuned on the validation set such that the best validation error was produced..."
machine-learning
neural-network
training-data
Share
Follow
edited Jul 7 '16 at 1:53
asked Jul 5 '16 at 21:44
Ron Cohen
2,41533 gold badges2626 silver badges4242 bronze badges
add a comment
3 Answers
3

The reason is that developing a model always involves tuning its configuration: for example, choosing the number of layers or the size of the layers (called the hyper-parameters of the model, to distinguish them from the parameters, which are the network’s weights). You do this tuning by using as a feedback signal the performance of the model on the validation data. In essence, this tuning is a form of learning: a search for a good configuration in some parameter space. As a result, tuning the configuration of the model based on its performance on the validation set can quickly result in overfitting to the validation set, even though your model is never directly trained on it.

Central to this phenomenon is the notion of information leaks. Every time you tune a hyperparameter of your model based on the model’s performance on the validation set, some information about the validation data leaks into the model. If you do this only once, for one parameter, then very few bits of information will leak, and your validation set will remain reliable to evaluate the model. But if you repeat this many times—running one experiment, evaluating on the validation set, and modifying your model as a result—then you’ll leak an increasingly significant amount of information about the validation set into the model.

At the end of the day, you’ll end up with a model that performs artificially well on the validation data, because that’s what you optimized it for. You care about performance on completely new data, not the validation data, so you need to use a completely different, never-before-seen dataset to evaluate the model: the test dataset. Your model shouldn’t have had access to any information about the test set, even indirectly. If anything about the model has been tuned based on test set performance, then your measure of generalization will be flawed.
Share
Follow
answered Jan 21 '18 at 6:52
Prakhar Agarwal
2,1802222 silver badges2828 bronze badges

    Thank you Prakhar. I agree about info leaks and not overfitting to Test or Validation. But I still am left with my original question: why not a) tune hyperparameters based on performance in the Train dataset, b) use Validation to detect hyperparameter overfitting, and c) use Test to estimate performance on new unseen data? – Ron Cohen Jan 21 '18 at 14:56
    1
    What you are saying is just re-framing my answer. Think this way: a.) what do you mean by tuning. When you start training the model using trainset, you fix the hyperparameters(number of layers, number of neurons in each layer etc.) and basically learn the weights. b.) Then evaluate this using validation set. In short, "all" combinations of hyperpameters can learn a set of weights having low loss on training set, but what value of hyperparameters are best is decided using Validation set. – Prakhar Agarwal Jan 21 '18 at 15:26 

add a comment
3

There are two things you are missing here. First, minor, is that test set is never used to do any training. This is a purpose of validation (test is just to asses your final, testing performance). The major missunderstanding is what it means "to use validation set to fit hyperparameters". This means exactly what you describe - to train a model with a given hyperparameters on the training set, and use validation to simply check if you are overfitting (you use it to estimate generalization) , but you do not really "train" on them, you simply check your scores on this subset (which, as you noticed - is way smaller).

You cannot "stop training hyperparamters" because this is not a continuous process, usually hyperparameters are just "possible sets of values", and you have to simply test lots of them, there is no valid way of defining a direct trainingn procedure between actual metric you are interested in (like accuracy) and hyperparameters (like size of the hidden layer in NN or even C parameter in SVM), as the functional link between these two is not differentiable, is highly non convex and in general "ugly" to optimize. If you can define a nice optimization procedure in terms of a hyperparameter than it is usually not called a hyperparameter but a parameter, the crucial distinction in this naming convention is what makes it hard to optimize directly - we call hyperparameter a parameter, than cannot be directly optimized against thus you need a "meta method" (like simply testing on validation set) to select it.

However, you can define a "nice" meta optimization protocol for hyperparameters, but this will still use validation set as an estimator, for example Bayesian optimization of hyperparameters does exactly this - it tries to fit a function saying how well is you model behaving in the space of hyperparameters, but in order to have any "training data" for this meta-method, you need validation set to estimate it for any given set of hyperparameters (input to your meta method)


https://deeplylearning.fr/cours-theoriques-deep-learning/reglages-des-hyper-parametres/

