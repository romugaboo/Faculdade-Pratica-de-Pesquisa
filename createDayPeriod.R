load("bfd/combined_data.rdata")

df <- combined_df

library(dplyr)

result <- df %>%
  group_by(depart_day_period) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  mutate(day_shift = case_when(
    depart_day_period %in% c("Early Morning", "Mid Morning", "Late Morning") ~ "Morning",
    depart_day_period == "Afternoon" ~ "Afternoon",
    depart_day_period %in% c("Early Evening", "Late Evening", "Night") ~ "Night"
  ))

write.csv(result, file = "bfd/dayPeriodXnFlights.csv", row.names = FALSE)