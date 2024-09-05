library(dplyr)
df <- combined_df

df_cleaned <- df %>%
  filter(status != "Cancelado", outlier_arrival_delay == FALSE, outlier_depart_delay == FALSE) %>%
  mutate(delay_depart = ifelse(delay_depart < 0, 0, delay_depart))

df_filtered <- df_cleaned %>%
  group_by(company) %>%
  filter(n() >= 1000)

result <- df_filtered %>%
  summarise(
    vars = n_distinct(type),
    n = n(),
    sd = sd(delay_depart, na.rm = TRUE),
    min = min(delay_depart, na.rm = TRUE),
    max = max(delay_depart, na.rm = TRUE),
    range = max - min,
    se = sd / sqrt(n),
    variable = "delay_depart",                   
    rate = mean(delay_depart, na.rm = TRUE),     
    punc = mean(delay_depart <= 15, na.rm = TRUE)
  ) %>%
  ungroup()

write.csv(result, "puncRateXnFlights.csv", row.names = FALSE)