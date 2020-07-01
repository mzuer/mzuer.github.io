#*********************************************************************
# Binomial data
#*********************************************************************

#######################################
# Exercise 1: Michelin food
#######################################


michelin <- read.delim("TuesdayEx/MichelinFood.txt",header=TRUE,sep="\t",as.is=TRUE)
head(michelin)

# 1) Start by graphically exploring the data

plot(density(michelin$Food))

boxplot(michelin$InMichelin)
boxplot(michelin$NotInMichelin)
boxplot(michelin$mi)
boxplot(michelin$proportion)

plot(michelin$Food, michelin$proportion)

# 2) Fit a GLM using a binomial model for the response, using the food ranking as the predictor.

mich_glm <- glm(cbind(InMichelin, NotInMichelin) ~ Food, data = michelin, family=binomial(logit))
summary(mich_glm)
 
# 3) Predict the probabilities for a number of potential food rankings xnew, and plot a smooth function
 
xnew <- data.frame(Food = seq(from = 14, to = 30, length.out = 50))
ynew <- predict(mich_glm, newdata=xnew, type="response")
plot(michelin$Food, michelin$proportion)
lines(x=xnew$Food, y=ynew)


# 4) Check the model by looking at the residual deviance, other residuals and especially the quantile residuals
summary(mich_glm)
 
anova(mich_glm, test = "Chisq")

library(car)
residualPlot(mich_glm, type="deviance")
residualPlot(mich_glm, type="response")
residualPlot(mich_glm, type="pearson")

library(statmod)
qres <- qresiduals(mich_glm)
qqnorm(qres)
qqline(qres)
acf(qres)

# 5) Check the model for potential influencial observations.

influencePlot(mich_glm)
influenceIndexPlot(mich_glm)

#######################################
# Exercise 2: Moth death
#######################################
# Since the doses are powers of two, we use log2(dose) as the predictor rather than the actual dose.

moth <- data.frame(sex = rep(c("male", "female"), each = 6),
                   dose = log2(rep(c(1, 2, 4, 8, 16, 32), 2)),
                   numdead = c(1, 4, 9, 13, 18, 20, 0, 2, 6, 10, 12, 16))
moth$numalive <- 20 - moth$numdead

plot(numdead ~ sex,data=moth)
plot(numdead ~ dose,data=moth)

# 1) Fit a GLM using the sex and dose as predictors. Do we need to include an interaction term in the model?
# if data not proportion (betw. 0,1) -> should provide kind of proportion table

moth_glm1 <- glm(cbind(numdead,numalive) ~ sex + dose, data = moth, family = "binomial")
summary(moth_glm1)

moth_glm2 <- glm(cbind(numdead,numalive) ~ sex * dose, data = moth, family = "binomial")
summary(moth_glm2) # interaction term not signif


# 2) Does the model fit well? Perform an analysis of deviance
1 - pchisq(deviance(moth_glm1), df.residual(moth_glm1))

moth_glm_null <- glm(cbind(numdead, numalive) ~ 1, data = moth, family = binomial)
anova(moth_glm_null, moth_glm1, test = "Chisq")

# 3) predict the probabilities for different doses and include a smooth line in the plots
xnew <- data.frame(sex = rep(c("male", "female"), each = 30),
                   dose = rep(seq(from = 0, to = 5, length.out = 30), 2))
ynew <- predict(moth_glm1, newdata=xnew, type="response")

moth$proportion <- moth$numdead/(moth$numalive + moth$numdead )
color <- moth$sex
levels(color) <- c("red", "blue")
plot(moth$proportion ~ moth$dose, col = as.character(color))
lines(xnew$dose[which(xnew$sex == "male")], ynew[which(xnew$sex == "male")],
      col = "blue", lwd = 2)
lines(xnew$dose[which(xnew$sex == "female")], ynew[which(xnew$sex == "female")],
      col = "red", lwd = 2)

#######################################
# Exercise 3: Beetle
#######################################


# 1) fit a logistic regression to the data using dose as a predictor
beetles <- data.frame(dose = c(1.6907, 1.7242, 1.7552, 1.7842, 1.8113,1.8369, 1.8610, 1.8839),
                      dead = c(6, 13, 18, 28, 52, 53, 61, 60),
                      alive = c(51, 47, 44, 28, 11, 6, 1, 0))
beetles$prop <- beetles$dead/(beetles$alive+beetles$dead)

plot(prop ~ dose, data = beetles)

