library(dplyr)

df_filtered <- combined_df_2 %>%
  filter(!is.na(type), type != "X") %>%  # Remove rows with NA or "X" in 'type'
  group_by(company) %>%
  filter(n() >= 15000)

# Calculate the number of flights by 'company' and 'type'
result <- df_filtered %>%
  group_by(company, type) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(company) %>%
  mutate(totalAirline = sum(n)) %>%
  ungroup() %>%
  mutate(flightType = case_when(
    type %in% c("N", "R", "E", "H") ~ "D",
    type %in% c("I","N/I") ~ "I",
    type %in% c("C", "G", "L") ~ "C",
  ))

# Export the results to a CSV file
write.csv(result, file = "airlineXnFlights.csv", row.names = FALSE)
