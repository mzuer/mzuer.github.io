#############################################################
# <babies> dataset
#############################################################

load("TuesdayEx/babies.RData")
head(babies)

# 1) graphical exploration
# 2) which factor explains prematurity
# 3) can we use linear model ? predictions ?

babies$prem <- factor(babies$prem, levels = as.character(unique(babies$prem)))

plot(density(babies$bwt))
plot(density(babies$mother_age))
plot(density(babies$mother_height))
plot(density(babies$mother_weight))
plot(density(babies$gestation))

boxplot(babies$bwt ~ babies$prem)
boxplot(babies$mother_age ~ babies$prem)
boxplot(babies$mother_height ~ babies$prem)
boxplot(babies$mother_weight ~ babies$prem)
boxplot(babies$gestation ~ babies$prem)

babies$prem <- as.numeric(as.character(babies$prem))
plot(babies$prem ~ babies$bwt )
plot(babies$prem ~ babies$mother_age)
plot(babies$prem ~ babies$mother_height)
plot(babies$prem ~ babies$mother_weight)

unique(babies$prem)
unique(babies$parity)

m1 <- lm(prem ~ bwt + gestation + parity + mother_age + mother_height + mother_weight + smoke, data = babies)
summary(m1)

# logits are continuous
# relationship with odd-ratio

#############################################################
# <diabetes> dataset
#############################################################

# load data and remove NA
data("PimaIndiansDiabetes2", package="mlbench")
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)

logitM <- glm(diabetes ~ glucose,
              data = PimaIndiansDiabetes2, family=binomial)

summary(logitM)

plot(fitted(logitM) ~ PimaIndiansDiabetes2$glucose)


# Logistic regression with babies dataset
# 1) fit logistic regressionto find parameters explaining the probability of prematurity
# 2) what is the effect of birth weigth on the probability of prematurity
# 3) what about parity
load("TuesdayEx/babies.RData")
babies$prem <- as.numeric(as.character(babies$prem))
glm1 <-  glm(prem ~ bwt, 
             data = babies,
             family=binomial)

plot(fitted(glm1) ~ babies$bwt,  col="red")
summary(glm1)
glm1
curve(exp(coef(glm1)[1]+coef(glm1)[2]*x)/(1+exp(coef(glm1)[1]+coef(glm1)[2]*x)), add =T )

glm2 <-  glm(prem ~ mother_age + mother_height + mother_weight, 
             data = babies,
             family=binomial)
summary(glm2)
glm2


glm3 <-  glm(prem ~ bwt + gestation + parity + mother_age + mother_height + mother_weight + smoke, 
             data = babies,
             family=binomial)
summary(glm3)
glm3

glm4 <-  glm(prem ~ bwt ,
             data = babies,
             family=binomial)
summary(glm4)
glm4



glm4 <-  glm(prem ~ bwt ,
             data = babies,
             family=binomial)
summary(glm4)
glm4

# xtabs(disease/(dis+nondisease) ~ sex + food, babyfood)
#         )
# 
# glm(cbind(yes/no))


#############################################################
# <babiy food> dataset
#############################################################


# 1) data exploration
# 2) proportion of boys/girls in the different food categories
# 3) logistic regression to explain probability of disease by sex and food
# 4) impact of breast feeding on odds of respiratory disease compared to bottle feeding
#    give confidence interval

library(faraway)
data(babyfood)
head(babyfood)

plot(babyfood)

str(babyfood)
summary(babyfood)

boxplot(babyfood$disease ~ babyfood$sex + babyfood$food)
boxplot(disease ~ food, babyfood)
boxplot(disease ~ sex, babyfood)


xtabs(disease/(disease+nondisease) ~ sex + food, babyfood)
    # food
# sex        Bottle     Breast      Suppl
# Boy  0.16812227 0.09514170 0.12925170
# Girl 0.12500000 0.06681034 0.12598425

glmB <- glm(cbind(disease, nondisease) ~ sex + food, data = babyfood, family=binomial)
glmB
summary(glmB)

# 3) -0.6693

# 4) 
exp(coefficients(glmB)[grep("food", names(coefficients(glmB)))])
## foodBreast
## 0.5120696
foodSuppl
0.8415226
# breast feeding reduces the odds of respiratory desease to 51% of that for
# bottle feeding. CI
breast_food <- coefficients(summary(glmB))["foodBreast", ]
exp(c(breast_food["Estimate"] - 1.96 * breast_food["Std. Error"], breast_food["Estimate"] +
        1.96 * breast_food["Std. Error"]))
## Estimate Estimate
## 0.3793918 0.6911465


# canonical function as a link function for the GLM
# for the normal dist. -> identity function
# binomial dist -> logit function 
# Poisson -> log function

# transform the data vs. GLM
# with transformation: adress normal distribution but not heteroscedasticity
# when transforming, you don't control the linearity between predictors
# with link function: you transform the mean

# compare to least square LM -> with the GLM there is no simple way to assess the goodness of fit the model
# compare model and look residuals to see if the fit is good

#############################################################
# <babies> dataset (ii)
#############################################################

load("TuesdayEx/babies.RData")
head(babies)

babiesGLM <-  glm(prem ~ smoke + parity , data = babies, family=binomial) 
summary(babiesGLM)
babiesGLM


library(car)
# 1) check deviance residuals using residualPlots {car}
residualPlots(babiesGLM)
# hard to interpret with binomial data
# better solution:

# 2) quantile residuals using qresiduals {statmod}
library(statmod)
qres <- qresiduals(babiesGLM)
qqnorm(qres)
qqline(qres)
plot(predict(babiesGLM, type="link"), qres, xlab="fitted values", ylab="residuals")
acf(qres)



# 3) analyze the deviance

# very high deviance, questionable if appropriate model
# most of the points normally shaped but still some of them that are outliers
# complex model that could be applied to this

# 4) potential influencial and outlying observations