glm_beetles <- glm(cbind(dead, alive) ~ dose, family="binomial", data = beetles)

# 2) fit another logistic regression using the log-log link. Compare the two fits.

glm_beetles_log <- glm(cbind(dead, alive) ~ dose, family=binomial(link = "cloglog"), data = beetles)

# 3) Compare the prediction with each of the model.
new_beetle <- data.frame(dose = seq(from = 1.5, to = 1.9, length.out = 100))


plot(predict(glm_beetles, type = "response"), type = "l")
lines(predict(glm_beetles_log, type = "response"), col = "red")

plot(predict(glm_beetles, type = "response", newdata = new_beetle), type = "l")
lines(predict(glm_beetles_log, type = "response", newdata = new_beetle), col = "red")


# en gros, on peut toujours utiliser la canonique 
# log-log: c est une alternative à la canonique pour Poisson

#######################################
# Exercise 4: Pima
#######################################

library(faraway)
data("pima")
head(pima)

# 1) Perform simple graphical and numerical summaries of the data. 
# Can you find any obvious irregularities in the data? If you do, take appropriate steps to correct the problems
str(pima)
summary(pima)


# transform test to a factor
pima$test <- factor(pima$test)
levels(pima$test) <- c("negative", "positive")
table(pima$test)


plot(pima$pregnant)
plot(pima$glucose)
plot(pima$diastolic)
plot(pima$triceps)
plot(pima$insulin)
plot(pima$bmi)
plot(pima$diabetes)
plot(pima$age)
plot(pima$test)

boxplot(pima$pregnant ~ pima$test)
boxplot(pima$glucose~ pima$test)
boxplot(pima$diastolic~ pima$test)
boxplot(pima$triceps~ pima$test)
boxplot(pima$insulin~ pima$test)
boxplot(pima$bmi~ pima$test)
boxplot(pima$diabetes~ pima$test)
boxplot(pima$age~ pima$test)

# 0 is likely to mean missing values so replace with NA also there are several potential outliers...
pima$glucose[which(pima$glucose == 0)] <- NA
pima$diastolic[which(pima$diastolic == 0)] <- NA
pima$triceps[which(pima$triceps == 0)] <- NA
pima$insulin[which(pima$insulin == 0)] <- NA
pima$bmi[pima$bmi == 0] <- NA

# 2) Fit a model with the result of the diabetes test as the response and all the other variables as predictors. 
# Can you tell whether this model fits the data?
glm_pima_full <- glm(test ~ ., pima, family = binomial)
summary(glm_pima_full)

summary(glm_pima_full)
library(car)
residualPlots(glm_pima_full)

library(statmod)
qqnorm(qresiduals(glm_pima_full))
qqline(qresiduals(glm_pima_full))
qres <- qresiduals(glm_pima_full)
plot(qres ~ predict(glm_pima_full, type = "link"))
acf(qres)
# acf high = autocorrelation in the residuals => should not be

# 3) What is the difference in the odds of testing positive for diabetes for a woman with a BMI at the first quartile compared with a woman 
# at the third quartile, assuming that all other factors held constant? Give a confidence interval for this difference.

# The estimate for bmi (0.07) gives the log odds = 
# increas in the log odd when bmi is increased by 1 unit increases
# get the odds:
exp(coefficients(glm_pima_full)["bmi"])
# bmi 
# 1.093847 
# 
# so the odds of getting a positive test is increased by a factor 1.093847 and the probability of
# having a positive test is:
exp(coefficients(glm_pima_full)["bmi"])/(1 + exp(coefficients(glm_pima_full)["bmi"]))


# let’s compute the quartiles of bmi
diff_bmi <- diff(quantile(pima$bmi, prob = c(0.25, 0.75), na.rm = TRUE))
logodds_diff_bmi <- diff_bmi * coefficients(glm_pima_full)["bmi"]
odds_bmi <- exp(logodds_diff_bmi)
# CI for odds of the difference
exp(confint(glm_pima_full)["bmi", ] * diff_bmi)

# 4) Do women who test positive have higher diastolic blood pressures? Is the diastolic blood pressure signifcant in the regression model? 
# Explain the distinction between the two questions and discuss why the answers are only apparently contradictory.

summary(lm(diastolic ~ test, pima))

# diastolic blood pressure is not significant in the model.
# Women with positive test tend to have higher diastolic blood pressure. However in this model
# the test factor may be confonded with another factor.

