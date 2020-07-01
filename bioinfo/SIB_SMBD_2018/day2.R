#*********************************************
# using R
#*********************************************
class_data <- read.table("http://lausanne.isb-sib.ch/~schutz/data/class.txt") 

cor.test(class_data$Height, class_data$Age)
plot(Height~Age, data = class_data)
plot(density(class_data$Height))
plot(density(class_data$Age))

#call lm 
lm_class<-lm( Height~Age,  data =class_data) 

#summary of lmoutput
summary(lm_class) 

# 
lm_gender <- lm(Height~Age+Gender,  data =class_data) 
summary(lm_gender)
                                                                     
                                                                     
#*********************************************
# using RevoScale
#*********************************************

dataFile <- "http://lausanne.isb-sib.ch/~schutz/data/class.txt"

#Import the  data. 
class_data <- rxImport(inData = dataFile) 

rxCor(formula=~Height+Age,  data = class_data[,4:5],  reportProgress = 0) 

rxCor(formula = ~Height+Age, data = class_data, reportProgress=0)

plot(Height~Age, data = class_data)

plot(density(class_data$Height))

plot(density(class_data$Age))

#call lm 
lm_class<-rxLinMod( formula= Height~Age,  data =class_data[,-1]) 

#summary of lmoutput
summary(lm_class) 

# 
recodedDF2 <- rxFactors(inData= class_data, sortLevels = TRUE, factorInfo = c("Gender"))    
rxGetVarInfo(recodedDF2) 
lm_class_gender <- rxLinMod( formula= Height~Age+Gender,  data =recodedDF2)
summary(lm_class_gender) 


#*********************************************
# using RevoScale - cheese dataset
#*********************************************

# GGall::ggpairs

dataFile <- "cheese.txt"
cheese_data <- rxImport(inData = dataFile) 

rxCor(formula=~Acetic+Lactic+H2S+taste,  data = cheese_data,  reportProgress = 0) 

plot(cheese_data$Acetic ~ cheese_data$taste)
plot(cheese_data$Lactic ~ cheese_data$taste)
plot(cheese_data$H2S ~ cheese_data$taste)

plot(density(cheese_data$Acetic))
plot(density(cheese_data$Lactic))
plot(density(cheese_data$H2S))

cheese_data$H2S_log10 <- log10(cheese_data$H2S)

lm_cheese_taste <- rxLinMod( formula= taste~Acetic+H2S+Lactic,  data =cheese_data)
summary(lm_cheese_taste)

lm_cheese_taste_log10 <- rxLinMod( formula= taste~Acetic+H2S_log10+Lactic,  data =cheese_data)
summary(lm_cheese_taste_log10)

lm_cheese_taste_log10 <- rxLinMod( formula= taste~Acetic+H2S_log10+Lactic,  data =cheese_data)
summary(lm_cheese_taste_log10)

cheese_data$taste_boxcox <- cheese_data$taste^0.5
cheese_data$Acetic_boxcox <- cheese_data$Acetic^0.5
cheese_data$Lactic_boxcox <- cheese_data$Lactic^0.5
cheese_data$H2S_boxcox <- cheese_data$H2S^0.5

# box-cox transformation
lm_cheese_taste_boxCox <- rxLinMod( formula= taste~Acetic+H2S_log10+Lactic,  data =cheese_data)

lm_cheese_taste_boxCox_interaction <- rxLinMod( formula= taste_boxcox~H2S_boxcox+Lactic_boxcox+H2S_boxcox:Lactic_boxcox,  data =cheese_data)
#the interaction is in fact not significant

### EXAMPLE OF ELEGANT SOLUTION:
library(GGally)
library(dplyr)

# import
cheese <- rxImport(inData = “/media/sf_docVM/cheese.txt")
str(cheese)
summary(cheese[,-c(1,2)])

#
cheese %>%
    select(-c(.rxRowNames, Case)) %>%
    GGally::ggpairs(title = "without transformation")

#with transformation
cheese %>%
    select(-c(.rxRowNames, Case)) %>%
    mutate_all(funs(log2)) %>%
    GGally::ggpairs(title = "log2 transformation")

#Boxcox transformation
apply(cheese[,-c(1,2)], 2, function(x) caret::BoxCoxTrans(x)$lambda)
caret::BoxCoxTrans(cheese$Lactic[-3])$lambda # exclude negative value...

cheese %>%
    select(-c(.rxRowNames, Case)) %>%
    mutate(taste_boxcox = taste^.6,
           Acetic_log = log2(Acetic),
           H2S_boxcox = H2S^-.1,
           Lactic_boxcox = Lactic^.5) %>%
    select(-c(taste:Lactic)) -> cheese_trans
cheese_trans %>%
    GGally::ggpairs(title = "log2 & box-cox transformation")
rxLinMod(formula = taste_boxcox ~ H2S_boxcox, data = cheese_trans) %>% summary
rxLinMod(formula = taste_boxcox ~ H2S_boxcox+Lactic_boxcox, data = cheese_trans) %>% summary

# !!! effect of transformation !!!

#*********************************************
# using RevoScale - race/ethnicity dataset
#*********************************************

library(SASxport)
brfss <- read.xport("LLCP2013.XPT")
head(brfss)
dim(brfss) # 491773 rows, 336 columns


log_reg <- glm(HLTHCVRG~X.RACE,family=binomial,data=brfss) 

brfss_data <- rxImport(inData = "LLCP2013.XPT") 




























