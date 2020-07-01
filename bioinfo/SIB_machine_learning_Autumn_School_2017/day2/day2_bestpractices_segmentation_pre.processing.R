## Within this file we would cover :
## boxplots, PCA, clustering, svm, and the kernel trick
library(caret)

#===================================================
# Load the dataset
#===================================================
data(segmentationData)

#===================================================
# QC #1 : look at your data
#===================================================
View(segmentationData)

## In principle the first thing to do is to put away the 
## test set to prevent any temptation
# (already labeled for Test and Train data)
test.idx = which(segmentationData[,"Case"] == "Test")
test.set = segmentationData[test.idx,]

segmentationData = segmentationData[-test.idx,]

cell.info = segmentationData[,1:3]
cell.data = segmentationData[,-(1:3)]
boxplot(cell.data[,2:5])
cell.data.scale = scale(cell.data)
boxplot(cell.data.scale[,2:5])
# => all the numerics have a different distributions and are at different scale
# => scale them so that they are centered on 0 with sd 1


# !! scaling should be done within the cross-validation
# should be scaled otherwise the coefficients won't be on the same scale
# coefficients are expected to have the same distribution
# but can be really a problem, e.g. in breast cancer, 
# if new data are on really different scale -> this would impact the result

#===================================================
# QC #2: PCA
#===================================================

# things that you can do before starting machine learning

pca = prcomp(cell.data.scale)

## Display the first principal components
plot(pca$x[,c("PC1","PC2")],col=c(rgb(1,0,0,.1),rgb(0,0,1,.1))[factor(cell.info$Class)],pch=19)

# => PC1 is good tosegment the poor (PS) from well (WS) segmented 
# (red and blue clouds well separated), you can see it with boxplot

## look at association with first component
boxplot(pca$x[,"PC1"] ~ cell.info$Class) 
# => PC1 already good for separating the PS and WS
# statistical test to validate that PC1 is associated with the Class
wilcox.test(pca$x[,"PC1"] ~ cell.info$Class)

# we want to know which variable is associated to PC1
# pca$rotation => which variable is strongly associated to the PC1

## Which variables are strongly associated to PC1?
par(mar=c(12,5,4,4))
barplot(sort(pca$rotation[,"PC1"]),las=2)

boxplot(cell.data$FiberLengthCh1 ~ cell.info$Class)
boxplot(cell.data$ConvexHullPerimRatioCh1 ~ cell.info$Class)

barplot(sort(pca$rotation[,"PC2"]),las=2)

## Association of PCs with our classes
# => find which principal component is most strongly associated with the variable you want to predict
# !!! good to look at, but do not select one PC here because it would be cheating !!!
# if we know they are meaningless and never include again, we can discard features if we have a good reason to do so
wt.pv = as.numeric(lapply(1:ncol(pca$x),function(i){
  wilcox.test(pca$x[,i] ~ cell.info$Class)$p.value
}))

names(wt.pv) = as.character(1:length(wt.pv))
barplot(sort(-log10(wt.pv)),las=2)

## Good to build your model on PCA transformed data?
## Generalization?

#===================================================
# QC #3: Clustering Heatmaps
#===================================================

plot(hclust(dist(t(cell.data.scale))))
# => lot of correlated features
# good place to use the lasso

plot(hclust(dist(t(pca$x))))
# features are orthogonal -> distant from each other
# => break the correlation structure with the PCA

# want to use correlation
plot(hclust(as.dist(1 - cor(cell.data.scale))))
#?? Do you see any problem?

## pvclust
## http://stat.sys.i.kyoto-u.ac.jp/prog/pvclust/
require(pvclust)
pvc = pvclust(cell.data.scale)
pvrect(pvc, alpha=0.95)

## Silhouette
require(cluster)
pam.5 = pam(as.dist(1 - cor(cell.data.scale)),5)
si.p.5 = silhouette(pam.5)
plot(si.p.5)
# done on the features
# 5 different groups of features
# e.g. group 2: this cluster is robust, strongly correlated to one another
# and not correlated to members from other clusters
# useful for comparing the different number of classes you are using for the clustering
# compare mean distance to members of the same class vs. distance to members from different class

## Heatmap
require(gplots)
## never use the scale function
heatmap.2(cell.data.scale[sample(1:2019,50),],trace="none",col=colorpanel(50,"blue","white","red"))

#===================================================
# QC #4 : Kernel trick
#===================================================
### without cross-validation, just to show the kernel trick here
# => there is a way to improve the model by transforming the data

# SVM: simple idea of finding a line between 2 groups
# maximize the distance between the points that are on the boundaries
# try to find hyperplane
# how do you set the line ? trick draw line (hyperplane) far away 
# maximizing boundaries between the groups so that it gets
# randomForest, SVM radial -> good models to try first 

# data with complicated structure
# clearly not linear

kt.data = read.delim("kernel.trick.data.txt",header=T,sep="\t",stringsAsFactors = F)
plot(kt.data[,2],kt.data[,3],col=factor(kt.data[,1]),pch=19)

# Test the boundaries
require(e1071)

grid.xy = expand.grid(x=seq(0,1,length=50),y=seq(0.4,1,length=50))

# Linear
svm.model.linear = svm(kt.data[,2:3],kt.data[,1],kernel="linear")

# 3 plot the decision boundaries
# circles are the data
# decision boundaries of the SVM (SVM draws a line; SVM linear find linear boundaries between the 2 classes)
# with the linear SVM -> not able to segregate the 2 distributions
# linear SVM: hyperplane between the 2 classes
plot(grid.xy[,1],grid.xy[,2],pch=19,cex=.3,col=c("blue","orange")[match(sign(predict(svm.model.linear,grid.xy)),c(-1,1))])
points(kt.data[,2],kt.data[,3],pch=1,cex=1,col=c("blue","orange")[match(kt.data[,1],c(-1,1))])

# Radial
svm.model.radial = svm(kt.data[,2:3],kt.data[,1],method="radial")

# decision boundaries are not linear anymore
# clearly increase the performance

plot(grid.xy[,1],grid.xy[,2],pch=19,cex=.3,col=c("blue","orange")[match(sign(predict(svm.model.radial,grid.xy)),c(-1,1))])
points(kt.data[,2],kt.data[,3],pch=1,cex=1,col=c("blue","orange")[match(kt.data[,1],c(-1,1))])

# hyperparameter gamma: 
# with very high values (1000) -> stick close to datasets (will be bad in cross-validation)
# broader with 100
# gamma controls what is the space you are covering with the kernel
# hyperparamneter that has to be trained
# => hyperparameter that would be tuned with cross-validation
# (test the different values of gamma during cross-validation)

# play with gamma
svm.model.radial = svm(kt.data[,2:3],kt.data[,1],method="radial",gamma=1000)

plot(grid.xy[,1],grid.xy[,2],pch=19,cex=.3,col=c("blue","orange")[match(sign(predict(svm.model.radial,grid.xy)),c(-1,1))])
points(kt.data[,2],kt.data[,3],pch=1,cex=1,col=c("blue","orange")[match(kt.data[,1],c(-1,1))])


#===================================================
# try ML 
#===================================================



