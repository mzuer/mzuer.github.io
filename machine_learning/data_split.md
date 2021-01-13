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

##### *(source: Data Science par la pratique - Grus)*

pour départager plusieurs modèles: dans ce cas, bien que chaque modèle ne soit pas forcément trop ajusté, la décision "choisir un modèle qui est le plus performant sur le jeu de données de test" est un méta-apprentissage qui considère le jeu de teste comme un deuxième jeu d'apprentissage (évidemment le modèle le plus performant en test sera également performant sur le jeu de test)

dans une telle situation, il faut séparer les données en 3 parties
1. un jeu d'apprentissage: pour construire les modèles
2. un jeu de validation pour sélectionner un modèle
3. un jeu de test pour juger le modèle retenu à la fin de l'expérience

https://constellation.uqac.ca/5857/1/Zoungrana_uqac_0862N_10694.pdf

4.3.2.1. MÉTHODE DE VALIDATION CROISÉE (K-FOLD)Une   méthode   d’évaluation   des   performances   d’un   algorithme   d’apprentissage automatique  est  la  validation  croisée.  Cette  technique  permet  à  l’algorithme  de  faire  des prédictions en utilisant des données non utilisées pendant la phase de formation. La validation croisée  partitionne  un  ensemble  de  données  et  utilise  un  sous-ensemble  pour entraînerl’algorithme et les données restantes à tester. Étant donné que la validation croisée n’utilise pas toutes  les  données  pour  créer  un  modèle,  il  s’agit  d’une  méthode  couramment  utilisée  pour éviter le surapprentissage pendant la formation.Le  principe  de  cette  méthode  de  validation  consiste  à  partitionnerles  données  en  k sous-ensembles (ou plis) choisis au hasard de taille à peu près égale. Un sous-ensemble est utilisé  pour  valider  le  modèle  formé  à  l’aide  des  sous-ensembles  restants.  Ce  processus  est répété  k  fois,  de  sorte  que  chaque  sous-ensemble soitutilisé  exactement  une  fois  pour  la validation.L’ensemble   deformation   est   ensuite   utilisé   pour   former   un   algorithme d’apprentissage supervisé, et l’ensemble de testsest utilisé pour évaluer ses performances. Ce processus est répété plusieurs fois et l’erreur de validation croisée moyenne est utilisée comme indicateur de performance.

https://www-npa.lip6.fr/~tixeuil/m2r/uploads/Main/PROGRES2019_5.pdf

La validation croisée va nous permettre d’utiliser l'intégralité de notre jeu de données pour l’entraînement et pour la validationOn découpe le jeu de données en k parties (foldsen anglais) à peu près égales. Tour à tour, chacune des k parties est utilisée comme jeu de test. Le reste (autrement dit, l’union des k-1 autres parties) est utilisé pour l'entraînement

https://stats.stackovernet.xyz/fr/q/43976

Hyperparameter optimization is a part of model selection, since you want to determine both the best learning method and its hyperparameterization.

The right way to deal with this is via nested cross-validation, which looks something like this:

1. cross-validate(data)
       --> train_outer and test_outer

       1.1 cross-validate(train_outer)
           --> train_inner and test_inner

           evaluate performance of given model for each fold
           where model includes learning method & hyperparameterization

           1.1.1 train model on train_inner (with given hyperparameterization)
           1.1.2 test trained model on test_inner
           1.1.3 compute performance metric of your choice

       1.2 select best modeling approach and train on train_outer
       (the best is determined based on performance in (1.1))

       1.3 estimate performance of best approach from 1.1 on test_outer

2. aggregate results from cross-validation (1) for performance estimate

The result of a nested cross-validation procedure is a fair performance estimate of your whole modelling pipeline, which includes hyperparameter optimization and, optionally, learning algorithm selection.

Finally, you mention randomized search to find suitable hyperparameters. It's worth noting that much better methods exist, in libraries such as Optunity. These dedicated methods will give you better sets of hyperparameters than random search given the same budget.

To see an example of this in Python, please refer to the nested cross-validation example in Optunity's documentation. You can expand the same setup to include learning algorithm selection instead of limiting yourself to optimizing the hyperparameterization for a predefined approach.

https://archipel.uqam.ca/13417/1/M16281.pdf

