## Points-clefs du livre **Introduction au Machine Learning** de Chloé-Agathe Azencott

### Chapitre 2. Apprentissage supervisé

##### Points clefs
- Les trois ingrédients d'un **algorithme d'apprentissage supervisé** sont :
	1. l'espace des hypothèses,
	2. la fonction de coût,
	3. l'algorithme d'optimisation qui permet de trouver l'hypothèse optimale au sens de la fonction
de coût sur les données (minimisation du risque empirique).
- Le **compromis biais-variance** traduit le compromis entre l'*erreur d'approximation*, correspondant
au *biais* de l'algorithme d'apprentissage, et l'*erreur d'estimation*, correspondant à sa *variance*.
- La **généralisation** et le **sur-apprentissage** sont des préoccupations majeures en machine learning :
comment s'assurer que des modèles entraînés pour minimiser leur erreur de prédiction sur les données observées seront généralisables aux données pour lesquelles il nous intéresse de faire des prédictions ?

##### Références
- Friedman, J. H. (1997). [On bias, variance, 0/1-loss and the curse of dimensionality](azencott_ref/OnBiasVariance.pdf). Data Mining and Knowledge
Discovery, 1 :55–77.


### Chapitre 3. Sélection de modèle et évaluation

##### Points clefs
- Pour *éviter le sur-apprentissage*, il est essentiel lors de l'étape de sélection du modèle de valider les
différents modèles testés sur un jeu de données différent de celui utilisé pour l'entraînement.
- Pour *estimer la performance en généralisation* d'un modèle, il est essentiel de l'évaluer sur des données qui n'ont été utilisées ni pour l'entraînement, ni pour la sélection de ce modèle.
- De nombreux critères permettent d'évaluer la performance prédictive d'un modèle. On les choisira
en fonction de l'application.
- Pour interpréter la performance d'un modèle, il peut être utile de le comparer à une approche naïve.

##### Pour aller plus loin
- Pour certains modèles, en particulier linéaires, il est possible d'estimer l'**optimisme**,
c'est-à-dire la *différence entre l'erreur d'entraînement et l'erreur de test*, de manière théorique,
plutôt que d'utiliser une validation croisée. Dans le cas des modèles linéaires, on pourra notamment
utiliser le coefficient Cp de Mallow, le critère d'information d'Akaike ou le critère d'information bayésien.
Pour plus de détails, on se reportera au livre de Dodge et Rousson (2004).
- La **longueur de description minimale** (ou minimum description length, MDL) est un concept issu de la théorie de l'information qui peut être utilisé pour la sélection de modèle (Rissanen, 1978). Dans ce cadre,
les étiquettes d'un jeu de données D peuvent être représentées par, d'une part une représentation
d'un modèle, et d'autre part une représentation de la différence entre les prédictions du modèle et
leurs vraies étiquettes dans D. *Le meilleur modèle est celui pour lequel la somme des tailles de ces
représentations est minimale* : un bon modèle permet de compresser efficacement les données.

##### Références
- Arlot, S. et Celisse, A. (2010). [**A survey of cross-validation procedures for model selection**](azencott_ref/AsurveyOfCrossValidationProceduresForModelSelection.pdf). *Statistics Surveys*,
4 :40–79.
- Davis, J. et Goadrich, M. (2006). [The relationship between Precision-Recall and ROC curves](azencott_ref/TheRelationshipBetweenPrecision-RecallAndROCcurves.pdf). In *Proceedings
of the 23rd International Conference on Machine Learning*, ICML 06, pages 233–240, New York, NY, USA. ACM.
- Dodge, Y. et Rousson, V. (2004). Analyse de régression appliquée. Dunod.
- Fawcett, T. (2006). [An introduction to ROC analysis](azencott_ref/AnIntroductionToROCanalysis.pdf). *Pattern Recognition Letters*, 27 :861–874.


### Chapitre 4. Inférence bayésienne

##### Points clefs
- La modélisation d'un problème d'apprentissage de manière **probabiliste** se divise en deux tâches :
	1. Un *problème d'inférence*, qui consiste à déterminer la loi de probabilité P(Y = c|X) ;
	2. Une *tâche de prédiction*, qui consiste à appliquer une règle de décision.
