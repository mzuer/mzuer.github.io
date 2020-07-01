
#************ SUMMARY
# # fit quadratic, cubic fit (fit polynomials of degree "n"):
# fit.mod <- lm( Y ~ poly(X, degree=n) ) # using orthogonal polynomials
# 
# # fit piecewise step functions with "n" breaks
# 
# fit.mod <- lm( Y ~ cut(X,breaks=n) )
# 
# 
# # fitting piecewise cubic splines with 1 internal knot
# 
# fit.mod.left <- lm( Y ~ poly(X,3), subset=(X<575) )
# fit.mod.right <- lm( Y ~ poly(X,3), subset=(X>=575) )
# 
# 
# # fitting piecewise cubic splines with 1 internal knot and imposing continuity
# lhs <- function(x) ifelse(x<575, 575-x, 0)
# rhs <- function(x) ifelse(x<575, 0, x-575)
# 
# fit.mod <- lm( Y ~ poly(lhs(X),3) + poly(rhs(X),3) ) # only one of the 2 will not be 0
# summary(fit.mod)


#************ QUESTIONS AND ANSWERS

# choice of ns, bs ?
# poly ?
# smooth spline or regression spline ?
### Better to choosee regression or smoothing splines ?
# regression spline better if data sparsely distributed
# smoothing spline better if equally distributed data (can choose where to put knots where )
# (smoothing try to go to all points, does not insert knots, will not fit well if some points very distant)

### bs() or ns()
# B-spline = piecewise polynomial and set degree in the code
# we can divide manually the knots piecewise polynomial 
# but in addition to what we can do manually, bs() apply the criterion for the derivative
# (bs apply the criteria for the derivative (comparé à quand fait manuellement))
# ns() => adds another constrain about what happens behind the boundaries (fit line whhen beyond the input range)
# ns() is useful when we want to also make predictions behind the ranges

### Orthogonal polynomials ?
# theoretically, always better to use the orthogonals
# (for 2nd degree, might not change a lot, but if a lot of predictors, becomes critical)
# because with a lot of predictors, become correlated
# at which degree it becomes critical -> depends of sample size and level of correlation between the polynomials
# might not change a lot the result, but likely to be critical with a lot of predictors
# e.g. for 10, least square will break down if not using orthogonal because too much correlated
# ! poly() includes the intermediate powers (but with I() will need to be done manually)

# kernel methods: same aim as other smoothing methods. Might be more appropriate for multivariate,
# if you have multiple predictors.


# Advanced Statistics: Statistical Modeling; Aug 20-23, 2018
# Data and R code for "Moving Beyond Linearity"

########################################################

# Janka hardness data

library(SemiPar)
data(janka)
attach(janka)
plot(dens,hardness, ylab="response", xlab="X", main="Janka data")
plot(dens,log(hardness), ylab="response", xlab="X", main="Janka data")

########################################################

# fitting a linear and quadratic fit to janka data

# linear fit
plot(dens,log(hardness), ylab="response", xlab="X")
fit.linear <- lm( log(hardness) ~ dens )
abline(fit.linear, lwd=2, col="red")
plot(fit.linear$fitted.values, fit.linear$residuals, ylim=c(-max(range(fit.linear$residuals)),max(range(fit.linear$residuals))), ylab="residuals", xlab="fitted values")
abline(a=0, b=0, col="blue", lwd=2)

# quadratic fit
plot(dens,log(hardness), ylab="response", xlab="X")
# fit.quad <- lm( log(hardness) ~ dens + I(dens^2), data=janka)
fit.quad <- lm( log(hardness) ~ poly(dens, degree=2) ) # using orthogonal polynomials
fit.quad_MZ <- lm( log(hardness) ~ dens + I(dens^2) ) # using orthogonal polynomials
dens.range <- range(dens)
dens.grid <- seq(from=dens.range[1], to=dens.range[2], length.out=100)
predict_fit.quad <- predict(fit.quad, newdata=list(dens=dens.grid))
lines(dens.grid, predict_fit.quad, col="red", lwd=2)
# predict_fit.quad_MZ <- predict(fit.quad_MZ, newdata=list(dens=dens.grid))
# lines(dens.grid, predict_fit.quad_MZ, col="orange", lwd=2)

plot(fit.quad$fitted.values, fit.quad$residuals, ylim=c(-max(range(fit.quad$residuals)),max(range(fit.quad$residuals))), ylab="residuals", xlab="fitted values")
abline(a=0, b=0, col="blue", lwd=2)

# remove the junk
rm(fit.linear, fit.quad, predict_fit.quad, dens.range, dens.grid)
rm(fit.quad_MZ)

########################################################

# light detection and ranging (LIDAR) data

