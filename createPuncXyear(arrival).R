library(dplyr)

calculate_punctuality <- function(data, year) {
  data_filtered <- data %>%
    filter(
      status != "Cancelado", 
      !is.na(delay_arrival),
      outlier_arrival_delay == FALSE
    ) %>%
    mutate(delay_arrival = ifelse(delay_arrival < 0, 0, delay_arrival))
  
  stats <- data_filtered %>%
    summarise(
      n = n(),
      delayed_flights = sum(delay_arrival > 15, na.rm = TRUE),
      punctual_flights = sum(delay_arrival <= 15, na.rm = TRUE),
      punctuality_percentage = mean(delay_arrival <= 15, na.rm = TRUE),
      mean = punctuality_percentage,
      sd = sd(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      median = median(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      trimmed = mean(as.numeric(delay_arrival <= 15), trim = 0.1, na.rm = TRUE),
      mad = mad(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      min = min(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      max = max(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      range = max - min,
      skew = e1071::skewness(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      kurtosis = e1071::kurtosis(as.numeric(delay_arrival <= 15), na.rm = TRUE),
      se = sd / sqrt(n),
      year = as.character(year),
      variable = "delay_arrival"
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

write.csv(results, "puncXyear(arrival).csv", row.names = FALSE)
