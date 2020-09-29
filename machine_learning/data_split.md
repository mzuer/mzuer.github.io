## Data split (train, test, validation)

<style>body {text-align: justify}</style>

##### *(source: Deep learning: a practitioner's approach - Gibson and Patterson)*

Training, validation, and test data
It’s considered a best practice to not only split out the training data into training
and test splits, but validation splits, as well. We use validation splits to guide our
efforts in possibly stopping training early.


##### *(source: Dive into Deep Learning - Zhang et al.)*


**Validation dataset**
In principle we should *not touch our test set until after we have chosen all our hyperparameters*.Were we to use the test data in the model selection process, there is a risk that we might *overfit* the test data. If we overfit our training data, there is always the evaluation on test data to keep us honest. But if we overfit the test data, how would we ever know?Thus, we should *never rely on the test data for model selection*. And yet *we cannot rely solely on the training data for model selection* either because *we cannot estimate the generalization error on the very data that we use to train the model*. In practical applications, the picture gets muddier. While ideally we would only touch the test data once, to assess the very best model or to compare a small number of models to each other, real-world test data is seldom discarded after just one use. We can seldom afford a new test set for each round of experiments. The common practice to address this problem is to *split our data three ways*, incorporating a **validation** dataset (or validation set) in addition to the **training** and **test** datasets. The result is a murky practice where the boundaries between validation and test data are worryingly ambiguous. 


##### *(source: neural networks and deep learning - Aggarwal)*

Because of the large gaps between training and test error, models are often tested on unseen
portions of the training data. These unseen portions of the test data are often held out early
on, and then used in order to make different types of algorithmic decisions such as parameter
tuning. This set of points is referred to as the **validation set**. The final accuracy is tested on a
fully out-of-sample set of points that was not used for either model building or for parameter
tuning. The error on out-of-sample test data is also referred to as the generalization error.



There are several practical issues in the training of neural network models that one must be
careful of because of the **bias-variance trade-off**. The first of these issues is associated with
*model tuning and hyperparameter choice*. For example, if one tuned the neural network with
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


A given data set should always be divided into **three parts** defined according to the way in
which the data are used:

1. **Training data** = part of the data used to *build the training model* (i.e., during
the process of learning the weights of the neural network). Several design choices may
be available during the building of the model. The neural network might use different
hyperparameters for the learning rate or for regularization. The same training data
set may be tried multiple times over different choices for the hyperparameters or
completely different algorithms to build the models in multiple ways. This process
allows estimation of the relative accuracy of different algorithm settings. This process
sets the stage for model selection, in which the best algorithm is selected out of these
different models. However, *the actual evaluation of these algorithms for selecting the
best model is not done on the training data*, but on a separate validation data set to
avoid favoring overfitted models.
2. **Validation data** = part of the data used for *model selection and parameter
tuning*. For example, the choice of the learning rate may be tuned by constructing
the model multiple times on the first part of the data set (i.e., training data), and
then using the validation set to estimate the accuracy of these different models. Different combinations of parameters are sampled within a range and tested for accuracy on the validation set. The best choice
of each combination of parameters is determined by using this accuracy. In a sense,
*validation data should be viewed as a kind of test data set to tune the parameters of
the algorithm (e.g., learning rate, number of layers or units in each layer), or to select
the best design choice (e.g., sigmoid versus tanh activation)*.
3. **Testing data** = part of the data used to *test the accuracy of the final (tuned)
model*. It is important that the testing data are not even looked at during the process
of parameter tuning and model selection to prevent overfitting. The testing data are
*used only once at the very end of the process*. Furthermore, if the analyst uses the
results on the test data to adjust the model in some way, then the results will be
contaminated with knowledge from the testing data. The idea that one is allowed
to look at a test data set only once is an extraordinarily strict requirement (and an
important one). Yet, it is frequently violated in real-life benchmarks. The temptation
to use what one has learned from the final accuracy evaluation is simply too high.

