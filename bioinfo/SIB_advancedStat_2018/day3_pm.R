# repeated measures ANOVA: can only handle if samples have the same number of measurements

# ML -> more accurate for the fixed parameters
# REML -> more accurate prediction for random variances
# if the question is to answer questions about random parameters -> REML
# -> depends on the research question

# model complexity = # of model parameters
# AIC is not a stat. test, used as a comparison (per se does not mean anything, meaningful if compared to sth)

# LRT: in fact not always chi-squared distribution
# (some textbooks recommend simulations to generate distribution)

# allow parameters to vary between clusters
# one fixed slope and intercept -> population mean
# random slope and intercept parameter -> variability around the fixed parameters

# with vs. without fixed effect:
# more parameters but better AIC with the random effect:
# estimate values are the same but std deviations different
# even you guess the same intercept, you are much more confident

# 16 draws from the distribution that has the mean of 1.62

# allow the slope to vary across clusters/individuals also improves the goodness of fit
# fixed intercept and allow random slope


#=================================================================================================================================

# Advanced Statistics: Statistical Modeling; Aug 20-23, 2018
# Data and R code for "Longitudinal Data Analysis"

################################################################################################################
# ******************************* TOLERANCE DATASET
################################################################################################################

# load the "tolerance" data set: "tolerance.RData"

load("WedEx/tolerance.RData")

# examine the data
str(tolerance_untidy)
str(tolerance_tidy)

# exploratory analysis

library(lattice)

### scatterplots of raw data
xyplot(tolerance ~ age | as.factor(id), ylim=c(0,4), data=tolerance_tidy, as.table=F)
# nonparametric smoothing spline fit
xyplot(tolerance ~ age | as.factor(id), ylim=c(0,4), data=tolerance_tidy,
       prepanel = function(x,y) prepanel.spline(x,y),
       xlab = "age", ylab = "tolerance",
       panel = function(x,y) {
         panel.xyplot(x,y)
         panel.spline(x,y) }
)
# nonparametric loess fit (we will learn more about loess during GAM lecture)
xyplot(tolerance ~ age | as.factor(id), ylim=c(0,4), data=tolerance_tidy,
       prepanel = function(x,y) prepanel.loess(x,y, family="gaussian"),
       xlab = "age", ylab = "tolerance",
       panel = function(x,y) {
         panel.xyplot(x,y)
         panel.loess(x,y, family="gaussian") }
)
# parametric/linear fit
xyplot(tolerance ~ age | as.factor(id), ylim=c(0,4), data=tolerance_tidy,
       prepanel = function(x,y) prepanel.lmline(x,y),
       xlab = "age", ylab = "tolerance",
       panel = function(x,y) {
         panel.xyplot(x,y)
         panel.lmline(x,y) }
)


### extract summary from individual linear fits
lm.summary <- by(tolerance_tidy, tolerance_tidy$id, function(x) summary(lm(tolerance ~ time, data=x)))
lm.summary[1]
lm.summary[[1]]$coefficients
# fetch intercepts
all.intercept <- sapply(lm.summary, function(x) x$coefficients[1,1])
# fetch slopes
all.slope <- sapply(lm.summary, function(x) x$coefficients[2,1])
# fetch residual variances, i.e. (Residual standard error)^2
all.resVar <- sapply(lm.summary, function(x) (x$sigma)^2)
# fetch R-squared statistic
all.r2 <- sapply(lm.summary, function(x) x$r.squared)
# combine them in one matrix
my.summary <- rbind(all.intercept, all.slope, all.resVar, all.r2)
# remove the junk
rm(all.intercept, all.slope, all.resVar, all.r2)


