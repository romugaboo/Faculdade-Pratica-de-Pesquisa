library(dplyr)

df <- combined_df_2

# Filter out canceled flights and outliers, and handle negative delays
df_cleaned <- df %>%
  filter(status != "Cancelado", outlier_arrival_delay == FALSE, outlier_depart_delay == FALSE) %>%
  mutate(delay_depart = ifelse(delay_depart < 0, 0, delay_depart))

# Filter companies with more than 1000 flights
df_filtered <- df_cleaned %>%
  group_by(company) %>%
  filter(n() >= 1000)

# Calculate the desired metrics for each company
result <- df_filtered %>%
  summarise(
    vars = n_distinct(type),                     # Number of distinct flight types
    n = n(),                                     # Number of flights
    sd = sd(delay_depart, na.rm = TRUE),         # Standard deviation of delays
    min = min(delay_depart, na.rm = TRUE),       # Minimum delay
    max = max(delay_depart, na.rm = TRUE),       # Maximum delay
    range = max - min,                           # Range of delays
    se = sd / sqrt(n),                           # Standard error
    variable = "delay_depart",                   # Variable name
    rate = mean(delay_depart, na.rm = TRUE),     # Mean delay
    punc = mean(delay_depart <= 15, na.rm = TRUE) # Punctuality rate (<= 15 mins)
  ) %>%
  ungroup()

# Export the results to a CSV file
write.csv(result, "puncRateXnFlights.csv", row.names = FALSE)
