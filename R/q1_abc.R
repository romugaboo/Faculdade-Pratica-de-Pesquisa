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

# Calcular média e desvio padrão para todos os atributos
dw_mean <- wine %>% 
  summarise(across(.cols = !(class), .fns = mean))

dw_sd <- wine %>% 
  summarise(across(.cols = !(class), .fns = sd))

# Visualizar média e desvio padrão para todos os atributos
print("Média de cada atributo:")
View(dw_mean)

print("Desvio padrão de cada atributo:")
View(dw_sd)

# Calcular média e desvio padrão para todos os atributos agrupados pelo tipo de vinho
dw_mean_grouped <- wine %>%
  group_by(class) %>%
  summarise(across(.cols = everything(), .fns = mean))

dw_sd_grouped <- wine %>%
  group_by(class) %>%
  summarise(across(.cols = everything(), .fns = sd))

# Visualizar média e desvio padrão para todos os atributos agrupados pelo tipo de vinho
View(dw_mean_grouped)
View(dw_sd_grouped)

#1c
wine$class <- as.factor(wine$class)
wine_long <- reshape2::melt(wine, id.vars = "class")

# Plot density distribution for each attribute by wine class
ggplot(wine_long, aes(x = value, fill = class)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~variable, scales = "free") +
  theme_minimal()