# Pacotes e bibliotecas
source("https://raw.githubusercontent.com/cefet-rj-dal/daltoolbox-examples/main/jupyter.R")
load_library("daltoolbox")
load_library("ggplot2")
load_library("reshape2")

# Criar dataframe
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('class', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline') 

# Criando boxplot
wine$class <- as.factor(wine$class)
wine_long <- reshape2::melt(wine, id.vars = "class")
ggplot(wine_long, aes(x = variable, y = value, fill = class)) +
  geom_boxplot() +
  facet_wrap(~variable, scales = "free") +
  theme_minimal()