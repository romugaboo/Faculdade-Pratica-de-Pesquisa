library(dplyr)
library(e1071)

df <- combined_df_2

df <- df %>%
  filter(status != "Cancelado", outlier_depart_delay == FALSE)

# Substituir valores negativos de delay_depart por 0
df <- df %>%
  mutate(delay_depart = ifelse(delay_depart < 0, 0, delay_depart))

df_filtered <- df %>%
  group_by(depart) %>%
  filter(n() >= 1000) %>%
  ungroup()

result <- df_filtered %>%
  group_by(depart) %>%
  summarise(
    vars = n_distinct(type),
    n = n(),
    mean_delay = mean(delay_depart, na.rm = TRUE),
    sd_delay = sd(delay_depart, na.rm = TRUE),
    median_delay = median(delay_depart, na.rm = TRUE),
    trimmed_mean_delay = mean(delay_depart, trim = 0.1, na.rm = TRUE),
    mad_delay = mad(delay_depart, na.rm = TRUE),
    min_delay = min(delay_depart, na.rm = TRUE),
    max_delay = max(delay_depart, na.rm = TRUE),
    range_delay = max_delay - min_delay,
    skew_delay = skewness(delay_depart, na.rm = TRUE),
    kurtosis_delay = kurtosis(delay_depart, na.rm = TRUE),
    se_delay = sd_delay / sqrt(n),
    origin_icao = first(depart),
    variable = "departure_delay",
    rate = mean(delay_depart, na.rm = TRUE),
    punc = mean(delay_depart <= 15, na.rm = TRUE)
  )

write.csv(result, "puncRateXnFlights(depart).csv", row.names = FALSE)
