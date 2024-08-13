# Carregar o arquivo .RData
load("bfd/combined_data.rdata")

# Assumindo que o dataframe principal está em 'combined_df'
df <- combined_df  # Substitua pelo nome correto, se for diferente

# Calcular o número de voos por 'company' e 'type'
library(dplyr)

result <- df %>%
  group_by(company, type) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(company) %>%
  mutate(totalAirline = sum(n)) %>%
  ungroup() %>%
  mutate(flightType = case_when(
    type %in% c("N", "R", "E", "H") ~ "D",
    type == "I" ~ "I",
    type %in% c("C", "G", "L") ~ "C"
  ))

# Salvar o resultado em um arquivo .csv
write.csv(result, file = "bfd/airlineXnFlights.csv", row.names = FALSE)
