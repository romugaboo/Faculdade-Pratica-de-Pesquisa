# Required libraries
library(dplyr)

# Function to calculate punctuality percentage
calculate_punctuality <- function(data, year) {
  data_filtered <- data %>%
    filter(
      status != "Cancelado", 
      outlier_arrival_delay == FALSE, 
      delay_arrival >= 0
    )
  
  # Calculate the percentage of delayed flights
  stats <- data_filtered %>%
    summarise(
      n = n(),
      delayed_flights = sum(delay_arrival > 0, na.rm = TRUE),
      punctual_flights = sum(delay_arrival == 0, na.rm = TRUE),
      punctuality_percentage = mean(delay_arrival == 0, na.rm = TRUE),  # Punctuality percentage (flights on time)
      mean = punctuality_percentage,  # Mean punctuality percentage
      sd = sd(as.numeric(delay_arrival == 0), na.rm = TRUE),  # Standard deviation of punctuality
      median = median(as.numeric(delay_arrival == 0), na.rm = TRUE),
      trimmed = mean(as.numeric(delay_arrival == 0), trim = 0.1, na.rm = TRUE),
      mad = mad(as.numeric(delay_arrival == 0), na.rm = TRUE),
      min = min(as.numeric(delay_arrival == 0), na.rm = TRUE),
      max = max(as.numeric(delay_arrival == 0), na.rm = TRUE),
      range = max - min,
      skew = e1071::skewness(as.numeric(delay_arrival == 0), na.rm = TRUE),
      kurtosis = e1071::kurtosis(as.numeric(delay_arrival == 0), na.rm = TRUE),
      se = sd / sqrt(n),
      year = as.character(year),
      variable = "delay_arrival"
    )
  
  return(stats)
}

# Initialize an empty data frame to store results
results <- data.frame()

# List of years and corresponding .rdata files
years <- 2000:2023
rdata_files <- paste0("bfd/bfd_", years, ".rdata")

# Loop through each year, load the data, calculate stats, and combine results
for (i in seq_along(rdata_files)) {
  load(rdata_files[i])  # Assume each .rdata file loads a data frame named `df`
  
  # Calculate stats and bind to results
  yearly_stats <- calculate_punctuality(bfd, years[i])
  results <- bind_rows(results, yearly_stats)
}

# Export results to CSV
write.csv(results, "puncXyear(arrival).csv", row.names = FALSE)
