# Classification template

#importing the libraries
library(naivebayes)
library(e1071)
library(caTools)
library(caret)


# Importing the dataset
dataset = read.csv('data.csv')
#data_set = data.frame(dataset)


#Missing data correction
#dataset$thal <- as.numeric(as.character(dataset$thal))
#dataset$ca <- as.numeric(as.character(dataset$ca))
# na_vector <- which(!complete.cases(data_set))
# no_na_dataset <- dataset[-na_vector,]
# no_na_dataset <-  no_na_dataset[-88,]
# no_na_dataset <- no_na_dataset[-167,]
# no_na_dataset <-  no_na_dataset[-193,]
# no_na_dataset <-  no_na_dataset[-303,]
# no_na_dataset <-  no_na_dataset[-267,]
# no_na_dataset <-  no_na_dataset[-288,]

# na_omit <- na.omit(no_na_dataset)
# na_remove <- remove_missing(dataset)


# Encoding the target feature as factor
dataset$num = factor(dataset$num, levels = c(0,1,2,3,4))
dataset$Sex = factor(dataset$Sex, levels = c(0,1))
dataset$chesp.pain.type = factor(dataset$chesp.pain.type, levels = c(1,2,3,4))
dataset$fasting.blood.sugar = factor(dataset$fasting.blood.sugar, levels = c(0,1))
dataset$electrocardiographic = factor(dataset$electrocardiographic, levels = c(0,1,2))
dataset$exercise.induced.angina = factor(dataset$exercise.induced.angina, levels = c(0,1))
dataset$slope.of.peak.exercise = factor(dataset$slope.of.peak.exercise, levels = c(1,2,3))
dataset$ca = factor(dataset$ca, levels = c( 0,1,2,3))
dataset$thal = as.numeric(dataset$thal)


# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$num, SplitRatio = 0.70)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[-14] = scale(training_set[-14])
test_set[-14] = scale(test_set[-14])

# Fitting classifier to the Training set
# Create your classifier here

#install.packages("rpart")
library(rpart)
classifier = rpart(formula = num ~.,data = training_set)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-14], type = 'class')

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
#      main = 'Decison Tree (Training set)',
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
# plot(set[, -3], main = 'Classifier (Test set)',
#      xlab = 'Age', ylab = 'Estimated Salary',
#      xlim = range(X1), ylim = range(X2))
# contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
# points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
# points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))