#==============================================
#============================================== EXERCICE 1
#==============================================

# 1. Create randomly 150 points of 300 dimensions out of a normal distribution with a mean value of 100 and a sd of 10 

data <- matrix(rnorm(n = 45000, mean=100, sd=10), ncol = 300)
# 2. Calculate the Euclidian and City blocks distance between these points 


euclidDist <- dist(data, method="euclidean")
cityDist <- dist(data, method="manhattan")


mat_euclidDist <- as.matrix(dist(data, method="euclidean"))
mat_cityDist <- as.matrix(dist(data, method="manhattan"))

# 3. Plot the heatmaps for Euclidian and City blocks distance 

heatmap(mat_euclidDist, Colv=NA, Rowv=NA, scale="none") 
heatmap(mat_cityDist, Colv=NA, Rowv=NA, scale="none") 

# 4. Cluster each of the distance matrices using hierarchical clustering (hclust) model using complete agglomeration method and plot the dendorgam
hclust_euclidDist <- hclust(euclidDist, method="complete")
hclust_cityDist <- hclust(cityDist, method="complete")

# 5. Plot the clusters dendogram
plot(hclust_euclidDist)
plot(hclust_cityDist)

# 6. Repeat 4 and 5 by changing the agglomeration method. Use centroid and median methods. 
hclust_euclidDist_centroid <- hclust(euclidDist, method="centroid")
hclust_cityDist_centroid <- hclust(cityDist, method="centroid")
plot(hclust_euclidDist_centroid)
plot(hclust_cityDist_centroid)
hclust_euclidDist_median <- hclust(euclidDist, method="median")
hclust_cityDist_median <- hclust(cityDist, method="median")
plot(hclust_euclidDist_median)
plot(hclust_cityDist_median)


# 7. Use the heatmap function by allowing it to automatically classify the data points 
heatmap(mat_cityDist,scale="none") 

# 8. Can we change the agglomeration method in heatmap call? 
heatmap(mat_cityDist,
        hclustfun = function(x) hclust(x, method="centroid"),
        scale="none") 


# hclust on large dataset: use kmeans as intermediate step !
x <- rbind(matrix(rnorm(70000, sd = 0.3), ncol = 2),            
           matrix(rnorm(70000, mean = 1, sd = 0.3),  ncol = 2)) 
colnames(x) <- c("x", "y") 
cl <- kmeans(x, 1000, iter.max=20) 
cah <- hclust(cl$centers, graph=FALSE, nb.clust=-1) 
cah <- hclust(cl$centers, nb.clust=-1)

# mat <- matrix(data = rnorm(300, mean= 100, sd=10),  nrow = 150,  ncol = 2)
# df<-data.frame(x) 
# cl.1 <- kmeans(df, 3, iter.max = 1) 
# plot(df, col = cl.1$cluster) 
# points(cl.1$centers, col = 1:5, pch = 8)

rxKmeans(as.formula(paste0("~", paste(names(DF), collapse="+")), data = XDF, numClusters=3, maxIterations=100))

#==============================================
#============================================== EXERCICE 2
#==============================================

# 1.Import the data from dataClustering.csv
inputFileData <- paste0("dataClustering.csv") 
clustering_DT <- read.delim(inputFileData,sep=",")

# 2.What is the dimension of this dataset? 
dim(clustering_data)
# 46x5

# 3.How many data point do we have? 


# 4.Evaluate Euclidian distance of points in a plates 
distMat <- dist(rbind(clustering_DT$Coord_X, clustering_DT$Coord_Y))


# 5.Classify point to find clusters using hierarchical clustering and the average agglomeration method 
km_data <- rxKmeans(~ Coord_X + Coord_Y, data = clustering_data, numClusters = 3, maxIterations=100)




#run kmeans
z<-rxKmeans(~ Coord_X + Coord_Y, data = clustering_data, numClusters = 3, maxIterations=100)
#plot outcome 
DF <- data.frame(clustering_data$Coord_X,clustering_data$Coord_Y)   

plot(DF, col = z$cluster) points(z$centers, col = 1:5, pch = 8) 


# 6. We expect to have 3 clusters.
# When you apply k-means algorithm using 1 iteration, does it differ from applying it using 10 or 100 iterations? 

