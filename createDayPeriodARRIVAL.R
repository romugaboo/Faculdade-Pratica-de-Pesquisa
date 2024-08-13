# Carregar o arquivo .RData
load("bfd/combined_data.rdata")

df <- combined_df  

# Calcular o número total de voos por 'arrival_day_period'
library(dplyr)

result <- df %>%
  group_by(arrival_day_period) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  mutate(day_shift = case_when(
    arrival_day_period %in% c("Early Morning", "Mid Morning", "Late Morning") ~ "Morning",
    arrival_day_period == "Afternoon" ~ "Afternoon",
    arrival_day_period %in% c("Early Evening", "Late Evening", "Night") ~ "Night"
  ))

# Salvar o resultado em um arquivo .csv
write.csv(result, file = "bfd/dayPeriodXnFlights(ARRIVAL).csv", row.names = FALSE)
