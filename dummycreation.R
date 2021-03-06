# Example from week 2 in Practical Machine Learning

library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

dummies <- dummyVars(wage ~ jobclass, data=training)

head(predict(dummies, newdata = training))