library(SemiPar)
data(lidar)
attach(lidar)
plot(range,logratio, ylab="response", xlab="X", main="LIDAR data")

########################################################

# fitting polynomials of degree 3, 4, and 10 to lidar data

# cubic fit
plot(range,logratio, ylab="response", xlab="X")
fit.cubic <- lm( logratio ~ poly(range,3) )
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
predict_fit.cubic <- predict(fit.cubic, newdata=list(range=range.grid))
lines(range.grid, predict_fit.cubic, col="red", lwd=2)
plot(fit.cubic$fitted.values, fit.cubic$residuals, ylim=c(-max(range(fit.cubic$residuals)),max(range(fit.cubic$residuals))), ylab="residuals", xlab="fitted values")
abline(a=0, b=0, col="blue", lwd=2)

# quadratic fit
plot(range,logratio, ylab="response", xlab="X")
fit.quad <- lm( logratio ~ poly(range,4) )
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
predict_fit.quad <- predict(fit.quad, newdata=list(range=range.grid))
lines(range.grid, predict_fit.quad, col="red", lwd=2)
plot(fit.quad$fitted.values, fit.quad$residuals, ylim=c(-max(range(fit.quad$residuals)),max(range(fit.quad$residuals))), ylab="residuals", xlab="fitted values")
abline(a=0, b=0, col="blue", lwd=2)

# polynomial degree 10
plot(range,logratio, ylab="response", xlab="X")
fit.poly10 <- lm( logratio ~ poly(range,10) )
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
predict_fit.poly10 <- predict(fit.poly10, newdata=list(range=range.grid))
lines(range.grid, predict_fit.poly10, col="red", lwd=2)
plot(fit.poly10$fitted.values, fit.poly10$residuals, ylim=c(-max(range(fit.poly10$residuals)),max(range(fit.poly10$residuals))), ylab="residuals", xlab="fitted values")
abline(a=0, b=0, col="blue", lwd=2)

# remove the junk
rm(fit.cubic, fit.quad, fit.poly10, predict_fit.cubic, predict_fit.quad, predict_fit.poly10, range.range, range.grid)

########################################################

# pointwise standard errors for the cubic fit to lidar data

plot(range,logratio, ylab="response", xlab="X")
fit.cubic <- lm( logratio ~ poly(range,3) )
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
predict_fit.cubic <- predict(fit.cubic, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.cubic$fit, col="red", lwd=2)
lines(range.grid, predict_fit.cubic$fit + 2 * predict_fit.cubic$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.cubic$fit - 2 * predict_fit.cubic$se.fit, col="red", lwd=2, lty=2)

########################################################

# Fitting piecewise step functions to lidar data

plot(range,logratio, ylab="response", xlab="X")

table(cut(range, breaks=3)) # note that you need to specify the number of breaking points
# (390,500] (500,610] (610,720] 
# 74        74        73

fit.pwsf <- lm( logratio ~ cut(range,breaks=3) )
summary(fit.pwsf)

plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
predict_fit.pwsf <- predict(fit.pwsf, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.pwsf$fit, col="red", lwd=2)
lines(range.grid, predict_fit.pwsf$fit + 2 * predict_fit.pwsf$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.pwsf$fit - 2 * predict_fit.pwsf$se.fit, col="red", lwd=2, lty=2)

########################################################

# fitting piecewise linear fits to lidar data

fit.left.linear.1knot <- lm( logratio ~ range, subset=(range<575) )
fit.right.linear.1knot <- lm( logratio ~ range, subset=(range>=575) )

summary(fit.left.linear.1knot)
summary(fit.right.linear.1knot)

# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid.left <- seq(from=range.range[1], to=575, length.out=50)
range.grid.right <- seq(from=575, to=range.range[2], length.out=50)

# predict the fit on the grid
# left
predict_fit.left.linear.1knot <- predict(fit.left.linear.1knot, newdata=list(range=range.grid.left), se.fit=TRUE)
lines(range.grid.left, predict_fit.left.linear.1knot$fit, col="red", lwd=2)
lines(range.grid.left, predict_fit.left.linear.1knot$fit + 2 * predict_fit.left.linear.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid.left, predict_fit.left.linear.1knot$fit - 2 * predict_fit.left.linear.1knot$se.fit, col="red", lwd=2, lty=2)
# right
predict_fit.right.linear.1knot <- predict(fit.right.linear.1knot, newdata=list(range=range.grid.right), se.fit=TRUE)
lines(range.grid.right, predict_fit.right.linear.1knot$fit, col="red", lwd=2)
lines(range.grid.right, predict_fit.right.linear.1knot$fit + 2 * predict_fit.right.linear.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid.right, predict_fit.right.linear.1knot$fit - 2 * predict_fit.right.linear.1knot$se.fit, col="red", lwd=2, lty=2)
# indicate the breakpoint
abline(v=575, col="blue", lwd=2, lty=2)

