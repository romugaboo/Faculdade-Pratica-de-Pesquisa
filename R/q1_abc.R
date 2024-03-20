# Pacotes e bibliotecas
source("https://raw.githubusercontent.com/cefet-rj-dal/daltoolbox-examples/main/jupyter.R")
load_library("daltoolbox")
load_library("ggplot2")
load_library("reshape2")

# Criar dataframe
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('class', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline') 
wine$class = as.character(wine$class)

# Média e desvio padrão para todos os atributos
dw_mean <- wine %>% 
  summarise(across(.cols = !(class), .fns = mean))
dw_sd <- wine %>% 
  summarise(across(.cols = !(class), .fns = sd))

View(dw_mean)
View(dw_sd)

# Média e desvio padrão para todos os atributos agrupados pelo tipo de vinho
dw_mean_grouped <- wine %>%
  group_by(class) %>%
  summarise(across(.cols = everything(), .fns = mean))
dw_sd_grouped <- wine %>%
  group_by(class) %>%
  summarise(across(.cols = everything(), .fns = sd))

View(dw_mean_grouped)
View(dw_sd_grouped)

# Gráfico de densidade
wine$class <- as.factor(wine$class)
wine_long <- reshape2::melt(wine, id.vars = "class")
ggplot(wine_long, aes(x = value, fill = class)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~variable, scales = "free") +
  theme_minimal()