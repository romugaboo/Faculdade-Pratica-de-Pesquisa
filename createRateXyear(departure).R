library(dplyr)
library(e1071)

calculate_punctuality_stats <- function(data, year, confidence_level = 0.95) {
  z <- qnorm((1 + confidence_level) / 2)
  
  data %>%

    filter(status != "Cancelado", outlier_depart_delay == FALSE) %>%
    mutate(delay_depart = ifelse(delay_depart < 0, 0, delay_depart)) %>%
    summarise(
      vars = n_distinct(type),
      n = n(),
      mean = mean(delay_depart, na.rm = TRUE),
      sd = sd(delay_depart, na.rm = TRUE),
      median = median(delay_depart, na.rm = TRUE),
      trimmed = mean(delay_depart, trim = 0.1, na.rm = TRUE),
      mad = mad(delay_depart, na.rm = TRUE),
      min = min(delay_depart, na.rm = TRUE),
      max = max(delay_depart, na.rm = TRUE),
      range = max(delay_depart, na.rm = TRUE) - min(delay_depart, na.rm = TRUE),
      skew = skewness(delay_depart, na.rm = TRUE),
      kurtosis = kurtosis(delay_depart, na.rm = TRUE),
      se = sd / sqrt(n),
      lLimit = mean - z * (sd / sqrt(n)), 
      hLimit = mean + z * (sd / sqrt(n)),  
      year = year,
      variable = "delay_depart"
    )
}

combined_results <- data.frame()

for (year in 2000:2023) {
  load(paste0("bfd/bfd_", year, ".rdata"))
  result <- calculate_punctuality_stats(bfd, year)
  combined_results <- rbind(combined_results, result)
  write.csv(result, paste0("rate_depart_", year, ".csv"), row.names = FALSE)
}

write.csv(combined_results, "rateXyear(depart).csv", row.names = FALSE)