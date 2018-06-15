

#importing the libraries


svm1 <- function(){
  
#importing the libraries
#(naivebayes)
library(e1071)
library(caTools)
#library(caret)
#library(svm)


# Importing the dataset
dataset = read.csv('data.csv')


# Splitting the dataset into the Training set and Test set
# install.packages('caTools')

set.seed(123)
split = sample.split(dataset$num, SplitRatio = 0.85)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#test_set = data.frame(Age="63",Sex="1",chesp.pain.type="1",resting.bp="145",cholestrol="233",fasting.blood.sugar="1",electrocardiographic="2",max.heart.rate="150",exercise.induced.angina="0",oldpeak="2.3",slope.of.peak.exercise="3",ca="0",thal="6",num="0")

#renderTable(Age="output$")
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

# # Feature Scaling
# training_set[-3] = scale(training_set[-14])
# test_set[-3] = scale(test_set[-14])

# Fitting classifier to the Training set
# Create your classifier here

library(e1071)
classifier = svm(formula = num ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel = 'linear')

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-14])

# Making the Confusion Matrix
cm = table(test_set[, 14], y_pred)

return(cm)
# 

#confusionMatrix(table(y_pred,test_set$num))

# # Visualising the Training set results
# library(ElemStatLearn)
# set = training_set
# X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
# X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
# X3 = seq(min(set[, 3]) - 1, max(set[, 1]) + 1, by = 0.01)
# X4 = seq(min(set[, 4]) - 1, max(set[, 1]) + 1, by = 0.01)
# X5 = seq(min(set[, 5]) - 1, max(set[, 1]) + 1, by = 0.01)
# X6 = seq(min(set[, 6]) - 1, max(set[, 1]) + 1, by = 0.01)
# X7 = seq(min(set[, 7]) - 1, max(set[, 1]) + 1, by = 0.01)
# X8 = seq(min(set[, 8]) - 1, max(set[, 1]) + 1, by = 0.01)
# X9 = seq(min(set[, 9]) - 1, max(set[, 1]) + 1, by = 0.01)
# X10 = seq(min(set[, 10]) - 1, max(set[, 1]) + 1, by = 0.01)
# X11 = seq(min(set[, 11]) - 1, max(set[, 1]) + 1, by = 0.01)
# X12 = seq(min(set[, 12]) - 1, max(set[, 1]) + 1, by = 0.01)
# X13 = seq(min(set[, 13]) - 1, max(set[, 1]) + 1, by = 0.01)
# grid_set = expand.grid(X1, X10)
# colnames(grid_set) = c('Age', 'oldpeak')
# y_grid = predict(classifier, newdata = grid_set)
# plot(set[, -14],
#      main = 'svm (Training set)',
#      xlab = 'Age', ylab = 'Probability',
#      xlim = range(X1), ylim = range(X2))
# contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
# points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
# points(set, pch = 21, bg = ifelse(set[, 14] == 1, 'green4', 'red3'))

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


}


accuracy <- function(){
  # Making the Confusion Matrix
  cm = table(test_set[, 14], y_pred)
  #accuracy <- sum(diag(cm))/sum(cm)
  accr =  (sum(diag(cm))/sum(cm))
  return(accr*100)
}
