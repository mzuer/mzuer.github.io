## The bias-variance trade-off

<style>body {text-align: justify}</style>

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

##### *(source: Introduction au machine learning - Azencott)*

On peut décomposer l'erreur entre un terme qui découle de la *qualité de l'espace
des hypothèses* et un autre qui découle de la *qualité de la procédure d'optimisation* utilisée. En pratique,
sauf dans des cas très particuliers où cela est rendu possible par construction, il n'est pas possible de calculer ces termes d'erreur. 

Cependant, cette écriture nous permet de comprendre le problème suivant : 
- choisir un *espace des hypothèses plus large* permet généralement de *réduire l'erreur d'approximation*, car un modèle plus proche de la réalité a plus de chances de se trouver dans cet espace. 
- puisque cet espace est plus vaste, la *solution optimale y est aussi généralement plus difficile à trouver* : l'*erreur d'estimation augmente*. C'est dans ce cas qu'il y a sur-apprentissage.


Un espace des hypothèses plus large permet généralement de construire des modèles plus complexes :
par exemple, l'ensemble des droites vs. l'ensemble des polynômes de degré 9. C'est une
variante du principe du rasoir d'Ockham, selon lequel les hypothèses les plus simples sont les plus vraisemblables.

Il y a donc un *compromis entre erreur d'approximation et erreur d'estimation* : il est difficile de réduire l'une sans augmenter l'autre. Ce compromis est généralement appelé **compromis biais-variance** : l'erreur d'approximation correspond au biais de la procédure d'apprentissage, tandis que l'erreur d'estimation correspond à sa variance.

Plus un modèle est simple, et moins il a de chances de sur-apprendre. Pour limiter le risque de sur-
apprentissage, il est donc souhaitable de limiter la complexité d’un modèle. C’est ce que permet de faire la
**régularisation**, qui consiste à *ajouter au terme d’erreur que l’on cherche à minimiser un terme qui mesure
la complexité du problème* (par exemple, le degré du polynôme ou le nombre de
coefficients du modèle). Ainsi, un modèle complexe qui a une erreur empirique faible peut être défavorisé
face à une modèle plus simple, même si celui-ci présente une erreur empirique plus élevée.