# 5) Perform diagnostics on the regression model, reporting any potential violations and any suggested improvements to the model
library(car)
library(statmod)
residualPlots(glm_pima_full)


qqnorm(qresiduals(glm_pima_full))
qqline(qresiduals(glm_pima_full))
qres <- qresiduals(glm_pima_full)
plot(qres ~ predict(glm_pima_full, type = "link"))
acf(qres)

head(sort(cooks.distance(glm_pima_full), decreasing = TRUE))
plot(glm_pima_full, which = 4)
influenceIndexPlot(glm_pima_full, vars = c("Cook", "Studentized", "hat"))


# 6) Predict the outcome for a woman with the following predictor values:
  
new_pima <- data.frame(pregnant = 1, glucose = 99, diastolic = 64, triceps = 22,
                       insulin = 76, bmi = 27, diabetes = 0.25, age = 25)
pred_prob <- predict(glm_pima_full, newdata = new_pima, type = "response", se = TRUE)
pred_prob$fit + 1.96 * pred_prob$se.fit

pred_logit <- predict(glm_pima_full, newdata = new_pima, se = TRUE)
ilogit(pred_logit$fit) # gives the probability
# ilogit -> inverse logit transformation

# 7)  Give a confidence interval for your prediction.
ilogit(c(pred_logit$fit - 1.96 * pred_logit$se.fit, (pred_logit$fit + 1.96 *
                                                       pred_logit$se.fit)))



#######################################
# Exercise 5: babyfood
#######################################

library(faraway)
data(babyfood)

# 1) Explore the data
library(faraway)
data(babyfood)
str(babyfood)
summary(babyfood)

boxplot(disease ~ food, babyfood)
boxplot(disease ~ sex, babyfood)


# 2) What are the proportions of Boys/Girls in the different food categories?

xtabs(disease/(disease + nondisease) ~ sex + food, babyfood)

# 3) Fit a logistic regression to explain the probability of disease by sex and food.

mdl <- glm(cbind(disease, nondisease) ~ sex + food, family = binomial, babyfood)
summary(mdl)


# 4) What is the impact of breast feeding on the odds of respiratory disease compared to bottle feeding? Give a confidence interval for this value.
exp(coefficients(mdl)[grep("food", names(coefficients(mdl)))])

# breast feeding reduces the odds of respiratory desease to 51% of that for
# bottle feeding. CI
breast_food <- coefficients(summary(mdl))["foodBreast", ]
exp(c(breast_food["Estimate"] - 1.96 * breast_food["Std. Error"], breast_food["Estimate"] +
        1.96 * breast_food["Std. Error"]))

#*********************************************************************
# Count data
#*********************************************************************


#######################################
# Exercise 6: dvisits
#######################################


# 1) Explore the dataset
library(faraway)
data("dvisits")
summary(dvisits)
dvisits$sex <- factor(dvisits$sex)
levels(dvisits$sex) <- c("male", "female")
dvisits$levyplus <- factor(dvisits$levyplus)
levels(dvisits$levyplus) <- c("no", "private")
dvisits$freepoor <- factor(dvisits$freepoor)
levels(dvisits$freepoor) <- c("nofreepoor", "freepoor")
dvisits$freerepa <- factor(dvisits$freerepa)
levels(dvisits$freerepa) <- c("nofreerepa", "freerepa")
dvisits$chcond1 <- factor(dvisits$chcond1)
levels(dvisits$freerepa) <- c("notchronic", "chronic")
dvisits$chcond2 <- factor(dvisits$chcond2)
levels(dvisits$freerepa) <- c("notchronic", "chronic_limited")


# 2) Build a Poisson regression model with doctorco as the response and sex, age, agesq, income, levyplus, freepoor, freerepa, 
# illness, actdays, hscore, chcond1 and chcond2 as possible predictor variables.
# Considering the deviance of this model, does this model fit the data?
glm_dvisits <- glm(doctorco ~ sex + age + agesq + income + levyplus + freepoor +
                     freerepa + illness + actdays + hscore + chcond1 + chcond2, data = dvisits,
                   family = poisson)
summary(glm_dvisits)
# deviance seems not too bad (same range as the df)

# 3) Plot the residuals and the fitted values. Why are there lines of observations on the plot?
plot(residuals(glm_dvisits), fitted.values(glm_dvisits))
table(dvisits$doctorco)
# 9 levels of response -> the residuals also follow that. 
# each line corresponds to a different possible value

