# Required libraries
library(dplyr)
library(lubridate)

# Function to calculate delay probability by month
calculate_delay_probability_by_month <- function(data) {
  data <- data %>%
    filter(status != "Cancelado", 
           outlier_depart_delay == FALSE, 
           delay_depart >= 0) %>%
    mutate(
      month = month(real_depart),  # Extract month as a number (1-12)
      monthAbb = month.abb[month]  # Get the abbreviated month name
    )
  
  # Group by month and calculate the statistics
  monthly_stats <- data %>%
    group_by(month, monthAbb) %>%
    summarise(
      n = n(),
      mean = mean(delay_depart, na.rm = TRUE),
      sd = sd(delay_depart, na.rm = TRUE),
      punc = mean(delay_depart == 0, na.rm = TRUE),  # Punctuality rate (on-time flights)
      se = sd / sqrt(n),  # Standard error
      hLimit = mean + qt(0.975, df = n-1) * se,  # Upper confidence limit
      lLimit = mean - qt(0.975, df = n-1) * se   # Lower confidence limit
    ) %>%
    ungroup() %>%
    arrange(month)
  
  return(monthly_stats)
}

# Assuming 'df' is your loaded data frame
monthly_delay_probability <- calculate_delay_probability_by_month(combined_df_2)

# View the results
print(monthly_delay_probability)

# Optionally, save the results to a CSV file
write.csv(monthly_delay_probability, "rateXmonth(depart).csv", row.names = FALSE)