########################################################

# fitting piecewise linear fits with continuty at knot(s) to lidar data

# here is a trick to impose continuty
lhs <- function(x) ifelse(x<575, 575-x, 0)
rhs <- function(x) ifelse(x<575, 0, x-575)

fit.linear.1knot <- lm( logratio ~ lhs(range) + rhs(range) )
summary(fit.linear.1knot)

# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)

# predict the fit on the grid
predict_fit.linear.1knot <- predict(fit.linear.1knot, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.linear.1knot$fit, col="red", lwd=2)
lines(range.grid, predict_fit.linear.1knot$fit + 2 * predict_fit.linear.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.linear.1knot$fit - 2 * predict_fit.linear.1knot$se.fit, col="red", lwd=2, lty=2)

# indicate the breakpoint
abline(v=575, col="blue", lwd=2, lty=2)

########################################################

# fitting piecewise cubic splines to lidar data with 1 internal knot

fit.left.cubic.1knot <- lm( logratio ~ poly(range,3), subset=(range<575) )
fit.right.cubic.1knot <- lm( logratio ~ poly(range,3), subset=(range>=575) )

summary(fit.left.cubic.1knot)
summary(fit.right.cubic.1knot)

# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid.left <- seq(from=range.range[1], to=575, length.out=50)
range.grid.right <- seq(from=575, to=range.range[2], length.out=50)

# predict the fit on the grid
# left
predict_fit.left.cubic.1knot <- predict(fit.left.cubic.1knot, newdata=list(range=range.grid.left), se.fit=TRUE)
lines(range.grid.left, predict_fit.left.cubic.1knot$fit, col="red", lwd=2)
lines(range.grid.left, predict_fit.left.cubic.1knot$fit + 2 * predict_fit.left.cubic.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid.left, predict_fit.left.cubic.1knot$fit - 2 * predict_fit.left.cubic.1knot$se.fit, col="red", lwd=2, lty=2)
# right
predict_fit.right.cubic.1knot <- predict(fit.right.cubic.1knot, newdata=list(range=range.grid.right), se.fit=TRUE)
lines(range.grid.right, predict_fit.right.cubic.1knot$fit, col="red", lwd=2)
lines(range.grid.right, predict_fit.right.cubic.1knot$fit + 2 * predict_fit.right.cubic.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid.right, predict_fit.right.cubic.1knot$fit - 2 * predict_fit.right.cubic.1knot$se.fit, col="red", lwd=2, lty=2)
# indicate the breakpoint
abline(v=575, col="blue", lwd=2, lty=2)

########################################################

# fitting piecewise cubic splines with continuty at the internal knot to lidar data

# here is a trick to impose continuty
lhs <- function(x) ifelse(x<575, 575-x, 0)
rhs <- function(x) ifelse(x<575, 0, x-575)

fit.cubic.1knot <- lm( logratio ~ poly(lhs(range),3) + poly(rhs(range),3) )
summary(fit.cubic.1knot)

# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)

# predict the fit on the grid
predict_fit.cubic.1knot <- predict(fit.cubic.1knot, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.cubic.1knot$fit, col="red", lwd=2)
lines(range.grid, predict_fit.cubic.1knot$fit + 2 * predict_fit.cubic.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.cubic.1knot$fit - 2 * predict_fit.cubic.1knot$se.fit, col="red", lwd=2, lty=2)

# indicate the breakpoint
abline(v=575, col="blue", lwd=2, lty=2)

########################################################

# bs() and ns() automatically imposes continuity; gives the column in orthogonal way
# not exactly as when done manually because works on orthogonal bases (for computational reasons)

# fitting linear splines to lidar data

library(splines) # we can use the splines package to creat spline basis functions

?bs
# B-Spline Basis for Polynomial Splines
bs(range) # by default sets degree=3; alternatively you can set "df" where corresponds to "df - degree" knots at quantiles of X
bs(range, knots=2)

fit.ls.1knot <- lm( logratio ~ bs(range, knots=575, degree=1) )
summary(fit.ls.1knot)
# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
# predict the fit on the grid
predict_fit.ls.1knot <- predict(fit.ls.1knot, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.ls.1knot$fit, col="red", lwd=2)
lines(range.grid, predict_fit.ls.1knot$fit + 2 * predict_fit.ls.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.ls.1knot$fit - 2 * predict_fit.ls.1knot$se.fit, col="red", lwd=2, lty=2)
abline(v=575, col="blue", lwd=2, lty=2)


