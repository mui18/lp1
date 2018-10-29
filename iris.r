library(datasets)
data("iris")  
names(iris) #set name of object to iris
dim(iris) #get dimensions of object
View(iris)
str(iris)
min(iris$Sepal.Length)
max(iris$Sepal.Length)
mean(iris$Sepal.Length)
range(iris$Sepal.Length)
sd(iris$Sepal.Length)
var(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length,c(0.3,0.6))
h <- hist(iris$Sepal.Length
          ,main = "sepal length frequencies - histogram"
          ,xlab="sepal length",xlim = c(3.5,8.5)
          ,col = colors() [12])
h
h <- hist(iris$Sepal.Length
          , main = "sepal length frequencies - histogram"
          ,xlab="sepal length"
          ,col = "blue"
          ,breaks = 3
          ,border = "green"
          )
h <- hist(iris$Sepal.Length, 
          breaks=c(4.3,4.6,4.9,5.2,5.5,5.8,6.1,6.4,6.7,7.0,7.3,7.6,7.9))



boxplot(iris$Sepal.Length,
        notch = T,
        horizontal=T)
summary(iris$Sepal.Length)
iris
iris[,-5]
myboxplot <- boxplot(iris[,-5])
myboxplot$out

