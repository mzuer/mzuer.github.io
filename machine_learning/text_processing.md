## Text processing

<style>body {text-align: justify}</style>

##### *(source: Data Science par la pratique - Grus)*

**modèle bigramme**: maintenant que nous avons le texte sous forme d'une séquence de mots, nous pouvons modéliser le langage ainsi: à partir d'un mot de départ, regarder tous les mots qui le suivent dans le document; choisir un de ces mots au hasard pour être le mot suivant et répéter ce processus jusqu'à ce qu'on rencontre un point (indique la fin de la phrase); pour le point de départ on peut prendre au hasard parmi les mots qui suivent un point.

**modèle n-grammes**: prendre *n* mots consécutifs

une approche différente de la modélisation de la langue consiste à utiliser des **grammaires**, autrement dit des règles pour générer des phrases acceptables


##### *(source: A survey on text classification: from shallow to deep learning - Li et al. 2020)*

shallow learning models = statistics-based models

deep learning models = no need to design rules or feature engineering


text representation aims to express preprocessed text in a form that is much easier for computers and minimize information loss

Bag-of-words (BOW): represent each text with a dictionary-sized vector; the individual value of the vector denotes the word frequency corresponding to its inherent position in the text

N-gram: consider the information of adjacent words and build a dictionary by considering the adjacent words

Term frequency-inverse document frequency (TF-IDF): use the word frequency and inverse the document frequency to model the text

word2vec: employ local context information to obtain word vectors

GloVe: with both local context and global statistical features, train on the nonzero elements in a word-word co-occurrence matrix

shallow learning models for text classification:

1) probabilistic graphical models (PGM)
- naïve bayes, HMM
2) K-nearest neighbors (KNN)-based methods
3) SVM-based methods
4) decision tree (DT)-based methods
5) integration-based methods

deep learning models for text classification
1) recursive neural network (ReNN)-based methods
2) multilayer perceptron (MP)-based methods
3) recurrent neural network (RNN)-based methods
4) convolutional neural network (CNN)-based methods
5) attention-based methods
6) transformer-based methods
7) graph neural network (GNN)-based methods
8) others: Siamese neural network, virtual adversarial training, reinforcement learning, memory networks, QA style, external commonsense knowledge, quantum language model

###### shallow models

PGMs express the conditional dependencies among features in graphs

NB: assumption that features are independent; uses the prior probability to calculate the posterior probability

HMM: Markov model with hidden states; suitable for sequential text data; assumption that a separate process Y exists, and its behavior depends upon X; goal is to learn about X by observing Y, considering state dependencies

KNN: classify unlabeled sample by finding the category with most samples on the k-nearest labeled samples

SVM: turns text classification into multiple binary classification tasks; SVM constructs an optimal hyperplane in the 1D input space or feature space, maximizing the distance between the hyperplane and the 2 categories of training sets, thereby achieving the best generalization ability; the goal is to make the distance of the category boundary along the direction perpendicular to the hyperplane is the largest (lowest error rate of classification); key is to choose the appropriate kernel function

DT: supervised tree structure learning method (leaf node represents a category) - reflective of the idea of divide-and-conquer, constructed recursively; learns disjunctive expression and robust to text with noise; 2 stages: tree construction and tree pruning; inefficient in coping with explosively increasing data size

integrated algorithms aim to aggregate the results of multiple algorithms
- bootstrap (e.g. random forests (RF)) = train multiple classifiers without strong dependencies and then aggregate the results
- boosting (e.g. AdaBoost) = all labeled data are trained with the same weight to initially obtain a weaker classifier; the weights of the data are then adjusted according to the former result of the classifier; continue by repeating such steps until the termination condition is reached
- stacking = unlike bootstrap and boosting, break down data into *n* parts and use *n* classifiers to calculate input data in a cascade manner; result from upstream classifier feed into downstream classifier as input; terminate once a predefined iteration number is targeted

RF = multiple tree classifiers wherein all trees depend on the value of the random vector sampled independently; each tree within RF shares the same distribution; generalization error of an RF relies on the strength of each tree and the relationship among trees and will converge to a limit with the increment of tree number in the forest

