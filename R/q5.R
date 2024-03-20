# Pacotes e bibliotecas
source("https://raw.githubusercontent.com/cefet-rj-dal/daltoolbox-examples/main/jupyter.R")
load_library("daltoolbox")
load_library("corrplot")

# Criando dataframe
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline')

# Matriz de correlação
wine$Type <- as.factor(wine$Type) 
cor_matrix <- cor(wine[, -1])
corrplot(cor_matrix, method = "color")