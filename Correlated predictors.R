# From week 2: Preprocessing with principal components analysis

library(caret)
library(kernlab)

data(spam)

inTrain <- createDataPartition(y=spam$type, p = 0.75, list = FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

M <- abs(cor(training[,-58])) # column 58 is outcome
diag(M) <- 0
which(M > 0.8, arr.ind = T)



# Principal components analysis

smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
plot(prComp$x[,1], prComp$x[,2])

prComp$rotation


# PCA with caret
typeColor <- ((spam$type=="spam")*1 +1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1], prComp$x[,2], col=typeColor, xlab="PC1", ylab="PC2")

preProc <- preProcess(log10(spam[,-58]+1), method = "pca", pcaComp = 2)
spamPC <- predict(preProc, log10(spam[,-58]+1))
plot(spamPC[,1], spamPC[,2], col=typeColor)