### average of the curves (nonparametric)
# start with an empty plot
plot(1, type="n", xlab="age", ylab="tolerance", xlim=c(11,15), ylim=c(0,4), main="nonparametric")
# i) discretize time on a grid
t <- seq(11,15,length.out=100)
# ii) estimate individual trajectories
indiv <- unique(tolerance_tidy$id)
# create matrix to store estimates on the grid
est.nonpara <- matrix(NA, nrow=16, ncol=100)
# loop around individuals to plot individual curves and extract estimates on the grid
for (i in 1:length(indiv)) {
  temp.data <- subset(tolerance_tidy, subset=(id==indiv[i]))
  age <- temp.data$age
  tolerance <- temp.data$tolerance
  fit <- smooth.spline(age, tolerance)
  est <- predict(fit, data.frame(age=t))
  # plot the estimate
  lines(t(est$x),t(est$y), col="grey")
  # store the estimate
  est.nonpara[i,] <- t(est$y)
}
# average individual estimates for each point on the grid
avg.est <- apply(est.nonpara, MARGIN=2, mean)
# apply same smoothing algorithm to averages
fit <- smooth.spline(t, avg.est)
# overlay the curve of the averages
lines(t, fit$y, lwd=2)
# assign ids to rownames
rownames(est.nonpara) <- indiv
# remove the junk
rm(t,indiv,i,temp.data,age,tolerance,fit,est,avg.est)


### average of the curves (parametric)
# start with an empty plot
plot(1, type="n", xlab="age", ylab="tolerance", xlim=c(11,15), ylim=c(0,4), main="parametric")
# i) discretize time on a grid
t <- seq(11,15,length.out=100)
t.cent <- seq(0,4,length.out=100) # centering time predictor is optional but doing so improves the interpretability of the intercept (i.e. the intercept will reflect baseline exposure at age=11)
# ii) estimate individual trajectories
indiv <- unique(tolerance_tidy$id)
# matrix to store estimates on the grid
est.para <- matrix(NA, nrow=16, ncol=100)
# loop around individuals to plot individual curves and extract estimates on the grid
for (i in 1:length(indiv)) {
  temp.data <- subset(tolerance_tidy, subset=(id==indiv[i]))
  age <- temp.data$age
  age.cent <- temp.data$age - 11
  tolerance <- temp.data$tolerance
  fit <- lm(tolerance ~ age.cent)
  est <- predict(fit, data.frame(age.cent=t.cent), type="response")
  # plot the estimate
  abline( lm( tolerance ~ age), col="grey")
  # store the estimate
  est.para[i,] <- est
}
# average individual estimates for each point on the grid
avg.est <- apply(est.para, MARGIN=2, mean)
# apply same smoothing algorithm to averages
abline(lm( avg.est ~ t), lwd=2)
# assign ids to rownames
rownames(est.para) <- indiv
# remove the junk
rm(t,t.cent,indiv,i,temp.data,age,age.cent,tolerance,fit,est,avg.est)


### assess intercepts and slopes from linear fit
# all.intercepts
mean(my.summary["all.intercept",]) # 1.35775
sqrt( var(my.summary["all.intercept",]) ) # 0.2977792
# all.slopes
mean(my.summary["all.slope",]) # 0.1308125
sqrt( var(my.summary["all.slope",]) ) # 0.172296
# bivariate correlation
cor(my.summary["all.intercept",], my.summary["all.slope",]) # -0.4481135


### stratify based on gender
table(tolerance_untidy$male) # 9 x females and 7 x males
# discretize time on a grid
t <- seq(11,15,length.out=100)
# figure with 2 panels
par(mfrow=c(1,2))
# plot individual males
est.para_males <- est.para[rownames(est.para) %in% tolerance_untidy$id[tolerance_untidy$male==1], ]
plot(1, type="n", xlab="age", ylab="tolerance", xlim=c(11,15), ylim=c(0,4), main="males")
apply(est.para_males, MARGIN=1, function(x,t) {lines(t,x, col="gray")}, t=t)
avg.est <- apply(est.para_males, MARGIN=2, mean)
abline(lm( avg.est ~ t), lwd=2)
# plot individual females
est.para_females <- est.para[rownames(est.para) %in% tolerance_untidy$id[tolerance_untidy$male==0], ]
plot(1, type="n", xlab="age", ylab="tolerance", xlim=c(11,15), ylim=c(0,4), main="females")
apply(est.para_females, MARGIN=1, function(x,t) {lines(t,x, col="gray")}, t=t)
avg.est <- apply(est.para_females, MARGIN=2, mean)
abline(lm( avg.est ~ t), lwd=2)
# remove the junk
rm(est.para_males, est.para_females, t, avg.est)


