# Carregar pacotes
source("https://raw.githubusercontent.com/cefet-rj-dal/daltoolbox-examples/main/jupyter.R")
source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/tutorial/graphics_extra.R")

load_library("daltoolbox")
load_library("ggplot2")
load_library("dplyr")
load_library("reshape")
load_library("RColorBrewer")
load_library("corrplot")
load_library("WVPlots")
load_library("GGally") 

# Criar dataframe
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('class', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline') 

wine$class = as.character(wine$class)
# Visualizar os ultimos registros do dataframe
#tail(wine)

### questão 2 ###

library(dplyr)

# Discretização dos atributos numéricos em faixas de valores alto, médio e baixo
wine_discretized <- wine %>%
  mutate(across(-class, .fns = function(x) {
    breaks <- quantile(x, probs = c(0, 1/3, 2/3, 1))
    labels <- c("Baixo", "Médio", "Alto")
    factor(cut(x, breaks, labels = labels, include.lowest = TRUE))
  }))

# Conversão do atributo do tipo de vinho para um mapeamento categórico
wine_discretized$class <- factor(wine_discretized$class)

# Visualizar as primeiras linhas do dataframe resultante
View(wine_discretized)

