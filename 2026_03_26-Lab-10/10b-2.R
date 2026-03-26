library(e1071)
library(caTools)
library(class)

# KNN Classifier Algorithm
data(ChickWeight)

# Splitting data into train and test data
split <- sample.split(ChickWeight, SplitRatio = 0.7) # 70% for training
train_cl <- subset(ChickWeight, split == "TRUE")
test_cl <- subset(ChickWeight, split == "FALSE")

# Feature Scaling
train_scale <- scale(train_cl[, 1:2])
test_scale <- scale(test_cl[, 1:2])

# Fitting KNN Model to training dataset
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train_cl$Diet,
                      k = 18) # number of nearest neighbours
print(classifier_knn)

# Confusion Matrix
cm <- table(test_cl$Diet, classifier_knn)
print(cm)

# Calculate out of Sample error
misClassError <- mean(classifier_knn != test_cl$Diet)
print(paste('Accuracy =', round((1-misClassError),2)))

