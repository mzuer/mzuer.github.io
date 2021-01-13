## Text processing

<style>body {text-align: justify}</style>

##### *(source: Data Science par la pratique - Grus)*

**modèle bigramme**: maintenant que nous avons le texte sous forme d'une séquence de mots, nous pouvons modéliser le langage ainsi: à partir d'un mot de départ, regarder tous les mots qui le suivent dans le document; choisir un de ces mots au hasard pour être le mot suivant et répéter ce processus jusqu'à ce qu'on rencontre un point (indique la fin de la phrase); pour le point de départ on peut prendre au hasard parmi les mots qui suivent un point.

**modèle n-grammes**: prendre *n* mots consécutifs

une approche différente de la modélisation de la langue consiste à utiliser des **grammaires**, autrement dit des règles pour générer des phrases acceptables