En apprentissage automatique, le processus d'autoapprentissage d'un algorithme correspond généralement à deux boucles imbriquées (figure 2.1). La boucle externe itère sur les valeurs des hyperparamètres, alors que la boucle interne minimise une mesure d'erreur empirique.

https://www.spiria.com/fr/blogue/intelligence-artificielle/3-etapes-essentielles-apprentissage-automatique-machine-learning/

Le choix d’algorithme

À cette étape, on peut commencer à entraîner les algorithmes, mais avant tout :

    Divisez votre ensemble de données en trois parties : entraînement, test et validation.
        Les données d’entraînement serviront à entraîner le ou les algorithmes choisis ;
        Les données de test seront utilisées pour vérifier la performance du résultat ;
        Les données de validation ne seront utilisées qu’à la toute fin du processus et ne seront, sauf nécessité, que très rarement examinées et utilisées avant afin d’éviter d’introduire un quelconque biais dans le résultat.
    Choisissez le ou les algorithmes pertinents.
    Essayez les algorithmes avec différentes combinaisons de paramètres et comparez les performances de leurs résultats.
    Utilisez la procédure des hyperparamètres (Grid-Search en Python, par exemple) pour essayer de nombreuses combinaisons, et trouver celle qui donne le meilleur résultat (n’essayez pas de combinaisons manuelles).
    Dès que vous êtes raisonnablement satisfait d’un modèle, sauvegardez-le même s’il n’est pas parfait, car vous risquez de ne plus jamais retrouver la combinaison qui vous a permis de l’obtenir.
    Continuer les essais après chaque nouveau modèle. Si les résultats ne sont pas satisfaisants, vous pouvez recommencer :
        Au stade des hyperparamètres, si vous avez de la chance.
        Il est également possible de devoir recommencer à partir du choix de features à inclure ou même revoir l’état de nos données (vérifiez s’il n’y a pas de problèmes de normalisation, de régularisation, d’échelle, de valeurs aberrantes…).






https://qastack.fr/stats/168807/why-splitting-the-data-into-the-training-and-testing-set-is-not-enough



Même si vous entraînez des modèles exclusivement sur les données d'entraînement, vous optimisez les hyperparamètres (par exemple pour un SVM) sur la base de l'ensemble de test. En tant que tel, votre estimation des performances peut être optimiste, car vous signalez essentiellement les meilleurs résultats. Comme certains l'ont déjà mentionné sur ce site, l' optimisation est la racine de tout mal dans les statistiques .CC

Les estimations de performances doivent toujours être effectuées sur des données totalement indépendantes. Si vous optimisez un aspect basé sur des données de test, vos données de test ne sont plus indépendantes et vous auriez besoin d'un ensemble de validation.

