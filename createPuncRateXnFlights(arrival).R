library(dplyr)
library(e1071)

df <- combined_df_2

df <- df %>%
  filter(status != "Cancelado", outlier_arrival_delay == FALSE)

df <- df %>%
  mutate(delay_arrival = ifelse(delay_arrival < 0, 0, delay_arrival))

df_filtered <- df %>%
  group_by(arrival) %>%
  filter(n() >= 1000) %>%
  ungroup()

result <- df_filtered %>%
  group_by(arrival) %>%
  summarise(
    vars = n_distinct(type),
    n = n(),
    mean_delay = mean(delay_arrival, na.rm = TRUE),
    sd_delay = sd(delay_arrival, na.rm = TRUE),
    median_delay = median(delay_arrival, na.rm = TRUE),
    trimmed_mean_delay = mean(delay_arrival, trim = 0.1, na.rm = TRUE),
    mad_delay = mad(delay_arrival, na.rm = TRUE),
    min_delay = min(delay_arrival, na.rm = TRUE),
    max_delay = max(delay_arrival, na.rm = TRUE),
    range_delay = max_delay - min_delay,
    skew_delay = skewness(delay_arrival, na.rm = TRUE),
    kurtosis_delay = kurtosis(delay_arrival, na.rm = TRUE),
    se_delay = sd_delay / sqrt(n),
    origin_icao = first(arrival),
    variable = "delay_arrival",
    rate = mean(delay_arrival, na.rm = TRUE),
    punc = mean(delay_arrival <= 15, na.rm = TRUE)
  )

write.csv(result, "puncRateXnFlights(arrival).csv", row.names = FALSE)
