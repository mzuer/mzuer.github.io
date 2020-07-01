

# Advanced Statistics: Statistical Modeling; Aug 20-23, 2018
# Data and R code for "Generalized Additive Models"

########################################################

# Mid-Atlantic Wage Data : Wage and other data for a group of 3000 male workers in the Mid-Atlantic region.

# load the MAWage data set
load("MAWage.RData")

# explore the data
str(MAWage)

########################################################

### The goal is to build a predictive model for wage based on year, age, marital status, etc.

########################################################

# STEP1: Start by predicting wage using a forth-degree polynomial function of age.

plot(MAWage$wage ~ MAWage$age)

m1 <- lm(wage ~ poly(age, degree=5) , data = MAWage)
summary(m1)

plot(m1)
# does not look well !

# STEP2: Fit models ranging from linear to a degree-5 polynomial and seek to determine the simplest model which is sufficient to explain the relationship beytween wage and age.
# Hint: Use anova() to perform an F-test to compare nested models.
m2_1 <- lm(wage ~ age , data = MAWage)
summary(m2_1)

m2_2 <- lm(wage ~ poly(age, degree=2) , data = MAWage)
summary(m2_2)
anova(m2_2, m2_1)
# signif

m2_3 <- lm(wage ~ poly(age, degree=3) , data = MAWage)
summary(m2_3)
anova(m2_3, m2_2)
# signif

m2_4 <- lm(wage ~ poly(age, degree=4) , data = MAWage)
summary(m2_4)
anova(m2_4, m2_3) # not signif

m2_5 <- lm(wage ~ poly(age, degree=5) , data = MAWage)
summary(m2_5)
anova(m2_5, m2_4) # not signif

# computational advantage of poly compared to the I^

# STEP3: Consider the task of predicting whether an individual earns more than $250,000 per year.
# Hint: First create the appropriate response vector using I(), and then apply the glm() function using 
# family="binomial" in order to fit a polynomial logistic regression model.



# STEP4: Use a step function to model the relationship between wage and age.
# Hint: Use cut() to fit step functions.


plot(range,logratio, ylab="response", xlab="X")

table(cut(range, breaks=3)) # note that you need to specify the number of breaking points
# (390,500] (500,610] (610,720] 
# 74        74        73

m4 <- lm( wage ~ cut(age,breaks=3) , data = MAWage)
summary(m4)

plot(wage~age, data = MAWage)
range_age <- range(MAWage$age)
range_grid <- seq(from=range_age[1], to=range_age[2], length.out=100)
predict_fit_m4 <- predict(m4, newdata=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, predict_fit_m4$fit, col="red", lwd=2)
lines(range_grid, predict_fit_m4$fit + 2 * predict_fit_m4$se.fit, col="red", lwd=2, lty=2)
lines(range_grid, predict_fit_m4$fit - 2 * predict_fit_m4sf$se.fit, col="red", lwd=2, lty=2)



# STEP5: i) Fit wage to age using linear splines with internal knots at 25th, 50th and 75th percentiles of age.
#        ii) Repeat with a cubic spline.
#        iii) Test if using cubic splines improved the goodness of fit.
# Hint: Use bs() to fit splines

library(splines)

### linear spline
m5_linear <- lm( wage ~ bs(age, knots=c(as.numeric(quantile(MAWage$age)[1]),
                                            as.numeric(quantile(MAWage$age)[2]),
                                            as.numeric(quantile(MAWage$age)[3])), degree=1), data = MAWage )
summary(m5_linear)
# plot raw data

plot(wage~age, data = MAWage)
range_age <- range(MAWage$age)
range_grid <- seq(from=range_age[1], to=range_age[2], length.out=100)
predict_fit_m5a <- predict(m5_linear, newdata=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, predict_fit_m5a$fit, col="red", lwd=2)
lines(range_grid, predict_fit_m5a$fit + 2 * predict_fit_m5a$se.fit, col="red", lwd=2, lty=2)
lines(range_grid, predict_fit_m5a$fit - 2 * predict_fit_m5a$se.fit, col="red", lwd=2, lty=2)
# ????
# In predict.lm(m5_linear, newdata = data.frame(age = range_grid),  :
#                 prediction from a rank-deficient fit may be misleading
abline(v=c(as.numeric(quantile(MAWage$age)[1]),
           as.numeric(quantile(MAWage$age)[2]),
           as.numeric(quantile(MAWage$age)[3])), col="blue", lwd=2, lty=2)


