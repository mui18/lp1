install.packages("caTools")
install.packages("e1071")
library(caTools)
library(e1071)

mydata <- read.csv(file = "diabetes.csv", header = T)
View(mydata)

temp_field <- sample.split(mydata,SplitRatio = 0.7)

train <- subset(mydata,temp_field==TRUE)
sum(train)
test <- subset(mydata,temp_field==FALSE)
sum(test)
train
test
head(train, n = 8L)
head(test)
x<-as.factor(train$Outcome)~.
my_model <- naiveBayes(as.factor(train$Outcome)~.,train)

my_model
test[,-9]
pred1 <- predict(my_model,test[,-9])
pred1


table(pred1,test$Outcome,dnn = c("predicted","actual"))
output <- cbind(test,pred1)
View(output)
mean(output$Outcome)
mean(output$pred1)
typeof(output$pred1)
typeof(output$Outcome)
