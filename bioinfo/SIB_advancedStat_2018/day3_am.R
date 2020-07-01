summary(lm(antilib$harvwt ~ antilib$site))

# 1st 1:  1 -> we want an intercept
# fixed factor:intercept -> the only fixed factor that we want estimate is the grant mean (mean of the all data)
# site will influence the mean of the fixed factor
# harvwt ~ 1 + (1|site), data = ant11b


# estimate for the inecept will be the same if using lm
# 1 mean and 42 points around the mean
# here: we split thevariability in 2 -> 0,76 var. for the residuals
# 1. 539 variability for the sites
# they are dispersed, but part of this variability can be explained by the random factor
# p-values based on less variability 
# -> clear up the data, variability not just noise, variability left is lower -> lower p-value (variability decreases)

# mixed models: takes care of different in base line but not of autocorrelation

# random effects: 
# -> not an estimate of each size based on the mean of each group [this is what we want to avoid by not using lm]
# this is the BLUPs
# close to the means, but not exactly the means
# mean of each group -> groups are independent
# assumption of the mixed model: 8 sites come from the same distribution (sample from random distribution)
# variance of normal distribution depends on all sites. mean of the sites depend on the mean of all the other -> shrinkage estimate
# if a site is particularly high, random effect constraints from normal distriution by the o ther size
# variance will depend on the large site but all other sites
# for the lowest ones, the estimate will be higher; higher toward the grand mean
# come from the same distribution -> they share informaton across sites


# ANOVA with random effects
# iterative process to maximize the likelihood
# optimization -> different computers can find different results
# not based on exact formula, will not work with complicated models

# cannot compute exact p-values
# important even more than usual to look at the order of magnitude


# Penicillin example: no fixed effect
# we just want to know if the effect changes across conditions
# we are not interested in the fixed effect

# Rat example:
# ensure to make very clear what is nested !!! 
# to treat replicates correctly
# if implicitly nested -> R will not know

# you can extend to  mixed GLM

# random extend on the slope:
# effet aléatoire sur la pente -> le facteur random fait effet sur la variable fixe par une interaction
# regarder graphiquement si entre les différents levels de la variable fixe c est la pente qui change
# plus compliqué à interpréter, si on peut on évite de le faire
# si la variable sur laquelle le random agit est discrète: distribution normale de l'effet aléatoire pas la même
# pour les niveaux du facteur fixe -> horrible à interpréter

#***************************************************************************************
#*************************************************************************************** EXERCISE 1
#***************************************************************************************
library(lme4)
library(lattice)
library(DAAG) 

str(ant111b)
summary(ant111b) 

#####
# 1)
#####

# dotplot of the number of ears by site, sorting by mean ears as follows:
  
dotplot(reorder(site, ears) ~ ears, ant111b, xlab = "Number of ears of corn",
          ylab = "Site", pch = 19, aspect = 0.32, type = c("p", "a")) 
  
  
# a. Comment on your plot - do any effects seem to contribute to the variation in ears?   
# yes there is variation across sites

#####
# 2)
#####

# fit a model with random effects
(ears.lmer <- lmer(ears ~ 1 + (1 | site), data=ant111b))

# b. Find the grand mean.
(grandMean <- as.numeric(fixef(ears.lmer)))

# c. Make a table showing the sample mean and fitted value for each site (there is sample code in the slides from the lecture). 
# Note that the fitted values are not just the sample means, but are between the grand mean and individual group sample means.
fittedVal <- ranef(ears.lmer)$site + grandMean
# same as
fitted(ears.lmer)
(tmp <- aggregate(ears ~ site, FUN=mean, data = ant111b))


# d. Give the estimated variance for each source of variation, σ2site and σ2Residual. 
# Which source of variation is larger? What proportion of variation is due to differences between sites?
print(VarCorr(ears.lmer), comp="Variance")


# e. Make a caterpillar plot for the random effects. Does the plot support your conclusion about the source of variation? 
# Which site(s) are most 'unusual'? 
# Caterpillar plot:
dotplot(ranef(ears.lmer, postVar = TRUE), strip = FALSE)[[1]] 
# yes. NSAN

#####
# 3)
#####

# a. check the model assumptions with a few diagnostic plots.
# there should be no apparent trend
plot(fitted(ears.lmer), residuals(ears.lmer), main="residual plot", pch=19)
abline(h=0, lty=2)
# The residuals should also be normally distributed. 
qqnorm(resid(ears.lmer))
qqline(resid(ears.lmer))
# What do you conclude? 
# ok maybe not so good in the extreme values
  
#***************************************************************************************
#*************************************************************************************** EXERCISE 2
#***************************************************************************************

library(WWGbook) 
library(lattice)


#####
# 1)
#####

attach(rat.brain)
str(rat.brain)
summary(rat.brain)

# In order to use treatment and region correctly in the model, they will each need to be coded as a factor (what type of variables are they now?):
  
