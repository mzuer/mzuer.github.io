
############################ CROSS VALIDATION - DEEP LEARNING - Patterson Gibson


Cross-validation (also called rotation estimation) is a method to estimate howwell a model generalizes on a training dataset. In cross-validation we split thetraining dataset into N number of splits and then separate the splits into trainingand test groups. We train on the training group of splits and then test the modelon the test group of splits. We rotate the splits between the two groups manytimes until we’ve exhausted all the variations. There is no hard number for thenumber of splits to use but researchers have found 10 splits to work well inpractice. It also is common to see a separate portion of the held-out data used asa validation dataset during training