### stratify based on exposure
summary(tolerance_untidy$exposure)
# exposure is a continuous time-invariant predictor, and thus can be categorized for visualization
median.exposure <- median(tolerance_untidy$exposure)
# discretize time on a grid
t <- seq(11,15,length.out=100)
# figure with 2 panels
par(mfrow=c(1,2))
# plot individuals with high-exposure
est.para_highExposure <- est.para[rownames(est.para) %in% tolerance_untidy$id[tolerance_untidy$exposure > median.exposure], ]
plot(1, type="n", xlab="age", ylab="tolerance", xlim=c(11,15), ylim=c(0,4), main="high-exposure")
apply(est.para_highExposure, MARGIN=1, function(x,t) {lines(t,x, col="gray")}, t=t)
avg.est <- apply(est.para_highExposure, MARGIN=2, mean)
abline(lm( avg.est ~ t), lwd=2)
# plot individuals with low-exposure
est.para_lowExposure <- est.para[rownames(est.para) %in% tolerance_untidy$id[tolerance_untidy$exposure <= median.exposure], ]
plot(1, type="n", xlab="age", ylab="tolerance", xlim=c(11,15), ylim=c(0,4), main="low-exposure")
apply(est.para_lowExposure, MARGIN=1, function(x,t) {lines(t,x, col="gray")}, t=t)
avg.est <- apply(est.para_lowExposure, MARGIN=2, mean)
abline(lm( avg.est ~ t), lwd=2)
# remove the junk
rm(est.para_highExposure, est.para_lowExposure, t, avg.est)

# won't need median.exposure anymore
rm(median.exposure)

########################################################

# multi-level / mixed-effects modeling
library(nlme)