# 4) Use backward eliminiation with a critical p-value of 5% to reduce the model as much as possible. Report your model.
# remove each time the least significant variable
glm_dvisits <- update(glm_dvisits,. ~ . - agesq, data = dvisits)
glm_dvisits <- update(glm_dvisits,. ~ . - freerepa, data = dvisits)
glm_dvisits <- update(glm_dvisits,. ~ . - levyplus, data = dvisits)
glm_dvisits <- update(glm_dvisits,. ~ . - chcond1, data = dvisits)
glm_dvisits <- update(glm_dvisits,. ~ . - chcond2, data = dvisits)
summary(glm_dvisits)

# 5) What sort of person would be predicted to visit the doctor the most under your selected model
# Under the last model, the person who is the most probable to visit the doctor is a 
# female, old, low income, freepoor, with illnesses in the past 2 weeks, 
# with reduced activity in the past 2 weeks and with high score to Goldberg’s questionnaire.

# 6) For the last person in the dataset, compute the predicted probability distribution for their visits to the doctor, 
# i.e., give the probability they visit 0,1,2,… times.
new.data <- tail(dvisits, 1)
mu <- predict(glm_dvisits, newdata = new.data, type = "response")
mu <- exp(predict(glm_dvisits, newdata = new.data))
sapply(seq(0, 9, 1), function(x) dpois(x, lambda = mu))

# 7) fit a comparable (Gaussian) linear model and graphically compare the fits. Describe how they differ.
lm_dvisits <- lm(log(doctorco + 0.1) ~ sex + age + income + freepoor + illness +
                   actdays + hscore, data = dvisits)
summary(lm_dvisits)

# the mean of a log-normal random variable is exp(μ + σ 2 /2).
# predict(lm_dvisits) gives the mean and deviance/df.residual the variance
sigma_lm <- deviance(lm_dvisits)/lm_dvisits$df.residual
plot(exp(predict(lm_dvisits) + sigma_lm/2) - 0.1, predict(glm_dvisits, type = "response"),
     xlab = "linear model responses", ylab = "poisson model responses")
abline(0, 1, col = "red")


# All the fitted values under lm are lower than the corresponding fitted values under glm.
# The poisson model assumes that the mean=variance.
# The normal model assumes that the variance of log(Y) is constant (therefore also that var(Y)
#   is constant)

#######################################
# Exercise 7: salmonella
#######################################

library(faraway)
data("salmonella")
salmonella

# Show that a poisson GLM is inadequate and that some overdispersion must be allowed for. 
# Do not forget to check out other reasons for a high deviance.

glm_salmonella <- glm(dose ~ colonies, family = poisson, data = salmonella)
summary(glm_salmonella)

glm_salmonella$deviance

glm_salmonella$df.residual

# - the residual variance is much larger than the df 
# - other reason than overdispersion could be an outlier or high influence of a point
plot(influence(glm_salmonella)$hat)

# one observation seems high
# identify(influence(glm_salmonella)$hat)
# which.max(influence(glm_salmonella)$hat)
glm_salmonella2 <- glm(dose ~ colonies, family = poisson, data = salmonella[-12,] )
summary(glm_salmonella2)


#  -> still high deviance.
dp <- sum(residuals(glm_salmonella, type = "pearson")^2/glm_salmonella$df.residual)
summary(glm_salmonella, dispersion = dp)


# can also fit a negative binomial
library(MASS)
glm_salmonella_negbin <- glm.nb(dose ~ colonies, salmonella)
summary(glm_salmonella_negbin)
glm_salmonella_negbin$deviance
glm_salmonella_negbin$df.residual

#######################################
# Exercise 8: lung cancer
#######################################

library(ISwR)
data(eba1977)
eba1977


# 1) Model this count using the city and age category as predictors. Fit a Poisson GLM to the data. Is the fit appropriate?

glm_cancer <- glm(cases ~ city + age, data = eba1977, family = poisson)
summary(glm_cancer)

# deviance seems ok

# 2) In the previous model, we are not considering the number of potential cases in each group (ie the population size). 
# Modify the model by using an offset which takes the population size into account.

glm_cancer_off <- glm(cases ~ offset(log(pop)) + city + age, data = eba1977,
                      family = poisson)
summary(glm_cancer_off)

# age effect is very significant.

# 3) Fit a binomial model to the data by considering success as being lung cancer cases and failures as being (populationsize−numberofcases).
# Compare with the Poisson model. 