# 7. Repeat question 6 Using k-means implemented in RevolScaleR



# 8. What is the outcome of the C-means clustering? 
library(e1071) 
?cmeans


#==============================================
#============================================== EXERCICE 2 RevoScale
#============================================== 


# 1.Import the data from dataClustering.csv
inputFileData <- paste0("dataClustering.csv") 
clustering_data<- rxImport(inData = inputFileData) 
clustering_DT <- read.delim(inputFileData,sep=",")

# 2.What is the dimension of this dataset? 
dim(clustering_data)
# 46x5

# 3.How many data point do we have? 


# 4.Evaluate Euclidian distance of points in a plates 
distMat <- dist(rbind(clustering_DT$Coord_X, clustering_DT$Coord_Y))


# 5.Classify point to find clusters using hierarchical clustering and the average agglomeration method 
km_data <- rxKmeans(~ Coord_X + Coord_Y, data = clustering_data, numClusters = 3, maxIterations=100)

#plot outcome 
plot_DF <- data.frame(clustering_data$Coord_X,clustering_data$Coord_Y)   

plot(plot_DF, col = km_data$cluster) 
points(km_data$centers, col = 1:5, pch = 8) 


# 6. We expect to have 3 clusters.
# When you apply k-means algorithm using 1 iteration, does it differ from applying it using 10 or 100 iterations? 

# 7. Repeat question 6 Using k-means implemented in RevolScaleR



# 8. What is the outcome of the C-means clustering? 
library(e1071) 
?cmeans


#==============================================
#============================================== dimensionality reduction - PCA
#============================================== 

library(MASS) 
data(iris) 
iris_data <- iris
iris_data$Species <- NULL
pca<-prcomp(iris_data, center = TRUE, scale. = FALSE) 
#coordinate of sample on components were identified 

#Importance of components 
summary(pca) 

pca$x
plot(pca$x) 


#==============================================
#============================================== dimensionality reduction - LDA
#============================================== 

library(MASS) 
data(iris) 
head(iris, 3) 
train <- sample(1:150, 75) 
r <- lda(formula = Species ~ ., data = iris,
         prior = c(1,1,1)/3, subset = train) 

r$prior

r$counts    #means for each covariate 

r$means     #with 3 classes we have at most two linear discriminants

r$scaling   #the singular values (svd) that gives the ratio of the between-  and within-group standard deviations on the linear discriminant  variables. r$svd# amount of the between-group variance that is explained by each  linear discriminant 


prop = r$svd^2/sum(r$svd^2) 
head(r2$class) 
head(r2$posterior, 3) 
plda = predict(object = r, newdata = iris[-train, ]) 


#==============================================
#============================================== explore brfss data
#============================================== 
# https://www.cdc.gov/brfss/annual_data/2013/pdf/2013_calculated_variables_version15.pdf
library(SASxport)
brfss <- read.xport("LLCP2013.XPT")
head(brfss)
dim(brfss) # 491773 rows, 336 columns

brfss <- brfss[1:100,c("WEIGHT2","HEIGHT3","FRUITJU1","FRUIT1","FVBEANS","FVGREEN","FVORANG","VEGETAB1")]


# hclust on large dataset: use kmeans as intermediate step !
cl <- kmeans(brfss, 1000, iter.max=20) 
# cah <- hclust(cl$centers, graph=FALSE, nb.clust=-1) 
# cah <- hclust(cl$centers, nb.clust=-1)
cah <- hclust(dist(cl$centers))

# mat <- matrix(data = rnorm(300, mean= 100, sd=10),  nrow = 150,  ncol = 2)
euclidDist <- dist(brfss, method="euclidean")
mat_euclidDist <- as.matrix(dist(brfss, method="euclidean"))
heatmap(mat_euclidDist, Colv=NA, Rowv=NA, scale="none") 
hclust_euclidDist <- hclust(euclidDist, method="complete")

# PCA
pca_brfss <- prcomp(brfss, center = TRUE, scale = FALSE) 
#coordinate of sample on components were identified 

#Importance of components 
summary(pca_brfss) 

pca_brfss$x
plot(pca_brfss$x) 