- Le raisonnement probabiliste s'appuie sur la **loi de Bayes**
- Généralement, la loi de probabilité P(Y = c|X) est modélisée de manière paramétrique et le problème d'inférence se résout en s'appuyant d'une part sur la loi de Bayes, et d'autre part sur des
estimateurs tels que l'estimateur par maximum de vraisemblance ou l'estimateur de Bayes pour en
déterminer les paramètres.
- La **règle de décision de Bayes**, qui consiste à *minimiser l'espérance de la perte*, contraste avec la règle
de minimisation du risque empirique.

##### Pour aller plus loin
- Nous avons uniquement abordé dans ce chapitre des problèmes de classification. Cependant, la stratégie de minimisation du risque de Bayes s'applique au cas de la régression, en utilisant une fonction
de perte appropriée. Dans ce cadre, les sommations sur y seront remplacées par des intégrales.

##### Références
- Barber, D. (2012). [Bayesian Reasoning and Machine Learning](http://www.cs.ucl.ac.uk/staff/d.barber/brml/). Cambridge University Press. 


### Chapitre 5. Régressions paramétriques

##### Points clefs
- On peut *apprendre les coefficients d'un modèle de régression paramétrique* par **maximisation de
vraisemblance**, ce qui équivaut à *minimiser le risque empirique* en utilisant le coût quadratique
comme fonction de perte, et revient à la méthode des moindres carrés.
- La régression linéaire admet une unique solution β ~ ∗ = X > X
X ~y si et seulement si X > X
est inversible. Dans le cas contraire, il existe une infinité de solutions.
- La **régression polynomiale** se ramène à une régression linéaire.
- Pour un problème de **classification binaire**, utiliser le *coût logistique* comme fonction de perte dans
la minimisation du risque empirique revient à *maximiser la vraisemblance* d'un modèle dans lequel
la probabilité d'appartenir à la classe positive est la transformée logit d'une combinaison linéaire
des variables.
- La **régression logistique** n'a pas de solution analytique, mais on peut utiliser un *algorithme à directions de descente* pour apprendre le modèle.

##### Pour aller plus loin
- La régression logistique peut naturellement être étendue à la **classification multi-classe** en utilisant
l'*entropie croisée comme fonction de coût*.
- Nous avons vu comment construire des modèles polynomiaux en appliquant une transformation polynomiale aux variables d'entrées. Ce n'est pas la seule transformation que l'on puisse leur appliquer,
et l'on peut aussi considérer par exemple des fonctions polynomiales par morceaux (ou *splines*) ou
des ondelettes. Cet ensemble de techniques est connu sous le nom de **basis expansions** en anglais.


### Chapitre 6. Régularisation

##### Points clefs
- Ajouter un **terme de régularisation**, fonction du vecteur des coefficients β,
au risque empirique de la régression linéaire permet d'*éviter le sur-apprentissage*
- La **régression ridge** utilise la norme ` 2 de β ~ comme *régulariseur* ; elle admet toujours une unique
solution analytique, et a un *effet de regroupement* sur les variables corrélées.
- Le **lasso** utilise la norme ` 1 de β ~ comme *régulariseur* ; il crée un *modèle parcimonieux*, et permet
donc d'effectuer une *réduction de dimension supervisée*.
- De nombreux autres régulariseurs sont possibles en fonction de la structure du problème.

##### Pour aller plus loin
- Une famille de régulariseurs appelés "**structurés**" permettent de *sélectionner des variables qui
respectent une structure (graphe, groupes, ou arbre) donnée a priori*. Ces approches sont utilisées
en particulier dans des applications bio-informatiques, par exemple quand on cherche à construire
des modèles parcimonieux basés sur l'expression de gènes sous l'hypothèse que seul un petit nombre
de voies métaboliques (groupes de gènes) est pertinent.

##### Références
- Hastie, T., Tibshirani, R., et Wainwright, M. (2015). [Statistical Learning with Sparsity : The Lasso and Generalizations](http://web.stanford.edu/~hastie/StatLearnSparsity). CRC Press. 
- Huang, J., Zhang, T., et Metaxas, D. (2011). [Learning with structured sparsity](azencott_ref/LearningWithStructuredSparsity.pdf). Journal of Machine Learning
Research, 12 :3371–3412.


### Chapitre 7. Réseaux de neurones artificiels

##### Points clefs
- Le **perceptron** permet d'apprendre des *modèles paramétriques linéaires* et est entraîné par des actualisations itératives de ses poids grâce à un *algorithme à directions de descente*.
- Le **perceptron multi-couche** permet d'apprendre des *modèles paramétriques non linéaires* et offre
une grande flexibilité de modélisation.
- Le perceptron multi-couche est entraîné par **rétropropagation**, qui *combine le théorème de dérivation des fonctions composées avec une mémoïsation* pour une grande efficacité de calcul.
- Le problème d'**optimisation** du perceptron multi-couche et, plus généralement, de tout réseau de
neurones artificiel profond, *n'est pas convexe*, et il n'est pas facile d'obtenir un bon minimum.

##### Pour aller plus loin
- [http://playground.tensorflow.org](http://playground.tensorflow.org) permet de jouer avec l'architecture et l'entraînement d'un
réseau de neurones profond.


### Chapitre 8. Méthode des plus proches voisins

##### Points clefs
- L'**algorithme des k plus proches voisins** a un *entraînement paresseux* ; pour compenser, le coût algorithmique d'une prédiction peut être élevé si la base de données d'entraînement est grande.
- La *qualité des prédictions* d'un algorithme des k plus proches voisins dépend principalement du
choix d'une bonne *distance ou similarité*.
- L'algorithme des k plus proches voisins **fonctionne mieux en faible dimension** :
	- son exécution est plus *rapide* ;
	- il est moins susceptible d'être *biaisé* par des variables qui ne sont pas pertinentes ;
	- il est moins susceptible de souffrir du *fléau de la dimension*.

##### Pour aller plus loin
- Des structures de données telles que les arbres kd (Bentley, 1957) ou l'utilisation de tables de hachage
permettent de stocker le jeu d'entraînement de sorte à retrouver plus facilement les plus proches
voisins. L'idée sous-jacente de ces structures est de regrouper les exemples qui sont proches les uns
des autres.


### Chapitre 9. Arbres et forêts

##### Points clefs
- Les **arbres de décision** sont des modèles interprétables, qui manient naturellement des variables de
plusieurs natures (réelles, discrètes et binaires) et se prêtent aisément à l'apprentissage multi-classe
de distributions multi-modales.
- Les arbres de décision ont le grand inconvénient d'être des *apprenants faibles*, et d'avoir en général
une *capacité de modélisation trop limitée* pour avoir de bonnes performances en pratique.
- Les **méthodes ensemblistes** permettent de remédier aux limitations des apprenants faibles tels que
les arbres de décision, en *combinant ces modèles de sorte à compenser leurs erreurs respectives*.
- Les **méthodes ensemblistes parallèles**, telles que le *bagging* ou les forêts aléatoires, construisent un
*grand nombre de modèles faibles entraînés sur un échantillonage bootstrap des données*.
- Les **forêts aléatoires** entraînent leurs arbres de façon à ce qu'ils soient *indépendants les uns des
autres conditionnelement aux données*, en sélectionnant aléatoirement les variables à considérer à
la création de chaque nœud.
- Les algorithmes de **boosting** *combinent des modèles faibles entraînés séquentiellement* pour donner
*plus d'importance aux exemples d'entraînement sur lesquels les prédictions sont les moins bonnes*.

##### Pour aller plus loin
- Les forêts aléatoires permettent aussi d'établir une *mesure d'importance de chaque variable*, qui se
base sur la *fréquence à laquelle elle est utilisée comme variable séparatrice* parmi tous les arbres
de la forêt. Plus précisément, l'**importance par permutation** mesure la *différence de performance
entre un arbre évalué sur un jeu de test et un arbre évalué sur ce même jeu de test dans lequel on
a permuté aléatoirement les entrées de la j-ème variable* : si cette variable est importante, alors le
deuxième arbre devrait être moins performant. L'autre mesure parfois utilisée, celle de la **diminution
du critère d'impureté**, fait la *somme pondérée de la diminution du critère de Gini pour toutes les
coupures de l'arbre réalisées* selon la variable dont on mesure l'importance.
- L'implémentation la plus connue de GBOOST, au point d'ailleurs d'en devenir synonyme, est l'implémentation **XGBOOST** (Chen et Guestrin, 2016), disponible sur [github](https://github.com/dmlc/
xgboost).

##### Références
- Breiman, L. (1996). [Bagging predictors](azencott_ref/BaggingPredictors.pdf). *Machine Learning*, 26 :123–140.
- Breiman, L. (2001). [Random forests](azencott_ref/RandomForests.pdf). *Machine Learning*, 45(1) :5–32.


### Chapitre 10. Machines à vecteurs de support et méthodes à noyaux

##### Points clefs
- La **SVM à marge souple** est un *algorithme linéaire de classification binaire qui cherche à maximiser
la séparation entre les classes*, formalisée par le concept de **marge**, tout en contrôlant le nombre
d'erreurs de classification sur le jeu d'entraînement.
- L'astuce du **noyau** permet d'appliquer efficacement cet algorithme, ainsi que d'autres algorithmes
linéaires comme la régression ridge, dans un *espace de redescription*, sans calculer explicitement
l'image des observations dans cet espace.
- Les noyaux **quadratique**, **polynomial** et **radial gaussien** permettent d'utiliser des espaces de redescription de dimensions de plus en plus grandes.

##### Pour aller plus loin
- Le site web [http://www.kernel-machines.org](http://www.kernel-machines.org) propose de nombreuses ressources bibliographiques
et logicelles autour des méthodes à noyaux.
- Les SVM ont été *étendues aux problèmes de régression*. Il s'agit alors d'un problème de *régression
linéaire régularisée par une norme ` 2* , mais avec une perte $epsilon$-insensible (voir section 2.4.3) comme
fonction de coût. Elles sont alors parfois appelées SVR pour **Support Vector Regression**. Pour plus de
détails, on pourra se référer au tutoriel de Smola et Schölkopf (1998).
- Une alternative aux solveurs d'optimisation quadratique générique est l'algorithme SMO (Sequential Minimal Optimization). Proposé par John Platt (1998), il a participé à l'engouement pour les SVM
en accélérant leur optimisation. C'est cet algorithme qui est implémentée dans la librairie LibSVM
(Chang et Lin, 2008), qui reste une des plus utilisées pour entraîner les SVM ; scikit-learn ou Shogun,
par exemple, la réutilisent.
- La fonction de décision des SVM ne modélise pas une probabilité. Platt (1999) propose d'apprendre
une fonction sigmoïde qui convertit ces prédictions en probabilité.
- Il est possible d'étendre les SVM afin de modéliser des observations appartenant à une seule et même
classe (sans exemples négatifs). Cette méthode permet ensuite de classifier de nouvelles observations selon qu'elles appartiennent ou non à la classe, et ainsi être utilisées pour détecter des anomalies, autrement dit des observations qui n'appartiennent pas à la classe. Il en existe deux variantes :
celle appelée One-class SVM (Schölkopf et al., 2000), qui sépare les observations de l'origine ; et celle
appelée Support Vector Data Description (Tax et Duin, 2004), qui permet de trouver une frontière sphérique (dans l'espace de redescription, dans le cas de la version à noyau) qui enveloppe de près les
données.
- Pour plus de détails sur les noyaux pour chaînes de caractères et leur utilisation en bioinformatique,
on pourra se référer au chapitre de Saunders et Demco (2007). En ce qui concerne les noyaux pour
graphe, le chapitre 2 de la thèse de Benoît Gaüzère (2013) donne un bon aperçu du domaine.

##### Références
- Burges, C. J. C. (1998). [A tutorial on support vector machines for pattern recognition](azencott_ref/ATutorialOnSupportVectorMachinesForPattern.pdf). *Data Mining and
Knowledge Discovery*, 2 :121–167.
- Smola, A. J. et Schölkopf, B. (1998). [A tutorial on support vector regression](azencott_ref/ATutorialOnSupportVectorRegression.pdf). *NeuroCOLT*, TR-1998-030.
- Vert, J.-P., Tsuda, K., et Schölkopf, B. (2004). A primer on kernel methods. In [*Kernel Methods in Computational Biology*](azencott_ref/KernelMethodsInComputationalBiology.pdf), pages 35–70. MIT Press, Cambridge, MA.


### Chapitre 11. Réduction de dimensions

##### Pour aller plus loin
- Le tutoriel de Shlens (2014) est une introduction détaillée à l'analyse en composantes principales.
- Pour une revue des méthodes de sélection de variables, on pourra se réferer à Guyon et Elisseeff
(2003).
- Pour plus de détails sur la NMF, on pourra par exemple se tourner vers Lee et Seung (1999)
- Pour plus de détails sur les méthodes des sélection de sous-ensemble de variables (wrapper methods), on pourra se référer à l'ouvrage de Miller (1990)
- Une [page web](http://web.mit.edu/cocosci/isomap/isomap.html) est dédiée à Isomap.
- Pour plus de détails sur l'utilisation de t-SNE, on pourra se référer à cette [**page github**](https://lvdmaaten.github.io/tsne) ou à la publication interactive de Wattenberg et al. (2016).

##### Références
- Guyon, I. et Elisseeff, A. (2003). [**An introduction to variable and feature selection**](azencott_ref/AnIntroductionToVariableAndFeatureSelection.pdf). *Journal of Machine Learning
Research*, 3 :1157–1182.
- Hinton, G. E. et Salakhutdinov, R. R. (2006). [**Reducing the dimensionality of data with neural networks**](azencott_ref/ReducingTheDimensionalityOfDataWithNeuralNetworks.pdf).
*Science*, 313 :504–507.
- , D. D. et Seung, H. S. (1999). [**Learning the parts of objects by non-negative matrix factorization**](azencott_ref/LearningThePartsOfObjectsByNon-negativeMatrixFactorization.pdf). *Nature*,
401(6755) :788–791.
- Shlens, J. (2014). [**A Tutorial on Principal Component Analysis**](azencott_ref/ATutorialonPrincipalComponentAnalysis.pdf). arXiv [cs, stat]. arXiv : 1404.1100.
- Tenenbaum, J. B., de Silva, V., et Langford, J. C. (2000). [A global geometric framework for nonlinear dimensionality reduction](azencott_ref/AGlobalGeometricFrameworkforNonlinearDimensionalityReduction.pdf). *Science*, 290(5500) :2319–2323.
- van der Maaten, L. et Hinton, G. (2008). [**Visualizing data using t-SNE**](azencott_ref/VisualizingDatausingt-SNE.pdf). *Journal of Machine Learning Research*,
9 :2579–2605.
- Wattenberg, M., Viégas, F., et Johnson, I. (2016). [**How to use t-SNE effectively**](http://distill.pub/2016/misread-tsne). *Distill*.


### Chapitre 12. Clustering

##### Points clefs
- Le clustering, ou partitionnement de données, cherche à identifier des classes sans utiliser d'étiquettes.
- En l'absence d'étiquette, la qualité d'une partition peut s'évaluer sur des critères de séparabilité et
d'homogénéité.
- Le clustering hiérarchique partitionne les données de manière itérative. Son résultat peut être visualisé sur un dendrogramme.
- Le clustering par la méthode des k-moyennes s'effectue grâce à l'algorithme de Lloyd ou une de ses
variantes. Il permet de trouver efficacement K clusters convexes.
- La version à noyau de la méthode des k-moyennes permet de l'appliquer pour découvrir des clusters
non convexes.
- Le clustering par densité permet d'identifier des régions denses du jeu de données, c'est-à-dire
des observations qui peuvent former un ensemble non convexe mais qui sont proches les unes des
autres.

##### Pour aller plus loin
- Les algorithmes de partitionnement que nous avons vus associent un seul et unique cluster à chaque
observation. Il existe des variantes, appelées partitionnement flou, ou fuzzy clustering en anglais, qui
associent à chaque observation et chaque cluster la probabilité que cette observation appartienne à
ce cluster.
- L'ouvrage de Jain et Dubes (1988) constitue une bonne introduction au clustering. On pourra aussi
se reporter à l'article de Xu et Wunsch II (2005)

##### Références
- Xu, R. and Wunsch II, D. (2005). [Survey of clustering algorithms](azencott_ref/SurveyOfClusteringAlgorithms.pdf). IEEE Transactions on Neural Networks, 16 :645–
678.



