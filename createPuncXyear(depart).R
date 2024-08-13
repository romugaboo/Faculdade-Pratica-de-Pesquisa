library(dplyr)

calculate_punctuality <- function(data, year) {
  data_filtered <- data %>%
    filter(
      status != "Cancelado", 
      !is.na(delay_depart),
      outlier_depart_delay == FALSE
    ) %>%
    mutate(delay_depart = ifelse(delay_depart < 0, 0, delay_depart))  # Treat early flights as on-time
  
  stats <- data_filtered %>%
    summarise(
      n = n(),
      delayed_flights = sum(delay_depart > 15, na.rm = TRUE),  # Flights delayed by more than 15 minutes
      punctual_flights = sum(delay_depart <= 15, na.rm = TRUE), # Flights delayed by 15 minutes or less
      punctuality_percentage = mean(delay_depart <= 15, na.rm = TRUE),  # Punctuality percentage (<= 15 mins)
      mean = punctuality_percentage,  # Mean punctuality percentage
      sd = sd(as.numeric(delay_depart <= 15), na.rm = TRUE),  # Standard deviation of punctuality
      median = median(as.numeric(delay_depart <= 15), na.rm = TRUE),
      trimmed = mean(as.numeric(delay_depart <= 15), trim = 0.1, na.rm = TRUE),
      mad = mad(as.numeric(delay_depart <= 15), na.rm = TRUE),
      min = min(as.numeric(delay_depart <= 15), na.rm = TRUE),
      max = max(as.numeric(delay_depart <= 15), na.rm = TRUE),
      range = max - min,
      skew = e1071::skewness(as.numeric(delay_depart <= 15), na.rm = TRUE),
      kurtosis = e1071::kurtosis(as.numeric(delay_depart <= 15), na.rm = TRUE),
      se = sd / sqrt(n),
      year = as.character(year),
      variable = "delay_depart"
    )
  return(stats)
}

results <- data.frame()
years <- 2000:2023
rdata_files <- paste0("bfd/bfd_", years, ".rdata")

for (i in seq_along(rdata_files)) {
  load(rdata_files[i])
  yearly_stats <- calculate_punctuality(bfd, years[i])
  results <- bind_rows(results, yearly_stats)
}

write.csv(results, "puncXyear(depart).csv", row.names = FALSE)