region.f <- region
region.f[region == 1] <- 1
region.f[region == 2] <- 2
region.f[region == 3] <- 0
region.f <- factor(region.f)
levels(region.f) <- c("VST", "BST", "LS")

treat <- factor(treatment)
levels(treat) <- c("Basal","Carbachol")

rat.brain <- data.frame(rat.brain, region.f, treat)

str(rat.brain)
summary(rat.brain)

dotplot(reorder(animal, activate) ~ activate, rat.brain,
        groups = region.f, ylab = "Animal", xlab = "Activate", pch=19,
        type = c("p", "a"), auto.key=list(columns=3, lines=TRUE))

# Let's look at each rat/treatment combination separately:
rat.brain$rt <- with(rat.brain, treat:factor(animal))
dotplot(reorder(rt, activate) ~ activate, rat.brain, groups = region.f,
ylab = "Animal", xlab = "Activate", pch=19,
type = c("p", "a"), auto.key=list(columns=3, lines=TRUE))

# Each rat separately:
xyplot(activate ~ treat | animal, rat.brain, aspect = "xy", layout = c(5,1),
groups=region.f, pch=19, type=c("p", "l", "g"),
index.cond = function(x,y) coef(lm(y~x))[1], xlab = "Treatment",
ylab="Activate", auto.key=list(space="top",lines=TRUE,columns=3))

# Separated by treatment group:
xyplot(activate ~ region.f|treat, rat.brain, groups = animal, pch=19,
ylim=c(0,800), xlab="Region", ylab="Activate",
type = c("p","a"), auto.key = list(space="top"))

# Does the treatment appear to have an effect? Why do you say that? 
# Does the effect (if any) appear to be the same in each region? 
# Do there appear to be rat-specific effects?

# effect of the treatment different in the region
# different effect in the different rats

#####
# 2)
#####

# fit a model including all fixed effects 
# (main effects and interactions for the treatment and region variables - make sure to use the factor versions) 
# and a random effect for animal. 

(rat.brain.lmer1 <- lmer(activate ~ region.f*treat + (1|animal), REML=TRUE, data = rat.brain))

# Make sure that you know how to interpret the coefficients (the interpretation will be determined by the coding).

#####
# 3)
#####

# From the plot above, we saw that between-animal variation was greater for the carbachol treatment than for the basal treatment. 
# To accommodate this difference in variation, we can add a random animal-specific effect of treatment to the model. 
# The effect of treatment is fixed in our original model, therefore constant across all animals. 
# The additional random effect associated with treatment that we include in the new model allows the 
# implied marginal variance of observations for the carbachol treatment to differ from that for the basal treatment. 
# (We can also think of the new model as having two random intercepts per rat, one for the carbachol treatment and an 
#   additional one for the basal treatment.)

(rat.brain.lmer2 <- lmer(activate ~ region.f*treat + (treat |animal), REML=TRUE, data = rat.brain))

# What happens to the estimated fixed effects coefficients? What about their standard errors?

#####
# 4)
#####

# We can compare the models using a likelihood ratio (LR) test, carried out with the anova function. 
# The anova method for mer objects carries out a ML (not REML) LR test, even if the model has been fit by REML. 
# The results are not identical for the two methods, but in this case the conclusions are the same.

anova(rat.brain.lmer1, rat.brain.lmer2)

# Here, there are 2 parameters that are different in the null and alternative models: the variance of the random treatment effects 
# and the covariance of the two random effects (intercept and treatment). 
# The other parameter, the variance of the random intercepts, is retained in both models. 
# Again because of the boundary condition, the (asymptotic) distribution of -2*LR is not χ2 with 2 df, 
# but is a 50-50 mixture of a χ2 with 1 df and a χ2 with 2 df. (Ask me if you really want to know why!) 
# So the p-value will be conservative in this respect (although generally also anti-conservative due to the small sample). 
# The p-value here is very highly significant in any case, so we would reject the null and retain the additional parameters in the model.

# The χ2 distribution relies on asymptotic (large-sample) theory, so we would not usually carry out this type of test 
# (or even fit a model with this many parameters!) for such a small data set (only 5 rats). 
# Rather, in practice, the random effects would probably be retained without testing, 
# so that the appropriate marginal variance-covariance structure would be obtained for the data set. 
# We have looked at these as an illustration and for a little practice in carrying out and interpreting the test results. 
# A different approach to analysis of these data would be to fit a model on the treatment differences for each rat.


#####
# 5)
#####
# some diagnostics for the final model.

# Residual plot:
fit <- fitted(rat.brain.lmer2)
res <- resid(rat.brain.lmer2)
plotres.fit <- data.frame(rat.brain, fit, res)
xyplot(res ~ fit, data=plotres.fit, groups=treat, pch=19, xlab="Predicted value",
ylab="Residual", abline=0, auto.key=list(space="top", columns=2))

# QQ normal plot:
qqnorm(resid(rat.brain.lmer2))
qqline(resid(rat.brain.lmer2))

# What do you conclude?
# looks rather good
  
# random effect on slope ? # for categorical var ?
# 