Strictly speaking, the validation data is also a part of the training
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

##### *(source: [openclassrooms.com](https://openclassrooms.com/fr/courses/4011851-initiez-vous-au-machine-learning/4020631-exploitez-votre-jeu-de-donnees))*


Comme nous l’avons vu, l’entraînement d’un modèle revient à mesurer l’erreur de la sortie de l’algorithme avec les données d’exemple et chercher à la minimiser.

Un premier piège à éviter est donc d'évaluer la qualité de votre modèle final à l'aide des mêmes données qui ont servi pour l'entraînement. En effet, le modèle est complètement optimisé pour les données à l'aide desquelles il a été créé. L'erreur sera précisément minimum sur ces données. Alors que l'erreur sera toujours plus élevée sur des données que le modèle n'aura jamais vues !
Pour minimiser ce problème, la meilleure approche est de séparer dès le départ notre jeu de données en deux parties distinctes :
1. Le **training set**, qui va nous permettre d’entraîner notre modèle et sera utilisé par l’algorithme d’apprentissage. C'est celui dont on a parlé depuis le début.
2. Le **testing set**, qui permet de *mesurer l’erreur du modèle final sur des données qu’il n’a jamais vues*. On va simplement passer ces données comme s'il s'agissait de données que l’on n'a encore jamais rencontrées (comme cela va se passer ensuite en pratique pour prédire de nouvelles données) et mesurer la performance de notre modèle sur ces données. On appelle aussi cela **held-out data**, pour souligner que ce sont des données auxquelles on ne va pas toucher avant la toute fin pour pouvoir être bien sûr que le modèle fonctionne.
    
En général, les données sont séparées avec les proportions suivantes : 80 % pour le training set et 20 % pour le testing set.
    
Le **validation set** – qui permet de *mesurer l’erreur de prédiction pour choisir entre plusieurs modèles* – est aussi souvent utilisé. 

Pourquoi ne pas utiliser toutes les données pour l’entraînement et réutiliser ensuite toutes les données pour tester le modèle ?
En fait, il s’avère que si l'on entraîne le modèle avec des données, il va naturellement être plus performant sur ces données-là. Ce qui nous intéresse, c’est de mesurer sa performance sur des données qu’il n’a jamais vues, puisque c’est ce qui va se passer en pratique. Cette performance est appelée la *généralisation* du modèle : sa capacité à effectuer des prédictions de qualité sur des situations jamais rencontrées. On étudiera ça plus en détail dans la prochaine partie de ce cours. 

##### *(source: [developpez.com](https://khayyam.developpez.com/articles/machine-learning/scikit-learn))*

Dès que vous souhaitez mettre en place un apprentissage automatisé, vous avez besoin de manipuler plusieurs ensembles. Vous allez découper votre ensemble labellisé en plusieurs sous-ensembles :
1. un **ensemble d'entraînement** pour entraîner vos modèles de machine learning ;
2. un **ensemble de test** pour *mesurer la performance* de vos modèles sur des données non apprises. La performance d'un modèle sur l'ensemble de test correspond à une mesure de ce modèle sur des données réelles, qui permettent d'*évaluer la capacité de généralisation* du modèle ;
3. vous pouvez éventuellement utiliser un **ensemble de validation** pour *déterminer les meilleurs hyper-paramètres de vos modèles*. Vous allez ainsi rechercher le meilleur paramétrage de vos modèles sans pour autant vous servir de l'ensemble de test. 

Il est nécessaire que tous les ensembles que vous manipulez soient représentatifs du cas à modéliser sans quoi vous allez tester le modèle sur des données qui ne correspondent pas aux données d'entraînement. C'est pourquoivous devez vous assurer que les distributions de tous ces ensembles sont comparables. Généralement on réalise des coupes aléatoires dans le dataset pour déterminer les sous-ensembles.

**Validation croisée**

