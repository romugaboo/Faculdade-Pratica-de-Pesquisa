# Carregar o arquivo .RData
load("bfd/combined_data.rdata")

# Assumindo que o dataframe principal está em 'combined_df'
df <- combined_df  # Substitua pelo nome correto, se for diferente

# Calcular o número total de voos por 'depart_day_period'
library(dplyr)

result <- df %>%
  group_by(depart_day_period) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  mutate(day_shift = case_when(
    depart_day_period %in% c("Early Morning", "Mid Morning", "Late Morning") ~ "Morning",
    depart_day_period == "Afternoon" ~ "Afternoon",
    depart_day_period %in% c("Early Evening", "Late Evening", "Night") ~ "Night"
  ))

# Salvar o resultado em um arquivo .csv
write.csv(result, file = "bfd/dayPeriodXnFlights(origin).csv", row.names = FALSE)
