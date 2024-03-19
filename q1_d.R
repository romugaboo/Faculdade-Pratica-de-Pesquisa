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
#1d
# Converter a classe do atributo 'class' de volta para fator
wine$class <- as.factor(wine$class)

# Melt the dataframe to long format for plotting
wine_long <- reshape2::melt(wine, id.vars = "class")

# Plot boxplot for each attribute by wine class
ggplot(wine_long, aes(x = variable, y = value, fill = class)) +
  geom_boxplot() +
  facet_wrap(~variable, scales = "free") +
  theme_minimal()