### cubic spline
m5_cubic <- lm( wage ~ bs(age, knots=c(as.numeric(quantile(MAWage$age)[1]),
                                        as.numeric(quantile(MAWage$age)[2]),
                                        as.numeric(quantile(MAWage$age)[3])), degree=3), data = MAWage )
summary(m5_cubic)
# plot raw data

plot(wage~age, data = MAWage)
range_age <- range(MAWage$age)
range_grid <- seq(from=range_age[1], to=range_age[2], length.out=100)
predict_fit_m5b <- predict(m5_cubic, newdata=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, predict_fit_m5b$fit, col="red", lwd=2)
lines(range_grid, predict_fit_m5b$fit + 2 * predict_fit_m5b$se.fit, col="red", lwd=2, lty=2)
lines(range_grid, predict_fit_m5b$fit - 2 * predict_fit_m5b$se.fit, col="red", lwd=2, lty=2)
# ????
# In predict.lm(m5_cubic, newdata = data.frame(age = range_grid),  :
#                 prediction from a rank-deficient fit may be misleading
abline(v=c(as.numeric(quantile(MAWage$age)[1]),
           as.numeric(quantile(MAWage$age)[2]),
           as.numeric(quantile(MAWage$age)[3])), col="blue", lwd=2, lty=2)

anova(m5_linear, m5_cubic) # signif


# STEP6: i) Fit wage to age using smoothing splines.
#        ii) Assess the effect of varying "df" on the smooth. 


# smoothing splines
m6 <- smooth.spline( x=MAWage$age , y=MAWage$wage, df=1)
summary(m6)
# plot raw data
plot(wage~age, data = MAWage)
range_age <- range(MAWage$age)
range_grid <- seq(from=range_age[1], to=range_age[2], length.out=100)
predict_fit_m6 <- predict(m6, x=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, unlist(predict_fit_m6$y), col="red", lwd=2)

m6b <- smooth.spline( x=MAWage$age , y=MAWage$wage, df=2)
summary(m6b)
predict_fit_m6b <- predict(m6b, x=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, unlist(predict_fit_m6b$y), col="blue", lwd=2)

m6c <- smooth.spline( x=MAWage$age , y=MAWage$wage, df=3)
summary(m6c)
predict_fit_m6c <- predict(m6c, x=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, unlist(predict_fit_m6c$y), col="green", lwd=2)


# STEP7: i) Fit wage to age using a local regression (loess) with default parameters
#        ii) What does the parameter "span" refer to in the loess function? How does increasing the "span" affect the fit?

# span = the parameter α which controls the degree of smoothing

m7 <- loess(wage~age, data = MAWage, span = 0.75) # default
summary(m7)

m7b <- loess(wage~age, data = MAWage, span = 0.5) # default
summary(m7b)

m7c <- loess(wage~age, data = MAWage, span = 0.1) # default
summary(m7c)

# plot raw data
plot(wage~age, data = MAWage)
range_age <- range(MAWage$age)
range_grid <- seq(from=range_age[1], to=range_age[2], length.out=100)
predict_fit_m7 <- predict(m7, newdata = data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, predict_fit_m7, col="red", lwd=2)

summary(m7b)
predict_fit_m7b <- predict(m7b, newdata=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, predict_fit_m7b, col="blue", lwd=2)

summary(m7c)
predict_fit_m7c <- predict(m7c, newdata=data.frame(age=range_grid), se.fit=TRUE)
lines(range_grid, predict_fit_m7c, col="green", lwd=2)

# span= at each point wich portion of the data we want to include in the analysis (1 = take all the data, 0 = take none  of it)
# the larger the span the smoother the cureve

# STEP8: i) Fit a GAM to predict wage using natural splines of year and age, treating education as a qualitative predictor.
# Hint: Since this is just a big linear regression model using an appropriate choice of basis functions, we can simply do 
# this using the lm() function.