# success as being lung cancer and cases as failures
success <- eba1977$cases
failures <- eba1977$pop - eba1977$cases
glm_cancer_bin <- glm(cbind(success, failures) ~ city + age, family = "binomial",
                    data = eba1977)
summary(glm_cancer_bin)

# We see that the results are very close to those obtained with the Poisson model with offset.
# This is because the number of cases is generally very low compared to the population size,
# in other words, the population size is “almost infinite” compared to the number of cases. In
# this situation, the Poisson distribution is closely related to the binomial distribution 
# (sampling from a finite, large population of known size is almost the same as sampling from an infinite population).

# population size almost infinite compared to # of cases -> Poisson close to binomial 

#######################################
# Exercise 9: melanoma
#######################################


mel <- matrix(c(22, 16, 19, 11, 2, 54, 33, 17, 10, 115, 73, 28),nrow = 4, ncol = 3)
colnames(mel) <- c("headneck", "trunk", "extrm")
rownames(mel) <- c("hutch", "superf", "nodular", "indet")
mel

##         headneck trunk extrm
## hutch         22     2    10
## superf        16    54   115
## nodular       19    33    73
## indet         11    17    28

# The question of interest is whether there is any association between the tumor type and the site 
# (that is, if one tumor type is more or less common than expected in a given site). 
# We can test the hypothesis of no association by a conventional chi-square test:
  
chisq.test(mel)

# 

# If there is no association between the two variables, the expected number of patients in a given cell is proportional 
# to the product of the marginal totals for the row and column categories under consideration. 
# On a log-scale, this would correspond to summing the site and tumor type effects. 
# We can thus test the association between the tumor type and the site by comparing a model with only the main effects of site and
# tumor type to a model including also the interaction between the two. 

# First, we need to reformat the data into so called “long” format:
  
require(reshape2)
mel.long <- melt(mel, varnames = c("tumtype", "site"), value.name = "freq")

# Now we can fit the two models using Poisson regression with a log link.

mel.main <- glm(freq ~ tumtype + site, family = poisson,data = mel.long)
mel.int <- glm(freq ~ tumtype*site, family = poisson,data = mel.long)

# We can compare the fit with the two models using e.g. the AIC criterion, 
# or by checking the significance of the interaction term in the last model.

AIC(mel.main, mel.int)

##          df      AIC
## mel.main  6 122.9064
## mel.int  12  83.1114

anova(mel.int, test = "Chisq")

# From the two models, we can also directly get the expected number of cases in each cell under the assumption of no association 
# (from the model without the interaction), as well as the observed number (from the model with the interaction, which fits the data exactly).

(exp.count <- predict(mel.main, type = "response"))
(obs.count <- predict(mel.int, type = "response"))

# sum of the squares of the Pearson residuals of the model without interaction = chi-square statistic from the conventional test.
sum((residuals(mel.main, type = "pearson"))^2)
## [1] 65.81293
# same as the X-squared given by
chisq.test(mel)


# odd-ratio test <-> logsitique
# Poisson <-> chi-squared
# (si 1 signif, autre tjs signif)

# binomial -> pas regarder 1 
# pour les autres GLM -> explorer les 3 types de residualPlot

#######################################
# Exercise 10: Africa
#######################################

# The dataset africa gives information about the number of military coups in subSaharan Africa and various political and geographical information. 
# Develop a simple but well- fitting model for the number of coups. 
# Give an interpretation of the effect of the variables you include in your model on the response.
library(faraway)
data(africa)
summary(africa)
str(africa)

# we notice that pollib should be a factor
africa$pollib <- factor(africa$pollib)
glm_africa <- glm(miltcoup ~ ., data = africa, family = poisson)
summary(glm_africa)

glm_africa <- update(glm_africa, .~.-numelec)
glm_africa <- update(glm_africa, .~.-numregim)
glm_africa <- update(glm_africa, .~.-size)
glm_africa <- update(glm_africa, .~.-popn)
glm_africa <- update(glm_africa, .~.-pctvote)

summary(glm_africa)

# for each added year of oligarchy, the number of coups is increased by exp(0.09) while the
# number of coups is decreased if the pollib=2 compared to 0 (goes from no civil rights to full
# civil rights) increase in the number of parties also tend to increase the number of coups.

#*********************************************************************
# Extra exercises
#*********************************************************************

#######################################
# Exercise 11: ACF1 data
#######################################

