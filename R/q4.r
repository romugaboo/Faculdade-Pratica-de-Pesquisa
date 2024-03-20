### construa um modelo de predição usando redes neurais para os dados de vinho
# usando o DALtoolBox. Qual é a acurácia alcançada?

# Usando o Random Forest

# DAL ToolBox
# version 1.0.727
source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/tutorial/graphics_extra.R")
source("https://raw.githubusercontent.com/cefet-rj-dal/daltoolbox-examples/main/jupyter.R")

#loading DAL
load_library("daltoolbox")
load_library("ggplot2")
load_library("dplyr")
load_library("reshape")
load_library("RColorBrewer")
load_library("corrplot")
load_library("WVPlots")
load_library("GGally") 

#carregar os dados de vinho
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('class', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline') 

wine$class = as.character(wine$class)
# Visualizar os ultimos registros do dataframe
head(wine)

#extraindo os levels pro dataset
wine$class <- factor(wine$class)
slevels <- levels(wine$class)
print(slevels)

# preparando o dataset pro sampling aleatório
set.seed(1)
sr <- sample_random()
sr <- train_test(sr, wine)
wine_train <- sr$train
wine_test <- sr$test

tbl <- rbind(table(wine[,"class"]), 
             table(wine_train[,"class"]), 
             table(wine_test[,"class"]))
rownames(tbl) <- c("dataset", "training", "test")
head(tbl)

# treinando o modelo
model <- cla_rf("class", slevels, mtry=3, ntree=5)
model <- fit(model, wine_train)
train_prediction <- predict(model, wine_train)

#ajustando o modelo
wine_train_predictand <- adjust_class_label(wine_train[,"class"])
train_eval <- evaluate(model, wine_train_predictand, train_prediction)
print(train_eval$metrics)

# Teste 
test_prediction <- predict(model, wine_test)

wine_test_predictand <- adjust_class_label(wine_test[,"class"])
test_eval <- evaluate(model, wine_test_predictand, test_prediction)
print(test_eval$metrics)


