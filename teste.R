# Carregar o primeiro arquivo
load("bfd/combined_data.rdata")
df1 <- combined_df  # Substitua pelo nome correto do dataframe

# Carregar o segundo arquivo
load("bfd/bfd_2000.rdata")
df2 <- bfd  # Substitua pelo nome correto do dataframe

combined_df_2 <- rbind(df1, df2)
