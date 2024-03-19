# UCI <- "http://archive.ics.uci.edu/ml"
# REPOS <- "machine-learning-databases"
# wine.url <- sprintf("%s/%s/wine/wine.data", UCI, REPOS)
# wine <- read.csv(wine.url, header=FALSE) 
# colnames(wine) <- c('Type', 'Alcohol', 'Malic', 'Ash', 
#                     'Alcalinity', 'Magnesium', 'Phenols', 
#                     'Flavanoids', 'Nonflavanoids',
#                     'Proanthocyanins', 'Color', 'Hue', 
#                     'Dilution', 'Proline')
# head(wine)
# wine$Type <- as.factor(wine$Type)
# save(wine, file="wine.Rdata", compress=TRUE)

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
load_library("ggplot2")

# Criando dataframe
wine <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = TRUE, sep = ",") 
colnames(wine) <- c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline') 
head(wine) 

# Questao 3 
wine$Type <- as.factor(wine$Type) 
cm <- categ_mapping("Type") 
wine_cm <- transform(cm, wine) 
print(head(wine_cm)) 
wineCM <- wine 
wineCM$Type1 <- wine_cm$Type1 
wineCM$Type2 <- wine_cm$Type2 
wineCM$Type3 <- wine_cm$Type3 
wineCM$Type <- NULL 
head(wineCM)