m8 <- lm(wage ~ year + age + education, data = MAWage)

# STEP9: i) load the library(gam) and try ?gam
#        ii) Try to repeat STEP8 using gam() with a smoothing spline smoother
#        iv) Try to repeat STEP8 using gam() with a loess smoother
#        v) Try plot() on the fitted gam objects

library(gam)

MAWage$education <- factor(MAWage$education, levels = levels(MAWage$education), ordered=T)

m9a <- gam(wage ~ s(year) + s(age) + education, data = MAWage)
# for the dummy variable -> no smoothing function!

m9b <- gam(wage ~ lo(year) + lo(age) + education, data = MAWage)

# STEP10: In the above plots, the function of year looks rather linear. Perform a series of ANOVA tests in order 
#  to determine which of these three models is best:
#         i) a GAM that excludes year (M1),
#         ii) a GAM that uses a linear function of year (M2),
#         iii) or a GAM that uses a spline function of year (M3).
#         iv) Make prediction on the training set (original data) using M2 from above.

# STEP11: i) Use lo() to allow for interaction between age and year in the GAM, treating education like before.
#         ii) We can plot the resulting two-dimensional surface if we first install the akima package (akima::plot)

# STEP12: i) Fit a logistic regression GAM, handling year with a linear function, age with a smoothign spline, and 
#  education with dummy variables like before.
#         ii) Repeat above after removing the "<HS" category.
#         iii) Use plot() to visualize the logistic regression GAMs.

########################################################

# CHAPTER 7 from "An introduction to statistical learning"


# confidence = accuracy of estimating the mean -> if you want to predict the mean trend
# prediction interval = takes also into account variability -> always wider than confidence intervals -> if you want to predict values



# anova: all models should be used to compare models fit with the same method 
# (e.g. all least squares; or lm fit ML to compare with mixed-model fit with ML)
# and models should be nested

# LRT: only possible with methods using ML (if based on least squares -> does not provide likelihood)
# (NB: ML is always the most accurate approach)

# when we use orthogonal polynomials, in that case removing one is find because has nothing to do
# with the other predictors -> we can use the p-values (we can assess the effect of the individual coefficients)
# with raw = TRUE, we cannot make any conclusion, because they are not independent

# Chapter 7 Lab: Non-linear Modeling

library(ISLR)
attach(Wage)

# Polynomial Regression and Step Functions

fit=lm(wage~poly(age,4),data=Wage)
coef(summary(fit))
fit2=lm(wage~poly(age,4,raw=T),data=Wage)
coef(summary(fit2))
fit2a=lm(wage~age+I(age^2)+I(age^3)+I(age^4),data=Wage)
coef(fit2a)
fit2b=lm(wage~cbind(age,age^2,age^3,age^4),data=Wage)
agelims=range(age)
age.grid=seq(from=agelims[1],to=agelims[2])
preds=predict(fit,newdata=list(age=age.grid),se=TRUE)
se.bands=cbind(preds$fit+2*preds$se.fit,preds$fit-2*preds$se.fit)
par(mfrow=c(1,2),mar=c(4.5,4.5,1,1),oma=c(0,0,4,0))
plot(age,wage,xlim=agelims,cex=.5,col="darkgrey")
title("Degree-4 Polynomial",outer=T)
lines(age.grid,preds$fit,lwd=2,col="blue")
matlines(age.grid,se.bands,lwd=1,col="blue",lty=3)
preds2=predict(fit2,newdata=list(age=age.grid),se=TRUE)
max(abs(preds$fit-preds2$fit))
fit.1=lm(wage~age,data=Wage)
fit.2=lm(wage~poly(age,2),data=Wage)
fit.3=lm(wage~poly(age,3),data=Wage)
fit.4=lm(wage~poly(age,4),data=Wage)
fit.5=lm(wage~poly(age,5),data=Wage)
anova(fit.1,fit.2,fit.3,fit.4,fit.5)
coef(summary(fit.5))
(-11.983)^2
fit.1=lm(wage~education+age,data=Wage)
fit.2=lm(wage~education+poly(age,2),data=Wage)
fit.3=lm(wage~education+poly(age,3),data=Wage)
anova(fit.1,fit.2,fit.3)
fit=glm(I(wage>250)~poly(age,4),data=Wage,family=binomial)
preds=predict(fit,newdata=list(age=age.grid),se=T)
pfit=exp(preds$fit)/(1+exp(preds$fit))
se.bands.logit = cbind(preds$fit+2*preds$se.fit, preds$fit-2*preds$se.fit)
se.bands = exp(se.bands.logit)/(1+exp(se.bands.logit))
preds=predict(fit,newdata=list(age=age.grid),type="response",se=T)
plot(age,I(wage>250),xlim=agelims,type="n",ylim=c(0,.2))
points(jitter(age), I((wage>250)/5),cex=.5,pch="|",col="darkgrey")
lines(age.grid,pfit,lwd=2, col="blue")
matlines(age.grid,se.bands,lwd=1,col="blue",lty=3)
table(cut(age,4))
fit=lm(wage~cut(age,4),data=Wage)
coef(summary(fit))

