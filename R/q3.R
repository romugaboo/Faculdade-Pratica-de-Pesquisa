# Criando dataframe
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline')

# K-means e entropia
kmeans_model <- kmeans(wine[, -1], centers = 3)

entropy <- function(labels) {
  probabilities <- table(labels) / length(labels)
  -sum(probabilities * log2(probabilities))
}
group_entropy <- sapply(unique(kmeans_model$cluster), function(group) {
  cluster_labels <- wine$Type[kmeans_model$cluster == group]
  entropy(cluster_labels)
})
group_entropy

# Calculando a entropia para a classe "Type" original
entropy_type <- calculate_entropy(wines$Type)

entropy_type
