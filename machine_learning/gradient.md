## Gradient

<style>body {text-align: justify}</style>

##### *(source: Data Science par la pratique - Grus)*

le gradient = vecteur des dérivées partielles

le gradient donne la direction vers laquelle la fonction augmente le plus rapidement

une méthode pour maximiser une fonction consiste à prendre un point au hasard, calculer le gradient, appliquer un petit déplacement dans la 
direction du gradient (i.e. la direction qui correspond à l'augmentation la plus importante) puis répéter le processus à partir de ce nouveau point de départ

de la même manière, il est possible de minimiser une fonction en effectuant de petits déplacements dans la direction opposée

quand une fonction a plusieurs variables, elle a plusieurs dérivées partielles, chacune indiquant comment la fonction change quand nous procédons
à des petites modifications dans une seule des variables d'entrée

utiliser la descente de gradient pour choisir les paramètres d'un modèle de manière à minimiser une forme d'erreur

en général les fonctions d'erreur sont additives (l'erreur d'ensemble prévue sur l'ensemble des données est la somme des erreurs prévues pour chaque donnée élémentaire); 
quand c'est le cas on peut appliquer une technique dite "**descente du gradient stochastique**" qui revient à calculer le gradient (et à se déplacer d'un pas) pour un point à la fois;
le traitement boucle sur les données jusqu'à ce qu'il atteigne un point d'arrêt

approche batch: prévision et calcul du gradient sur l'ensemble des données; la version stochastique est souvent beaucoup plus rapide

hors-sujet:
* si un neurone à un biais négatif important, cela signifie qu'il ne se déclenchera pas fortement à moins  de recevoir précisément les entrées positives "attendues"
* MapReduce est un modèle de programmation destiné aux traitements parallèles sur de grands jeux de données; version de base de l'algorithme MapReduce
1. utiliser une fonction de correspondance (*mapper*) pour transformer chaque élément en zéro ou plus de paires clé-valeur
2. collecter toutes les paires ayant des clés identiques
3. utiliser une fonction de réduction (*reudcer*) sur chaque collection de valeurs groupées pour produire des valeurs pour la clé correspondante

le premier avantage de MapReduce est qu'il permet de distribuer les calculs en déplaçant le traitement vers les données

le système MapReduce le plus largement utilisé est Hadoop
