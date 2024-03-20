# Pacotes e bibliotecas
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('class', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline') 

wine$class <- as.character(wine$class)

# Discretizar
wine_discretized <- wine %>%
  mutate(across(-class, .fns = function(x) {
    breaks <- quantile(x, probs = c(0, 1/3, 2/3, 1))
    labels <- c("Baixo", "Médio", "Alto")
    factor(cut(x, breaks, labels = labels, include.lowest = TRUE))
  }))
wine_discretized$class <- factor(wine_discretized$class)


# Mapeamento categórico
wineCM <- wine_discretized
wineCM$Type <- as.factor(wineCM$class)
cm <- categ_mapping("Type")
wineCM <- transform(cm, wineCM)
wineCM$Type1 <- wineCM$Type1 
wineCM$Type2 <- wineCM$Type2 
wineCM$Type3 <- wineCM$Type3 
wineCM$Type <- NULL 

wine_discretized <- subset(wine_discretized, select = -c(class))
combined_df <- cbind(wine_discretized, wineCM)
View(combined_df)