### repeat above with 2 internal knots at desired points
fit.ls.2knots <- lm( logratio ~ bs(range, knots=c(550,600), degree=1) )
summary(fit.ls.2knots)
# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
# predict the fit on the grid
predict_fit.ls.2knots <- predict(fit.ls.2knots, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.ls.2knots$fit, col="red", lwd=2)
lines(range.grid, predict_fit.ls.2knots$fit + 2 * predict_fit.ls.2knots$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.ls.2knots$fit - 2 * predict_fit.ls.2knots$se.fit, col="red", lwd=2, lty=2)
abline(v=c(550,600), col="blue", lwd=2, lty=2)

########################################################

# fitting cubic splines to lidar data

# 1 internal knot
### fit cubic splines with 1 internal knot
fit.cs.1knot <- lm( logratio ~ bs(range, knots=575) )
summary(fit.cs.1knot)
# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
# predict the fit on the grid
predict_fit.cs.1knot <- predict(fit.cs.1knot, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.cs.1knot$fit, col="red", lwd=2)
lines(range.grid, predict_fit.cs.1knot$fit + 2 * predict_fit.cs.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.cs.1knot$fit - 2 * predict_fit.cs.1knot$se.fit, col="red", lwd=2, lty=2)
abline(v=575, col="blue", lwd=2, lty=2)


# 2 internal knots
fit.cs.2knots <- lm( logratio ~ bs(range, knots=c(550,600)) )
summary(fit.cs.2knots)
# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
# predict the fit on the grid
predict_fit.cs.2knots <- predict(fit.cs.2knots, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, predict_fit.cs.2knots$fit, col="red", lwd=2)
lines(range.grid, predict_fit.cs.2knots$fit + 2 * predict_fit.cs.2knots$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, predict_fit.cs.2knots$fit - 2 * predict_fit.cs.2knots$se.fit, col="red", lwd=2, lty=2)
abline(v=c(550,600), col="blue", lwd=2, lty=2)

########################################################

# repeat above using natural splines: ns(...)

# with 1 knot:
ns_fit.cs.1knot <- lm( logratio ~ ns(range, knots=575) )
summary(ns_fit.cs.1knot)
# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
# predict the fit on the grid
ns_predict_fit.cs.1knot <- predict(ns_fit.cs.1knot, newdata=list(range=range.grid), se.fit=TRUE)
lines(range.grid, ns_predict_fit.cs.1knot$fit, col="red", lwd=2)
lines(range.grid, ns_predict_fit.cs.1knot$fit + 2 * predict_fit.cs.1knot$se.fit, col="red", lwd=2, lty=2)
lines(range.grid, ns_predict_fit.cs.1knot$fit - 2 * predict_fit.cs.1knot$se.fit, col="red", lwd=2, lty=2)
abline(v=575, col="blue", lwd=2, lty=2)



########################################################

# smoothing splines

ss_fit <- smooth.spline( logratio ~ range )
summary(ss_fit)
# plot raw data
plot(range,logratio, ylab="response", xlab="X")
range.range <- range(range)
range.grid <- seq(from=range.range[1], to=range.range[2], length.out=100)
# predict the fit on the grid
ss_fit_predict <- predict(ss_fit, newdata=list(range=range.grid), se.fit=TRUE)
# preidct.smooth.spline -> only returns x and y 
lines(range.grid, ss_fit$y, col="red", lwd=2)
# lines(range.grid, ss_fit$fit, col="red", lwd=2)
# lines(range.grid, ss_fit$fit + 2 * ss_fit$se.fit, col="red", lwd=2, lty=2)
# lines(range.grid, ss_fit$fit - 2 * ss_fit$se.fit, col="red", lwd=2, lty=2)
abline(v=575, col="blue", lwd=2, lty=2)

# cv = parameter for cross-validation
# GCV better in the case of a lot of samples (?)
# if not enough data -> not enough data to sample
# if very densely sampled data -> can work with a subset of data

# smooth.spline is an optimization problem ! might fail (has a tolerance, might not converge, etc.)

########################################################


# choice of ns, bs ?
# poly ?
# smooth spline or regression spline ?

# if data sparsely distributed
# smoothing spline -> equally distributed data (can choose where to put knots where )
# B-spline = piecewise polynomial and set degree in the code
# (bs apply the criteria for the derivative (comparé à quand fait manuellement))
# ns = adds another constrain what happens behind the boundaries (fit line whhen beyond the range)
# if usefule -> whether make prediction behind the ranges (useful if we care aboutt what happens ehind te range)

# always better to use the orthogonals
# (if a lot of predictors, becomes critical)
# depend of sample size and level of correlation between the polynomials
# might not change a lot te results
# but with a lot of predictors
# e.g. for 10, least square will break down if not using orthogonal because too much correlated ()

