library(dplyr)
library(lubridate)

calculate_delay_probability_by_month <- function(data) {
  data <- data %>%
    filter(status != "Cancelado", 
           outlier_depart_delay == FALSE) %>%
    mutate(
      delay_depart = ifelse(delay_depart < 0, 0, delay_depart),
      month = month(real_depart),
      monthAbb = month.abb[month]
    )
  
  monthly_stats <- data %>%
    group_by(month, monthAbb) %>%
    summarise(
      n = n(),
      mean = mean(delay_depart, na.rm = TRUE),
      sd = sd(delay_depart, na.rm = TRUE),
      punc = mean(delay_depart <= 15, na.rm = TRUE),  # Punctuality rate (<= 15 mins)
      se = ifelse(n > 1, sd / sqrt(n), NA),
      hLimit = ifelse(n > 1, mean + qt(0.975, df = n-1) * se, NA),
      lLimit = ifelse(n > 1, mean - qt(0.975, df = n-1) * se, NA) 
    ) %>%
    ungroup() %>%
    arrange(month)
  
  return(monthly_stats)
}

monthly_delay_probability <- calculate_delay_probability_by_month(combined_df_2)
print(monthly_delay_probability)

write.csv(monthly_delay_probability, "rateXmonth(depart).csv", row.names = FALSE)