# The ACF1 data set from the DAAG package contains the number of aberrant crypt foci (ACF) in a colon section in each of 22 rats 
# subjected to a carcinogen. The rats were sacrificed at three different times.
# Is there a difference between the number of ACF in the three groups of rats? 
# Does the Poisson assumption seem to hold?


library(DAAG)
head(ACF1)
ACF1$endtime <- as.factor(ACF1$endtime)

boxplot(ACF1$count ~ ACF1$endtime)

mod1 <- glm(count ~ endtime, data = ACF1, family="poisson")
summary(mod1)

mod1_null <- glm(count ~ 1, data=ACF1, family="poisson")
summary(mod1_null)

anova(mod1_null, mod1, test = "Chisq")


#######################################
# Exercise 12: dengue data
#######################################

# The dengue data set from the DAAG package contains data for 2,000. For each region, it is recorded whether or not dengue was recorded
# any time between 1961 and 1990 (the NoYes variable). We also have information about other variables, such as temperature and humidity
# during these years. Which variables seem to influence the occurrence of dengue?

require(DAAG)
data(dengue)
head(dengue)

boxplot(dengue$humid ~ dengue$NoYes)
boxplot(dengue$humid90 ~ dengue$NoYes)
boxplot(dengue$temp ~ dengue$NoYes)
boxplot(dengue$temp90 ~ dengue$NoYes)
boxplot(dengue$h10pix ~ dengue$NoYes)
boxplot(dengue$h10pix90 ~ dengue$NoYes)
boxplot(dengue$trees ~ dengue$NoYes)
boxplot(dengue$trees90 ~ dengue$NoYes)
boxplot(dengue$Xmin ~ dengue$NoYes)
boxplot(dengue$Xmax ~ dengue$NoYes)
boxplot(dengue$Ymin ~ dengue$NoYes)
boxplot(dengue$Ymax ~ dengue$NoYes)

m1 <- glm(NoYes ~ ., data = dengue, family="binomial")
summary(m1)
m1 <- update(m1, .~.-Xmin)
summary(m1)
m1 <- update(m1, .~.-Xmax)
summary(m1)
m1 <- update(m1, .~.-h10pix90)
summary(m1)
m1 <- update(m1, .~.-Ymax)
summary(m1)
m1 <- update(m1, .~.-Ymin)
summary(m1)

library(car)
library(statmod)
residualPlots(m1)
qqnorm(qresiduals(m1))
qqline(qresiduals(m1))
qres <- qresiduals(m1)
plot(qres ~ predict(m1, type = "link"))
acf(qres)
head(sort(cooks.distance(m1), decreasing = TRUE))
plot(m1, which = 4)
influenceIndexPlot(m1, vars = c("Cook", "Studentized", "hat"))


#######################################
# Exercise 13: leafshape17 data
#######################################
# The leafshape17 data set has 61 observations of 8 variables, representing leaf length, width and petiole measurements from several sites in Australia. 
# Is the leaf architecture (binary variable) associated with any of the other variables?

require(DAAG)
data(leafshape17)
head(leafshape17)

boxplot(leafshape17$bladelen ~ leafshape17$arch)
boxplot(leafshape17$petiole ~ leafshape17$arch)
boxplot(leafshape17$bladewid ~ leafshape17$arch)
boxplot(leafshape17$latitude ~ leafshape17$arch)
boxplot(leafshape17$logwid ~ leafshape17$arch)
boxplot(leafshape17$logpet ~ leafshape17$arch)
boxplot(leafshape17$loglen ~ leafshape17$arch)

m1 <- glm(arch ~ ., data = leafshape17, family="binomial")
summary(m1)
unique(leafshape17$latitude)
m1 <- update(m1, . ~.-latitude)
summary(m1)
m1 <- update(m1, . ~.-logpet)
summary(m1)

library(car)
library(statmod)
residualPlots(m1)
qqnorm(qresiduals(m1))
qqline(qresiduals(m1))
qres <- qresiduals(m1)
plot(qres ~ predict(m1, type = "link"))
acf(qres)
head(sort(cooks.distance(m1), decreasing = TRUE))
plot(m1, which = 4)
influenceIndexPlot(m1, vars = c("Cook", "Studentized", "hat"))

#######################################
# 2 curves -> one that corresponds to the responses that were 0, the other that corresponds to the responses that were 1
# most textbooks: thesse plots not relevant for binomial distribution, becausee hard to interpret

# chisq to test if they come from the same distribution
# to compare 2 values


commencer toujours par Poisson. si bcp de dispersion, résidus -> binomial (tout plus simple avec Poisson)