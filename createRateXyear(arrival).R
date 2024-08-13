library(dplyr)
library(e1071) 

# Function to calculate punctuality statistics for a specific year, excluding outliers and negative delays
calculate_punctuality_stats <- function(data, year) {
  data %>%
    # Remove cancelled flights, outliers, and flights with negative delay_arrival values
    # Nao vai considerar os voos adiantados
    filter(status != "Cancelado", outlier_arrival_delay == FALSE, delay_arrival >= 0) %>%
    # Calculate metrics
    summarise(
      vars = n_distinct(type),
      n = n(),
      mean = mean(delay_arrival, na.rm = TRUE),
      sd = sd(delay_arrival, na.rm = TRUE),
      median = median(delay_arrival, na.rm = TRUE),
      trimmed = mean(delay_arrival, trim = 0.1, na.rm = TRUE),
      mad = mad(delay_arrival, na.rm = TRUE),
      min = min(delay_arrival, na.rm = TRUE),
      max = max(delay_arrival, na.rm = TRUE),
      range = max(delay_arrival, na.rm = TRUE) - min(delay_arrival, na.rm = TRUE),
      skew = skewness(delay_arrival, na.rm = TRUE),
      kurtosis = kurtosis(delay_arrival, na.rm = TRUE),
      se = sd / sqrt(n),
      year = year,
      variable = "delay_arrival"
    )
}

# Example for a specific year
year <- "2023" # Set the corresponding year
load("bfd/bfd_2023.rdata") # Replace with the correct .RData file path
result_2023 <- calculate_punctuality_stats(bfd, year)

# Save the result to a CSV
write.csv(result_2023, paste0("rate_arrival_", year, ".csv"), row.names = FALSE)

# Combine os resultados de todos os anos
combined_results <- rbind(result_2000, result_2001, result_2002, result_2003, result_2004, result_2005, result_2006,result_2007,result_2008,result_2009,result_2010,result_2011,result_2012,result_2013,result_2014,result_2015,result_2016,result_2017,result_2018,result_2019,result_2020,result_2021,result_2022,result_2023) # Continue para todos os anos

# Exportar o resultado combinado para um arquivo CSV
write.csv(combined_results, "rateXyear(arrival).csv", row.names = FALSE)
