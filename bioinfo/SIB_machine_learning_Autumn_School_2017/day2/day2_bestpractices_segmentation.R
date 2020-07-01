## Within this file we would cover :
## boxplotsm, PCA, clustering, svm, and the kernel trick
library(caret)

#===================================================
# Load the dataset
#===================================================
data(segmentationData)

#===================================================
# try ML on segmentation data
#===================================================
View(segmentationData)

segmentationData_DT <- segmentationData[,-c(1:2)]
any(is.na(segmentationData_DT))
segmentationData_DT[,-1] <- scale(segmentationData_DT[,-1])

# [1] "Class"                   "AngleCh1"                "AreaCh1"                 "AvgIntenCh1"            
# [5] "AvgIntenCh2"             "AvgIntenCh3"             "AvgIntenCh4"             "ConvexHullAreaRatioCh1" 
# [9] "ConvexHullPerimRatioCh1" "DiffIntenDensityCh1"     "DiffIntenDensityCh3"     "DiffIntenDensityCh4"    
# [13] "EntropyIntenCh1"         "EntropyIntenCh3"         "EntropyIntenCh4"         "EqCircDiamCh1"          
# [17] "EqEllipseLWRCh1"         "EqEllipseOblateVolCh1"   "EqEllipseProlateVolCh1"  "EqSphereAreaCh1"        
# [21] "EqSphereVolCh1"          "FiberAlign2Ch3"          "FiberAlign2Ch4"          "FiberLengthCh1"         
# [25] "FiberWidthCh1"           "IntenCoocASMCh3"         "IntenCoocASMCh4"         "IntenCoocContrastCh3"   
# [29] "IntenCoocContrastCh4"    "IntenCoocEntropyCh3"     "IntenCoocEntropyCh4"     "IntenCoocMaxCh3"        
# [33] "IntenCoocMaxCh4"         "KurtIntenCh1"            "KurtIntenCh3"            "KurtIntenCh4"           
# [37] "LengthCh1"               "NeighborAvgDistCh1"      "NeighborMinDistCh1"      "NeighborVarDistCh1"     
# [41] "PerimCh1"                "ShapeBFRCh1"             "ShapeLWRCh1"             "ShapeP2ACh1"            
# [45] "SkewIntenCh1"            "SkewIntenCh3"            "SkewIntenCh4"            "SpotFiberCountCh3"      
# [49] "SpotFiberCountCh4"       "TotalIntenCh1"           "TotalIntenCh2"           "TotalIntenCh3"          
# [53] "TotalIntenCh4"           "VarIntenCh1"             "VarIntenCh3"             "VarIntenCh4"            
# [57] "WidthCh1"                "XCentroid"               "YCentroid"        

require(reshape2)
segmentationData_DT_m <- melt(segmentationData_DT)
bwplot( value ~ Class | variable,data = segmentationData_DT_m, scales="free")


# ================================================================================
# Split data
#=================================================================================

# create 70%/30% split of the training data
# also within cross-validation, it is important to keep the same proprotions !!!
indexes <- createDataPartition(segmentationData_DT$Class,
                               times = 1,
                               p = 0.7,
                               list=FALSE)

length(indexes)
# indexes of the passengers we want in the training set

segm.train <- segmentationData_DT[indexes,]
segm.test <- segmentationData_DT[-indexes,]

# the proportions are conserved
prop.table(table(segmentationData_DT$Class))
prop.table(table(segm.train$Class))
prop.table(table(segm.test$Class))


#=================================================================================================
# Split data
#=================================================================================================

# 3 times 10-fold CV => you test 30x the accuracy of your model
# (you get an estimate of the performance of your model)

train.control <- trainControl(method = "repeatedcv", 
                              number = 10,
                              repeats=3
)


### ALL THE MODELS
names(getModelInfo())
# see: topepo.github.io/caret/available-models.html
# some algorithms good for both classification and regression
# some are better for one than for the other

caret.cv.knn <- train(Class ~ .,
                      data = segm.train,
                      method = "knn",
                      trControl = train.control,
                      tuneLength = 10
)


caret.cv.svm <- train(Class ~ ., 
                      data = segm.train,
                      method = "svmLinear",
                      trControl = train.control)

caret.cv.svmradial <- train(Class ~ ., 
                            data = segm.train,
                            method = "svmRadial",
                            trControl = train.control)

caret.cv.rf <- train(Class ~ ., 
                            data = segm.train,
                            method = "rf",
                            trControl = train.control)



varimp_knn <- varImp(caret.cv.knn)$importance

varimp_svmrad <- varImp(caret.cv.svmradial)$importance







xx <- data.frame(x=c(1,2,3), y =c(4,5,6))
rownames(xx) <- c("aa", "bb", "cc")
yy <- data.frame(x=c(7,8,9), y =c(10,11,12))
rownames(yy) <- c("bb", "cc", "aa")

cbind(xx, yy[match(rownames(xx), rownames(yy)),])



cbind(xx, yy)
train <- train[, features]
str(train)





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