Une autre façon de résoudre ce problème est via la validation croisée imbriquée , qui consiste en deux procédures de validation croisée enroulées l'une autour de l'autre. La validation croisée interne est utilisée dans le réglage (pour estimer les performances d'un ensemble donné d'hyperparamètres, qui est optimisé) et la validation croisée externe estime les performances de généralisation de l'ensemble du pipeline d'apprentissage automatique (c'est-à-dire, optimisation des hyperparamètres + formation du modèle final). ).
— Marc Claesen
source
Je peux me tromper, mais l'ensemble de test ne sert pas seulement à régler les hyperparamètres, mais aussi à comparer différents types de techniques comme, par exemple, les performances de SVM par rapport à LDA ou à la forêt aléatoire, comme je l'ai indiqué dans ma réponse.
@fcoppens Oui, certainement. Je ne l'ai pas explicitement mentionné, mais cela s'inscrit certainement dans cette étape. 

https://essicolo.github.io/ecologie-mathematique-R/chapitre-ml.html

11.2.4 Validation croisée

Souvent confondue avec le fait de séparer le tableau en phases d’entraînement et de test, la validation croisée est un principe incluant plusieurs algorithmes qui consistent à entraîner le modèle sur un échantillonnage aléatoire des données d’entraînement. La technique la plus utilisée est le k-fold, où l’on sépare aléatoirement le tableau d’entraînement en un nombre k de tableaux. À chaque étape de la validation croisée, on calibre le modèle sur tous les tableaux sauf un, puis on valide le modèle sur le tableau exclu. La performance du modèle en entraînement est jugée sur les validations.


https://www.jeremyjordan.me/hyperparameter-tuning/

When you start exploring various model architectures (ie. different hyperparameter values), you also need a way to evaluate each model's ability to generalize to unseen data. However, if you use the testing data for this evaluation, you'll end up "fitting" the model architecture to the testing data - losing the ability to truely evaluate how the model performs on unseen data. This is sometimes referred to as "data leakage".

To mitigate this, we'll end up splitting the total dataset into three subsets: training data, validation data, and testing data. The introduction of a validation dataset allows us to evaluate the model on different data than it was trained on and select the best model architecture, while still holding out a subset of the data for the final evaluation at the end of our model development.

You can also leverage more advanced techniques such as K-fold cross validation in order to essentially combine training and validation data for both learning the model parameters and evaluating the model without introducing data leakage.

https://www.oreilly.com/library/view/evaluating-machine-learning/9781492048756/ch04.html

Hyperparameter tuning is a meta-optimization task. As Figure 4-1 shows, each trial of a particular hyperparameter setting involves training a model—an inner optimization process. The outcome of hyperparameter tuning is the best hyperparameter setting, and the outcome of model training is the best model parameter setting.

For each proposed hyperparameter setting, the inner model training process comes up with a model for the dataset and outputs evaluation results on hold-out or cross-validation datasets. After evaluating a number of hyperparameter settings, the hyperparameter tuner outputs the setting that yields the best performing model. The last step is to train a new model on the entire dataset (training and validation) under the best hyperparameter setting. Example 4-1 is a Pythonic version of the pseudocode. (The training and validation step can be conceptually replaced with a cross-validation step.)



Conceptually, hyperparameter tuning is an optimization task, just like model training.

However, these two tasks are quite different in practice. When training a model, the quality of a proposed set of model parameters can be written as a mathematical formula (usually called the loss function). When tuning hyperparameters, however, the quality of those hyperparameters cannot be written down in a closed-form formula, because it depends on the outcome of a black box (the model training process).

This is why hyperparameter tuning is much harder. 



The Case for Nested Cross-Validation

Before concluding this chapter, we need to go up one more level and talk about nested cross-validation, or nested hyperparameter tuning. (I suppose this makes it a meta-meta-learning task.)

There is a subtle difference between model selection and hyperparameter tuning. Model selection can include not just tuning the hyperparameters for a particular family of models (e.g., the depth of a decision tree); it can also include choosing between different model families (e.g., should I use decision tree or linear SVM?). Some advanced hyperparameter tuning methods claim to be able to choose between different model families. But most of the time this is not advisable. The hyperparameters for different kinds of models have nothing to do with each other, so it’s best not to lump them together.

Choosing between different model families adds one more layer to our cake of prototyping models. Remember our discussion about why one must never mix training data and evaluation data? This means that we now must set aside validation data (or do cross-validation) for the hyperparameter tuner.

To make this precise, Example 4-2 shows the pseudocode in Python form. I use hold-out validation because it’s simpler to code. You can do cross-validation or bootstrap validation, too. Note that at the end of each for loop, you should train the best model on all the available data at this stage.
Example 4-2. Pseudo-Python code for nested hyperparameter tuning
```
func nested_hp_tuning(data, model_family_list):
    perf_list = []
    hp_list = []

    for mf in model_family_list:
        # split data into 80% and 20% subsets
        # give subset A to the inner hyperparameter tuner,
        # save subset B for meta-evaluation
        A, B = train_test_split(data, 0.8)

        # further split A into training and validation sets
        C, D = train_test_split(A, 0.8)

        # generate_hp_candidates should be a function that knows 
        # how to generate candidate hyperparameter settings 
        # for any given model family
        hp_settings_list = generate_hp_candidates(mf)

        # run hyperparameter tuner to find best hyperparameters
        best_hp, best_m = hyperparameter_tuner(C, D, 
                                               hp_settings_list)

        result = evaluate(best_m, B)
        perf_list.append(result)
        hp_list.append(best_hp)
        # end of inner hyperparameter tuning loop for a single 
        # model family
        

    # find best model family (max_index is a helper function
    # that finds the index of the maximum element in a list)
    best_mf = model_family_list[max_index(perf_list)]
    best_hp = hp_list[max_index(perf_list)]

    # train a model from the best model family using all of 
    # the data
    model = train_mf_model(best_mf, best_hp, data)
    return (best_mf, best_hp, model)
```
Hyperparameters can make a big difference in the performance of a machine learning model. Many Kaggle competitions come down to hyperparameter tuning. But after all, it is just another optimization task, albeit a difficult one. With all the smart tuning methods being invented, there is hope that manual hyperparameter tuning will soon be a thing of the past. Machine learning is about algorithms that make themselves smarter over time. (It’s not a sinister Skynet; it’s just mathematics.) There’s no reason that a machine learning model can’t eventually learn to tune itself. We just need better optimization methods that can deal with complex response surfaces. We’re almost there!




https://fr.qaz.wiki/wiki/Training,_validation,_and_test_sets

 Ensemble de données de formation Un ensemble de données d'apprentissage est un ensemble de données d'exemples utilisés pendant le processus d'apprentissage et est utilisé pour ajuster les paramètres (par exemple, les poids) d'un classificateur , par exemple . Pour les tâches de classification, un algorithme d'apprentissage supervisé examine l'ensemble de données d'entraînement pour déterminer, ou apprendre, les combinaisons optimales de variables qui généreront un bon modèle prédictif . L'objectif est de produire un modèle entraîné (ajusté) qui se généralise bien aux nouvelles données inconnues. Le modèle ajusté est évalué à l'aide de «nouveaux» exemples tirés des jeux de données bloqués (jeux de données de validation et de test) pour estimer la précision du modèle dans la classification des nouvelles données. Pour réduire le risque de problèmes tels que le surajustement, les exemples des ensembles de données de validation et de test ne doivent pas être utilisés pour entraîner le modèle. La plupart des approches qui recherchent des relations empiriques dans les données de formation ont tendance à surappliquer les données, ce qui signifie qu'elles peuvent identifier et exploiter des relations apparentes dans les données de formation qui ne tiennent pas en général. Ensemble de données de validation Un ensemble de données de validation est un ensemble de données d'exemples utilisés pour régler les hyperparamètres (c'est-à-dire l'architecture) d'un classificateur. Il est parfois également appelé ensemble de développement ou «ensemble de développement». Un exemple d'hyperparamètre pour les réseaux de neurones artificiels comprend le nombre d'unités cachées dans chaque couche. Elle, ainsi que l'ensemble de test (comme mentionné ci-dessus), doivent suivre la même distribution de probabilité que l'ensemble de données d'entraînement. Afin d'éviter le surajustement, lorsqu'un paramètre de classification doit être ajusté, il est nécessaire de disposer d'un ensemble de données de validation en plus des ensembles de données d'entraînement et de test. Par exemple, si le classificateur le plus adapté au problème est recherché, le jeu de données de formation est utilisé pour former les différents classificateurs candidats, le jeu de données de validation est utilisé pour comparer leurs performances et décider lequel prendre et, enfin, le jeu de données de test est utilisé pour obtenir les caractéristiques de performance telles que la précision , la sensibilité , la spécificité , la mesure F , etc. L'ensemble de données de validation fonctionne comme un hybride: il s'agit de données d'entraînement utilisées pour les tests, mais ni dans le cadre de la formation de bas niveau ni dans le cadre des tests finaux. Le processus de base d'utilisation d'un jeu de données de validation pour la sélection de modèle (dans le cadre d'un jeu de données d'entraînement, d'un jeu de données de validation et d'un jeu de données de test) est: Puisque notre objectif est de trouver le réseau ayant les meilleures performances sur les nouvelles données, l'approche la plus simple pour comparer différents réseaux est d'évaluer la fonction d'erreur à l'aide de données indépendantes de celles utilisées pour la formation. Divers réseaux sont entraînés par minimisation d'une fonction d'erreur appropriée définie par rapport à un ensemble de données d'apprentissage. Les performances des réseaux sont ensuite comparées en évaluant la fonction d'erreur à l'aide d'un ensemble de validation indépendant, et le réseau ayant la plus petite erreur par rapport à l'ensemble de validation est sélectionné. Cette approche est appelée la méthode hold out . Étant donné que cette procédure peut elle-même conduire à un certain surajustement de l'ensemble de validation, les performances du réseau sélectionné doivent être confirmées en mesurant ses performances sur un troisième ensemble de données indépendant appelé ensemble de test. Une application de ce processus est en arrêt précoce , où les modèles candidats sont des itérations successives du même réseau, et l'entraînement s'arrête lorsque l'erreur sur l'ensemble de validation augmente, en choisissant le modèle précédent (celui avec l'erreur minimale). Jeu de données de test Un ensemble de données de test est un ensemble de données qui est indépendante de l'ensemble de données de formation, mais qui suit la même distribution de probabilité que l'ensemble de données de formation. Si un modèle adapté à l'ensemble de données d'entraînement correspond également bien à l'ensemble de données de test, un surajustement minimal a eu lieu (voir la figure ci-dessous). Un meilleur ajustement de l'ensemble de données d'entraînement par opposition à l'ensemble de données de test indique généralement un surajustement. Un ensemble de tests est donc un ensemble d'exemples utilisés uniquement pour évaluer les performances (c'est-à-dire la généralisation) d'un classificateur entièrement spécifié. Pour ce faire, le modèle final est utilisé pour prédire les classifications des exemples dans l'ensemble de test. Ces prédictions sont comparées aux véritables classifications des exemples pour évaluer la précision du modèle. Dans un scénario où les jeux de données de validation et de test sont utilisés, le jeu de données de test est généralement utilisé pour évaluer le modèle final sélectionné au cours du processus de validation. Dans le cas où l'ensemble de données d'origine est partitionné en deux sous-ensembles (ensembles de données d'entraînement et de test), l'ensemble de données de test peut évaluer le modèle une seule fois (par exemple, dans la méthode d'exclusion ). Notez que certaines sources déconseillent une telle méthode. Cependant, lors de l'utilisation d'une méthode telle que la validation croisée , deux partitions peuvent être suffisantes et efficaces puisque les résultats sont moyennés après des cycles répétés de formation et de tests de modèles pour aider à réduire les biais et la variabilité. Ensembles de formation, de validation et de test - https://fr.qaz.wiki/wiki/Training,_validation,_and_test_sets
 
 
 
 
 ##### *(source: Evaluating Machine Learning Models - Zheng)*
 
 Caution: The Difference Between Model
Validation and Testing
Thus far I’ve been careful to avoid the word “testing.” This is because
model validation is a different step than model testing. This is a sub‐
tle point. So let me take a moment to explain it.
The prototyping phase revolves around model selection, which
requires measuring the performance of one or more candidate mod‐
els on one or more validation datasets. When we are satisfied with
the selected model type and hyperparameters, the last step of the
prototyping phase should be to train a new model on the entire set of
available data using the best hyperparameters found. This should
include any data that was previously held aside for validation. This is
the final model that should be deployed to production.
Testing happens after the prototyping phase is over, either online in
the production system or offline as a way of monitoring distribution
drift, as discussed earlier in this chapter.
Never mix training data and evaluation data. Training, validation,
and testing should happen on different datasets. If information from
the validation data or test data leaks into the training procedure, it
would lead to a bad estimate of generalization error, which then
leads to bitter tears of regret.
A while ago, a scandal broke out around the ImageNet competition,
where one team was caught cheating by submitting too many mod‐
els to the test procedure. Essentially, they performed hyperparame‐
ter tuning on the test set. Building models that are specifically tuned
for a test set might help you win the competition, but it does not
lead to better models or scientific progress.
 
 
 https://www.brainstobytes.com/test-training-and-validation-sets/
 
Test, training and validation sets
By Juan Orozco Villalobos • January 28, 2020
Test, training and validation sets

As you might remember, supervised learning makes use of a training set to teach a model how to perform a task or predict a value (or values). It's also important to remember that this training data needs to be labeled with the expected result/right answer for every individual example in the set.

In projects that use supervised learning, some effort is required in the beginning to build a dataset with labeled examples. In practice, you will need to extract 3 subsets from this original labeled data: the training, validation and test sets. This is an important step for evaluating the performance of different models and the effect of hyperparameter tuning.

Despite being a fundamental topic, many early practitioners in data science find it a bit confusing. Understanding the usage and differences between the validation and test sets is important and doesn't require much effort.

So let's take a look at both how both sets are used to understand why we need them.
Validation and test sets, where do they come from?

Both sets are derived from your original labeled data. That data usually needs to be compiled from different sources across an organization and transformed into a structured format. This is a huge topic and the goal of the article is not to explore data mining techniques, so we will just assume that we have a dataset made of labeled examples.

Once you have the training data, you need to split it into three sets:

    Traning set: The data you will use to train your model. This will be fed into an algorithm that generates a model. Said model maps inputs to outputs.
    Validation set: This is smaller than the training set, and is used to evaluate the performance of models with different hyperparameter values. It's also used to detect overfitting during the training stages.
    Test set: This set is used to get an idea of the final performance of a model after hyperparameter tuning. It's also useful to get an idea of how different models (SVMs, Neural Networks, Random forests...) perform against each other.

Sets

Now, some important considerations:

    The validation and test sets are usually much smaller than the training set. Depending on the amount of data you have, you usually set aside 80%-90% for training and the rest is split equally for validation and testing. Many things can influence the exact proportion of the split, but in general, the biggest part of the data is used for training.
    The validation and test sets are put aside at the beginning of the project and are not used for training. This might seem obvious, but it's important to remember that they are there to evaluate the performance of the model. Evaluating a model on the data used to train it will make you believe it's performing better than it would in reality.
    All 3 sets need to be representative. This means that all the sets need to contain diverse examples that represent the problem space. For example, in a multiclass classification problem, you want to ensure that all 3 sets contain enough examples of each class. Otherwise, you run the risk of training a model with just a non-representative subset of the data or performing poor validation and testing.

Good, it's time to see where each set is used.
The validation set and hyperparameter tuning

Different machine learning algorithms for training models have special values you can tweak before the learning process begins. These values are called hyperparameters and are used to configure the training process that will produce your models.

Changing the value of hyperparameters alters the produced model, and are usually used to configure how the algorithm learns relationships in data. A typical usage for hyperparameters is setting the complexity of the model: you can create a more complex model that can learn complicated relationships or a simpler model that learns simpler relationships using the exact same algorithm.

A basic example of a hyperparameter is the depth of a decision tree. A shallow tree (just a couple of levels) is a much simpler model and can only learn very basic relationships between inputs and outputs. Training is relatively simple and fast, and for a lot of applications, it's just enough.

A deeper tree can learn much more complex relationships and tackle harder problems, but training it takes longer and you are at risk of overfitting.

DecisionTree

So, which hyperparameters produce the model that best performs on your data? This is hard or impossible to calculate using theoretical tools, so we opt for a much more hands-on approach: test different algorithm and hyperparameter configurations. For evaluating the performance we need data the model hasn't seen yet, so we use the validation set.

You will run your models on the validation set and see how different hyperparameter configurations perform. Based on the results, you will tweak them until the model performs well enough for the specific problem you are trying to solve.

It is also by comparing the results with the validation sets that you can notice overfitting, a topic we will explore in a future article.

After you are done tweaking hyperparameters and have a few promising models, it's time to run some final tests.
Evaluating performance on the test set

Your final tests need data your models haven't seen yet.

Ok, but we already have a validation set, why do we need another set?

This is important because some information from the validation set might leak into the models. This means that by tuning hyperparameters, you might be teaching some of the idiosyncrasies of the validation set to your models (things that are not part of the general data). You might end up with models that are over tweaked to perform great on the validation set but don't perform that well on real data.

That's why you need a test set: a collection of examples that don't form part of the training process and don't participate in model tuning. This set doesn't leak any information into your models, so you can safely use it to get an idea of how well the model will perform in production.

A test set lets you compare different models in an unbiased (or less biassed) way at the end of the training process. In other words, you can use the test set as a final confirmation of the predictive power of your model.
What happens if I don't have enough data?

Sometimes you don't have enough data to perform proper training/validation. You run the risk of not being able to properly train the model or having unreliable validation depending on the way you perform the split. In these scenarios, the best thing is to set aside some data for the test set and perform k-fold cross-validation.

In k-fold cross-validation, you will select k different subsets of data as validation sets and train k models on the remaining data. After that, you will evaluate the performance of the models and average their results. This technique is especially useful if you don't have that much data available for training. The following is an example when k equals 4.

4FoldValidation

This has the advantage of offering you a better idea of the model's performance without needing lots of data. K-folds cross-validation is an extremely popular approach and usually works surprisingly well.



 https://sebastianraschka.com/blog/2016/model-evaluation-selection-part3.html
 
 !!! very good
 
 
 
 
 
 
