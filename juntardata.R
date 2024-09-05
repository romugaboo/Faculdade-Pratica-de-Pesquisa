library(dplyr)
file_list <- list.files(path = "bfd", pattern = "\\.rdata$", full.names = TRUE)
df_list <- list()

for (file in files) {
  load(file)
  df_list[[length(df_list) + 1]] <- get(ls()[1])
}

combined_df <- do.call(rbind, df_list)
save(combined_df, file = "combined_data.RData")