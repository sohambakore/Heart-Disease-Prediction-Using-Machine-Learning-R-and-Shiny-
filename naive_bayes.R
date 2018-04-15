# Naive Bayes

# Importing the dataset
dataset = read.csv('data.csv')
#dataset = dataset[3:5]

# Encoding the target feature as factor
dataset$num = factor(dataset$num, levels = c(0,1,2,3,4))
dataset$Sex = factor(dataset$Sex, levels = c(0, 1))
dataset$chesp.pain.type = factor(dataset$chesp.pain.type, levels = c(1,2,3,4))
dataset$fasting.blood.sugar = factor(dataset$fasting.blood.sugar, levels = c(0,1))
dataset$electrocardiographic = factor(dataset$electrocardiographic, levels = c(0, 1,2))
dataset$exercise.induced.angina = factor(dataset$exercise.induced.angina, levels = c(0, 1))
dataset$slope.of.peak.exercise = factor(dataset$slope.of.peak.exercise, levels = c(1,2,3))
#dataset$ca = factor(dataset$ca, levels = c( 0,1,2,3))
dataset$thal = factor(dataset$thal, levels = c( 3,6,7))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$num, SplitRatio = 0.80)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
#training_set[-3] = scale(training_set[-3])
#test_set[-3] = scale(test_set[-3])

# Fitting SVM to the Training set
# install.packages('e1071')a
library(e1071)
classifier = naiveBayes(x = training_set[-14],
                        y = training_set$num)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-14])

# Making the Confusion Matrix
cm = table(test_set[, 14], y_pred)

# 
# # Visualising the Training set results
# library(ElemStatLearn)
# set = training_set
# X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
# X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
# grid_set = expand.grid(X1, X2)
# colnames(grid_set) = c('Age', 'EstimatedSalary')
# y_grid = predict(classifier, newdata = grid_set)
# plot(set[, -3],
#      main = 'SVM (Training set)',
#      xlab = 'Age', ylab = 'Estimated Salary',
#      xlim = range(X1), ylim = range(X2))
# contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
# points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
# points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))
# 
# # Visualising the Test set results
# library(ElemStatLearn)
# set = test_set
# X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
# X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
# grid_set = expand.grid(X1, X2)
# colnames(grid_set) = c('Age', 'EstimatedSalary')
# y_grid = predict(classifier, newdata = grid_set)
# plot(set[, -3], main = 'SVM (Test set)',
#      xlab = 'Age', ylab = 'Estimated Salary',
#      xlim = range(X1), ylim = range(X2))
# contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
# points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
# points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))