# Splines

library(splines)
fit=lm(wage~bs(age,knots=c(25,40,60)),data=Wage)
pred=predict(fit,newdata=list(age=age.grid),se=T)
plot(age,wage,col="gray")
lines(age.grid,pred$fit,lwd=2)
lines(age.grid,pred$fit+2*pred$se,lty="dashed")
lines(age.grid,pred$fit-2*pred$se,lty="dashed")
dim(bs(age,knots=c(25,40,60)))
dim(bs(age,df=6))
attr(bs(age,df=6),"knots")
fit2=lm(wage~ns(age,df=4),data=Wage)
pred2=predict(fit2,newdata=list(age=age.grid),se=T)
lines(age.grid, pred2$fit,col="red",lwd=2)
plot(age,wage,xlim=agelims,cex=.5,col="darkgrey")
title("Smoothing Spline")
fit=smooth.spline(age,wage,df=16)
fit2=smooth.spline(age,wage,cv=TRUE)
fit2$df
lines(fit,col="red",lwd=2)
lines(fit2,col="blue",lwd=2)
legend("topright",legend=c("16 DF","6.8 DF"),col=c("red","blue"),lty=1,lwd=2,cex=.8)
plot(age,wage,xlim=agelims,cex=.5,col="darkgrey")
title("Local Regression")
fit=loess(wage~age,span=.2,data=Wage)
fit2=loess(wage~age,span=.5,data=Wage)
lines(age.grid,predict(fit,data.frame(age=age.grid)),col="red",lwd=2)
lines(age.grid,predict(fit2,data.frame(age=age.grid)),col="blue",lwd=2)
legend("topright",legend=c("Span=0.2","Span=0.5"),col=c("red","blue"),lty=1,lwd=2,cex=.8)

# GAMs

gam1=lm(wage~ns(year,4)+ns(age,5)+education,data=Wage)
library(gam)
gam.m3=gam(wage~s(year,4)+s(age,5)+education,data=Wage)
par(mfrow=c(1,3))
plot(gam.m3, se=TRUE,col="blue")
plot.gam(gam1, se=TRUE, col="red")
gam.m1=gam(wage~s(age,5)+education,data=Wage)
gam.m2=gam(wage~year+s(age,5)+education,data=Wage)
anova(gam.m1,gam.m2,gam.m3,test="F")
summary(gam.m3)
preds=predict(gam.m2,newdata=Wage)
gam.lo=gam(wage~s(year,df=4)+lo(age,span=0.7)+education,data=Wage)
plot.gam(gam.lo, se=TRUE, col="green")
gam.lo.i=gam(wage~lo(year,age,span=0.5)+education,data=Wage)
library(akima)
plot(gam.lo.i)
gam.lr=gam(I(wage>250)~year+s(age,df=5)+education,family=binomial,data=Wage)
par(mfrow=c(1,3))
plot(gam.lr,se=T,col="green")
table(education,I(wage>250))
gam.lr.s=gam(I(wage>250)~year+s(age,df=5)+education,family=binomial,data=Wage,subset=(education!="1. < HS Grad"))
plot(gam.lr.s,se=T,col="green")


