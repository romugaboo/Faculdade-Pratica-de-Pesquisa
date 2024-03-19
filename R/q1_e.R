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
tail(wine)

library(ggplot2)
#1e
# Plot scatterplot for each pair of attributes
ggplot(wine_long, aes(x = value, y = as.numeric(variable), color = class)) +
  geom_point() +
  facet_wrap(~ variable, scales = "free") +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())