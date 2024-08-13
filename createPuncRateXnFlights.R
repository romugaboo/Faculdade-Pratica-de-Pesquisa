df <- combined_df_2

# Calcular as estatísticas para cada companhia aérea
library(dplyr)

# Remover linhas com status "cancelado"
df <- df %>%
  filter(status != "Cancelado")

# Remover valores negativos de 'delay_depart' se eles não fizerem sentido
df <- df %>% 
  mutate(delay_depart = ifelse(delay_depart < 0, 0, delay_depart))

# Filtrar as empresas com mais de 1000 voos
df_filtered <- df %>%
  group_by(company) %>%
  filter(n() >= 1000)

# Calcular as métricas desejadas
result <- df_filtered %>%
  group_by(company) %>%
  summarise(
    vars = n_distinct(type),
    n = n(),
    sd = sd(delay_depart, na.rm = TRUE),
    min = min(delay_depart, na.rm = TRUE),
    max = max(delay_depart, na.rm = TRUE),
    range = max - min,
    se = sd/sqrt(n),
    variable = "delay_depart",
    rate = mean(delay_depart, na.rm = TRUE),
    punc = mean(delay_depart <= 15, na.rm = TRUE)
  ) %>%
  ungroup()

# Exportar para CSV
write.csv(result, "puncRateXnFlights.csv", row.names = FALSE)