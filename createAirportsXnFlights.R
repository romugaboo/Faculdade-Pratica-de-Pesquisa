# Carregar o arquivo .RData
load("bfd/combined_data.rdata")

df <- combined_df

# Calcular o número de voos por 'depart' e 'type'
library(dplyr)

result <- df %>%
  group_by(depart, type) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(depart) %>%
  mutate(totalAirline = sum(n)) %>%
  ungroup() %>%
  mutate(flightType = case_when(
    type %in% c("N", "R", "E", "H") ~ "D",
    type == "I" ~ "I",
    type %in% c("C", "G", "L") ~ "C"
  ))

# Salvar o resultado em um arquivo .csv
write.csv(result, file = "bfd/airportXnFlights.csv", row.names = FALSE)
