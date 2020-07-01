# can we predict height using age, sex and weight ?

dataDT <- read.table("http://lausanne.isb-sib.ch/~schutz/data/class.txt")


mymodel <- lm(Height ~ Age + Gender + Weight, data = dataDT)
mymodel
summary(mymodel)

plot(Height ~ Weight, data = dataDT)
abline(lm(Height ~ Weight, data = dataDT))


plot(mymodel)

mymodel <- lm(Height ~ Age + Weight, data = dataDT)
mymodel
summary(mymodel)

#F-stat : for the full regression
# effect of one variable when all other variables are included in the model
# pvalue does not tell if the variale is important to predict, 
# tell if significant when the others are included
# (might be linked but not bring more infromation when the other variales are included)


# if remove a term but keep in the interaction -> impossible to interpret, huge error from a statistical point of view

lm.influence(mymodel)
# => returns the hat value for each point
# => average value of the hat values = # parameters/ # of datapoints



# predict cell concentration
# dataset: "diameter and concentration of cells with and without glucose added to growth medium"

library(ISwR)
data(hellung)
head(hellung)


m1 <- lm(conc ~ glucose, data = hellung)
summary(m1)
m1
plot(conc ~ glucose, data = hellung)
abline(m1)


m2 <- lm(conc ~ diameter, data = hellung)
summary(m2)
plot(conc ~ diameter, data = hellung)
abline(m2)

hellung$conc_log10 <- log10(hellung$conc)
m3 <- lm(conc_log10 ~ diameter, data = hellung)
summary(m3)
plot(conc_log10 ~ diameter, data = hellung)
abline(m3)

lm.influence(m3)$hat
plot(lm.influence(m3)$hat)
which.max(lm.influence(m3)$hat)

m4 <- lm(conc_log10 ~ diameter, data = hellung[-which.max(lm.influence(m3)$hat),])
summary(m4)
plot(conc_log10 ~ diameter, data = hellung[-which.max(lm.influence(m3)$hat),])
abline(m4)

lm.influence(m4)$hat
plot(lm.influence(m4)$hat)
which.max(lm.influence(m4)$hat)


# with knot -> might not be smooth (= not differentiable)
# can also go beyond the 2nd derivative (3d derivative etc.)
# force the derivatives to be equal

# before: polynomial, with constraints to meet value to meet at knot point
# here: force derivative to be equal
# "piecewise cubic", when we say "cubic splines" -> usually when we add these constraints
# if the goal is visualization, we never go to further than 2nd derivatives to be equal because we cannot see by eyes

# truncated power function

# smoothing splines adress the issue of where putting knots

# optimization: minimize this sum. Left term = usual residual, bias of the fit; the second term is the integral (sum)
# of the square of the second derivative (small values of derivative = fluctuates smoothly, indication of the curvature)
# we want to minimize the sum of squares as well as the curvature


# with mu = 0 -> go through all data points (zero biases)
# increasing mu -> smoother
# the oversmooth: perfect smooth curve = line, no fluctuation
# cross-validation to get the optimal (not undersmooth nor oversmooth)
