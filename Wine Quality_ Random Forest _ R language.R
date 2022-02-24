#PROJECT - 04
# Wine Quality Data
wine_data = read.csv("winequality.csv")
print(head(wine_data))
print(tail(wine_data))
#to view data in R studio tab
#View(wine_data)

#name the barplot
png("winequalityplot.png")
#Let's plot the barplot
barplot(table(wine_data$quality))
#save the file
dev.off()
#from this barplot you get number of wines with quality like 6, 7  and more
#let's divide this into good, bad and normal like >6,<6 and =6 repectively.
wine_data$taste = ifelse(wine_data$quality<6, "bad","good")
wine_data$taste[wine_data$quality == 6] = "normal"
wine_data$taste =as.factor(wine_data$taste)
table(wine_data$taste)

#Let's divid the data into test adn training dataset
#1st way
split = sample.split(wine_data, SplitRatio = 0.8)
train_set = subset(wine_data, split = "TRUE")
test_set = subset(wine_data, split = "FALSE")
#2nd way
#set.seed(123)
#samp = sample(nrow(wine_data),0.6 * nrow(wine_data))
#train = wine_data[samp,]
#test = wine_data[-samp,]

#use the random forest
library(randomForest)

model = randomForest(taste ~type+fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides +free.sulfur.dioxide+total.sulfur.dioxide+density +pH+sulphates+alcohol+quality, data = train_set)
model

#predicting model using test_set
pred = predict(model,data = train_set)
table(pred, test_set$taste)

(2384+1277+2836)/nrow(test_set)