# let's begin by assessing the need for a multi-level model
# First, we will fit a baseline model (only including an intercept) using ML
# Next, we will fit another model that allows intercepts to vary between clusters (i.e. a random intercept model)
# finally we compare the two models to see if the fit has improved as a result of allowing intercepts to vary
# fit the 1st model
fit.00 <- gls(tolerance ~ 1, data=tolerance_tidy, method="ML") # using centered age (i.e. time) for increased interpretability
summary(fit.00)
# plot fit.00
plot(tolerance_tidy$age, tolerance_tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
fit.00$coefficients
abline(h=1.619375, col="red", lwd=2)
# fit the 2nd model
fit.01 <- lme(tolerance ~ 1, random = (~ 1 | id), data=tolerance_tidy, method="ML")
summary(fit.01)
fit.01$coefficients
# plot fit.01 for patient "978" and compare with fit.00
plot(tolerance_tidy$age, tolerance_tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
points(tolerance_tidy$age[tolerance_tidy$id=="978"], tolerance_tidy$tolerance[tolerance_tidy$id=="978"], col="blue", pch=16)
fit.01$coefficients
abline(h = fit.01$coefficients$fixed, col="red", lwd=2)
fit.01$coefficients$fixed + unlist(fit.01$coefficients$random)[12]
abline(h = fit.01$coefficients$fixed + unlist(fit.01$coefficients$random)[12], col="blue", lwd=2)
# plot fit.01 for all individual
plot(tolerance_tidy$age, tolerance_tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
abline(h = fit.01$coefficients$fixed + unlist(fit.01$coefficients$random), col="blue", lwd=2)
# compare the two using AIC, BIC, and likelihood-ratio(LR)
anova(fit.00,fit.01)
# keeping in mind that the assumptions of the LR test is that:
# i) models were fit using ML
# ii) model are nested
# both assumption were met and p-val<0.05; therefore we can conclude that allowing for random intercepts significantly improved the fit
# let's move on by adding in covarites


# What if instead of random intercepts, we had allowed for random slopes?
# We have no reason to believe that individuals should share a baseline value (i.e. fixed intercept), but let's try it anyways for the sake of completeness
# fit the 1st model
fit.03 <- gls(tolerance ~ time, data=tolerance_tidy, method="ML") # using centered age (i.e. time) for increased interpretability
summary(fit.03)
# plot fit.03
plot(tolerance_tidy$age, tolerance_tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
fit.03$coefficients
abline( gls(tolerance ~ age, data=tolerance_tidy, method="ML"), col="red", lwd=2)
# fit the 2nd model
fit.04 <- lme(tolerance ~ time, random = (~ -1 + time | id), data=tolerance_tidy, method="ML")
summary(fit.04)
fit.04$coefficients
# plot fit.04 for patient "978" and compare with fit.03
plot(tolerance_tidy$age, tolerance_tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
points(tolerance_tidy$age[tolerance_tidy$id=="978"], tolerance_tidy$tolerance[tolerance_tidy$id=="978"], col="blue", pch=16)
predict.fit.04 <- predict(fit.04, newdata=data.frame(time=seq(0,4,length.out=100), id="978"))
lines(seq(11,15,length.out=100), predict.fit.04, col="blue", lwd=2)
# plot fit.04 for all individual
plot(tolerance_tidy$age, tolerance_tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
id <- as.character(unique(tolerance_untidy$id))
for (i in 1:length(id)) {
  predict.fit.04 <- predict(fit.04, newdata=data.frame(time=seq(0,4,length.out=100), id=id[i]))
  lines(seq(11,15,length.out=100), predict.fit.04, col="blue", lwd=1)
}
# compare the two using AIC, BIC, and LR
anova(fit.03,fit.04)


# What if instead we had allowed for both random intercepts and random slopes?
# fit the 1st model
fit.05 <- gls(tolerance ~ time, data=tolerance_tidy, method="ML") # using centered age (i.e. time) for increased interpretability
summary(fit.05)
# fit the 2nd model
fit.06 <- lme(tolerance ~ time, random = (~ time | id), data=tolerance_tidy, method="ML")
summary(fit.06)
# compare the two using likelihood-ratio(LR)
anova(fit.05,fit.06)
# Based on what we saw above, can you plot these fitted models? (i.e. fit.05 and fit.06)

################################################################################################################
# ******************************* BtheB dataset
################################################################################################################
load("WedEx/BtheB_tidy.RData")

head(BtheB.tidy)
     
BtheB.tidy <- na.omit(BtheB.tidy)

BtheB.tidy$time <- as.numeric(BtheB.tidy$timepoint)

BtheB.tidy$indiv <- factor(BtheB.tidy$indiv)

layout(matrix(1:2, nrow = 1))
ylim <- range(BtheB.tidy[, "bdi"],
                      na.rm = TRUE)

boxplot(BtheB.tidy[BtheB.tidy$treatment == "TAU",]$bdi ~  BtheB.tidy[BtheB.tidy$treatment == "TAU",]$time,
        main = "Treated as usual", ylab = "BDI",
        xlab = "Time (in months)", names = c(0, 2, 4,  6, 8), ylim = ylim)

boxplot(BtheB.tidy[BtheB.tidy$treatment == "BtheB",]$bdi ~  BtheB.tidy[BtheB.tidy$treatment == "BtheB",]$time,
        main = "Treated as usual", ylab = "BDI",
        xlab = "Time (in months)", names = c(0, 2, 4,  6, 8), ylim = ylim)


fit.00 <- gls(bdi ~ 1, data=BtheB.tidy, method="ML") # using centered age (i.e. time) for increased interpretability


fit.00 <- gls(bdi ~ treatment + length + (time|subject), data=BtheB.tidy, method="ML") # using centered age (i.e. time) for increased interpretability




########################################################

# multi-level / mixed-effects modeling
library(nlme)

# let's begin by assessing the need for a multi-level model
# First, we will fit a baseline model (only including an intercept) using ML
# Next, we will fit another model that allows intercepts to vary between clusters (i.e. a random intercept model)
# finally we compare the two models to see if the fit has improved as a result of allowing intercepts to vary
# fit the 1st model
fit.00 <- gls(bdi ~ 1, data=BtheB.tidy, method="ML") # using centered age (i.e. time) for increased interpretability
summary(fit.00)
# plot fit.00
plot(BtheB.tidy$timepoint_num, BtheB.tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
fit.00$coefficients
abline(h=1.619375, col="red", lwd=2)
# fit the 2nd model
fit.01 <- lme(tolerance ~ 1, random = (~ 1 | id), data=BtheB.tidy, method="ML")
summary(fit.01)
fit.01$coefficients
# plot fit.01 for patient "978" and compare with fit.00
plot(BtheB.tidy$age, BtheB.tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
points(BtheB.tidy$age[BtheB.tidy$id=="978"], BtheB.tidy$tolerance[BtheB.tidy$id=="978"], col="blue", pch=16)
fit.01$coefficients
abline(h = fit.01$coefficients$fixed, col="red", lwd=2)
fit.01$coefficients$fixed + unlist(fit.01$coefficients$random)[12]
abline(h = fit.01$coefficients$fixed + unlist(fit.01$coefficients$random)[12], col="blue", lwd=2)
# plot fit.01 for all individual
plot(BtheB.tidy$age, BtheB.tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
abline(h = fit.01$coefficients$fixed + unlist(fit.01$coefficients$random), col="blue", lwd=2)
# compare the two using AIC, BIC, and likelihood-ratio(LR)
anova(fit.00,fit.01)
# keeping in mind that the assumptions of the LR test is that:
# i) models were fit using ML
# ii) model are nested
# both assumption were met and p-val<0.05; therefore we can conclude that allowing for random intercepts significantly improved the fit
# let's move on by adding in covarites


# What if instead of random intercepts, we had allowed for random slopes?
# We have no reason to believe that individuals should share a baseline value (i.e. fixed intercept), but let's try it anyways for the sake of completeness
# fit the 1st model
fit.03 <- gls(tolerance ~ time, data=BtheB.tidy, method="ML") # using centered age (i.e. time) for increased interpretability
summary(fit.03)
# plot fit.03
plot(BtheB.tidy$age, BtheB.tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
fit.03$coefficients
abline( gls(tolerance ~ age, data=BtheB.tidy, method="ML"), col="red", lwd=2)
# fit the 2nd model
fit.04 <- lme(tolerance ~ time, random = (~ -1 + time | id), data=BtheB.tidy, method="ML")
summary(fit.04)
fit.04$coefficients
# plot fit.04 for patient "978" and compare with fit.03
plot(BtheB.tidy$age, BtheB.tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
points(BtheB.tidy$age[BtheB.tidy$id=="978"], BtheB.tidy$tolerance[BtheB.tidy$id=="978"], col="blue", pch=16)
predict.fit.04 <- predict(fit.04, newdata=data.frame(time=seq(0,4,length.out=100), id="978"))
lines(seq(11,15,length.out=100), predict.fit.04, col="blue", lwd=2)
# plot fit.04 for all individual
plot(BtheB.tidy$age, BtheB.tidy$tolerance, ylim=c(0,4), ylab="tolerance", xlab="age")
id <- as.character(unique(tolerance_untidy$id))
for (i in 1:length(id)) {
  predict.fit.04 <- predict(fit.04, newdata=data.frame(time=seq(0,4,length.out=100), id=id[i]))
  lines(seq(11,15,length.out=100), predict.fit.04, col="blue", lwd=1)
}
# compare the two using AIC, BIC, and LR
anova(fit.03,fit.04)


# What if instead we had allowed for both random intercepts and random slopes?
# fit the 1st model
fit.05 <- gls(tolerance ~ time, data=BtheB.tidy, method="ML") # using centered age (i.e. time) for increased interpretability
summary(fit.05)
# fit the 2nd model
fit.06 <- lme(tolerance ~ time, random = (~ time | id), data=BtheB.tidy, method="ML")
summary(fit.06)
# compare the two using likelihood-ratio(LR)
anova(fit.05,fit.06)
# Based on what we saw above, can you plot these fitted models? (i.e. fit.05 and fit.06)

################################################################################################################
# ******************************* TOLERANCE DATASET
################################################################################################################