###### deep models

bi-directional encoder representations from transformers (BERT): can generate contextualized word vectors; turning point in NLP and text classification

ReNN: can automatically learn the semantics of text recursively and the syntax tree structure without feature design; each word of input text is taken as the leaf node of the model structure; then all nodes are combined into parent nodes using a weight matrix; the weight matrix is shared across the whole model; each parent node has the same dimension with all leaf nodes; finally all nodes are recursively aggregated into a parent node to represent the input text and predict the label 

MLP: (aka. vanilla NN) simple NN structure used for capturing features automatically; contains an input layer, a hidden layer with an activation function in all nodes, and an output layer; each node connects with a certain weight; treats input text as a bag of words

RNN: broadly used due to capturing long-range dependency through recurrent computation; learns historical information considering the location information allong all words suitable for text classification tasks; each input word is represented by a specific vector using a word embedding technology; the output of RNN cells are the same dimension with the input vector and are fed into the next hidden layer; the RNN shares parameters across different parts of the model and has the same weights of each input word; finally, the label of input text can be predicted by the last output of the hidden layer

LSTM: in backpropagation process of RNN the weights are adjusted by gradients (calculated by continuous multiplication of derivatives); gradient vanishing problem if derivatives are extremely small; alleviate by LSTM, improvement of RNN; composed of a cell to remember values on arbitrary time intervals and 3 gate structures to control information flow (input/forget/update gates); can better capture connection among context feature words; use the forgotten gate structure to filter useless information (improve the total capture ability)

CNN: can simultaneously apply convolutions defined by different kernels to multiple chunks of a sequence; the text requires being represented as a vector similar to the image representation; text features can be filtered from multiple angles; firstly, word vectors spliced into a matrix; matrix fed into the convolutional layer which contains several filters with different dimensions; finally result of convolutional layer through pooling layer and concatenates pooling result to obtain final vector representation of the text; category predicted by the final vector

embedding methods are divided into 
- character-level; 
- word-level: learn the syntax and semantics of the words;
- sentence-level embedding: can capture relationships among sentences

RNN-based models capture the sequential information to learn the dependency among input words; CNN-based models extract relevant features from the convolution kernels; some works study the fusion of the 2 methods

CNN and RNN: poor interpratibility, classification errors cannot be explained due to non-readability of the hidden data

attention mechanism lets the model pay different attention to specific inputs; it aggregates essential words into sentence vectors firstly and then aggregates vital sentence vectors into text vectors; can learn how much contribution of each word and sentence for the classification judgement; can improve the performance with interpretability

self-attention captures the weight distribution of words in sentences by constructing K, Q and V matrices among sentences that can capture long-range dependencies on text classification

transformer-based methods: pre-trained language models effectively learn global semantic representation and significantly boost NLP tasks; generally uses unsupervised methods to mine semantic knowledge automatically and then construct pre-training targets so that machines can learn to understand semantics; transformer-based models can parallelize computation without considering the sequential information suitable for large-scale datasets, making it popular for NLP tasks

DNN models like CNN get great performance on regular structure, not for arbitrarily structured graphs

GNN: excellent performance by encoding syntactic structure of sentences; turns text classification into a graph node classification task; the weight of each word-word edge usually means their co-occurrence frequency in the corpus; then the words and texts are represented through the hidden layer; finally the label of all input texts can be predicted by the graph; GNN 

graph attention networks (GAT) employ masked self-attention layers by attending over its neighbors

siamese neural network (aka. twin NN) utilizes equal weights while working in tandem using 2 distinct input vectors to calculate comparable output vectors

virtual adversarial training (VAT): VAT regularization based on local distributional smoothness can be used in semi-supervised tasks, only requires small number of hyperparameters and can be interpreted directly as robust optimization

reinforcement learning (RL) learns the best action in a given environment through maximizing cumulative rewards

memory networks learn to combine the inference component and the long-term memory component

QA style for the sentiment classification task is an attempt to treat sentiment classification as a QA task

quantum language model: words and dependencies among words are represented through fondamental quantum events; by inputting density matrices to the embedding layer, the performance of the model improves
