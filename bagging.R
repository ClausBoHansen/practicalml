
# Bagging can be useful for decision trees
# Bootstrap aggregation

# Example from week 3 in Practical Machine Learning

# Reduces variance, not bias
# Most useful for non-linear functions


library(ElemStatLearn)
data(ozone, package = "ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]
head(ozone)

# Bagged loess
ll <- matrix(NA, nrow = 10, ncol = 155)
for (i in 1:10){
  # Grab random sample with replacement
  ss <- sample(1:dim(ozone)[1], replace = T)
  # Put new random subset for this iteration of the loop in ozone0
  ozone0 <- ozone[ss,]
  # Reorder by the ozone variable
  ozone0 <- ozone0[order(ozone0$ozone),]
  # Fit a loess curve through the data
  loess0 <- loess(temperature ~ ozone, data = ozone0, span = 0.2)
  # Predict for ozone values between 1 and 155
  ll[i,] <- predict(loess0, newdata=data.frame(ozone=1:155))
}


# Plot individual and bagged result
# Plot observations
plot(ozone$ozone, ozone$temperature, pch=19, cex=0.5)
# Plot individual bootstraps
for (i in 1:10){
  lines(1:155, ll[i,], col = "grey", lwd=2)
}

# Plot bagged result
lines(1:155, apply(ll,2,mean), col="red",lwd=2)