Le souci dans l'utilisation d'un ensemble de test c'est que vous allez réduire votre ensemble d'entraînement pour isoler un ensemble de test. Si votre jeu de données est restreint, vous allez le restreindre encore plus et cela pourra pénaliser l'apprentissage : avec trop peu de données, le modèle ne pourra pas apprendre correctement. Un autre souci à l'utilisation d'un ensemble de test c'est qu'il est nécessairement plus petit et que les mesures de performances du modèle sur ce petit ensemble risquent de ne pas représenter sa capacité à généraliser. Un ensemble petit aura plus de mal à rester représentatif des données réelles. C'est pourquoi on choisira souvent d'utiliser une *validation croisée pour affiner les hyper-paramètres d'un modèle*.La validation croisée consiste en une *suite de découpages distincts en un ensemble d'entraînement et un ensemble de validation*. Chaque découpage permet de mesurer une performance du modèle et la moyenne des performances de chaque découpage permet de trouver les meilleurs hyper-paramètres sans jamais avoir validé le modèle sur une donnée déjà apprise.


##### *(source: Introduction au machine learning - Azencott)*

**Estimation empirique de l’erreur de généralisation**
L’erreur empirique mesurée sur les observations qui ont permis de construire le modèle est un mauvais
estimateur de l’erreur du modèle sur l’ensemble des données possibles, ou erreur de généralisation : si le
modèle sur-apprend, cette erreur empirique peut être proche de zéro voire nulle, tandis que l’erreur de
généralisation peut être arbitrairement grande.


**Jeu de test**
Il est donc indispensable d’utiliser pour évaluer un modèle des données étiquetées qui n’ont pas servi
à le construire. La manière la plus simple d’y parvenir est de mettre de côté une partie des observations,
réservées à l’évaluation du modèle, et d’utiliser uniquement le reste des données pour le construire.

Étant donné un jeu de données *D*, on appelle **jeu d’entraînement** (*training set* en anglais) l’ensemble utilisé pour entraîner un modèle prédictif, et 
**jeu de test** (*test set* en anglais) l’ensemble utilisé pour son
évaluation.

Comme nous n’avons pas utilisé le jeu de test pour entraîner notre modèle, il peut être considéré comme
un jeu de données « nouvelles ». La perte calculée sur ce jeu de test est un estimateur de l’erreur de géné-
ralisation.


**Jeu de validation**
Considérons maintenant la situation dans laquelle nous voulons choisir entre *K* modèles. Nous pouvons
alors entraîner chacun des modèles sur le jeu de données d’entraînement, obtenant ainsi *K* fonctions de
décision puis calculer l’erreur de chacun de ces modèles sur le jeu de test. 
Nous pouvons
ensuite choisir comme modèle celui qui a la plus petite erreur sur le jeu de test.
Mais quelle est son erreur de généralisation ? Comme nous avons utilisé un ensemble des données pour sélectionner le modèle,
il ne représente plus un jeu indépendant composé de données nouvelles, inutilisées pour déterminer le
modèle.

La solution est alors de *découper notre jeu de données en trois parties* :
— Un **jeu d’entraînement** sur lequel nous pourrons *entraîner* nos *K* algorithmes d’apprentissage ;
— Un **jeu de validation** (*validation set* en anglais) sur lequel nous *évaluerons* les *K* modèles ainsi
obtenus, afin de sélectionner un modèle définitif ;
— Un **jeu de test** sur lequel nous évaluerons enfin l’*erreur de généralisation* du modèle choisi.


On voit ici qu’il est *important de distinguer la sélection d’un modèle de son évaluation* : les faire sur les
mêmes données peut nous conduire à sous-estimer l’erreur de généralisation et le sur-apprentissage du
modèle choisi.

*Remarque*: une fois un modèle sélectionné, on peut le ré-entraîner sur l’union du jeu d’entraînement et du jeu de
validation afin de construire un modèle final.



