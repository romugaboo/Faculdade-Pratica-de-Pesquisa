# Carregar os pacotes necessários
library(dplyr)

# Lista de arquivos .RData
file_list <- list.files(path = "bfd", pattern = "\\.rdata$", full.names = TRUE)

df_list <- list()

# Loop para carregar cada arquivo e armazenar em df_list
for (file in files) {
  load(file) # Carrega o conteúdo do arquivo RData
  df_list[[length(df_list) + 1]] <- get(ls()[1]) # Obtém o dataframe carregado
}

# Combina todos os dataframes na lista
combined_df <- do.call(rbind, df_list)

# Salvar o resultado em um arquivo .RData
save(combined_df, file = "combined_data.RData")
