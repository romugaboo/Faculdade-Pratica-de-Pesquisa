df_filtered <- combined_df %>%
  filter(!is.na(type), type != "X") %>%  
  group_by(depart) %>%
  filter(n() >= 50000)


library(dplyr)

result <- df_filtered %>%
  group_by(depart, type) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(depart) %>%
  mutate(totalAirline = sum(n)) %>%
  ungroup() %>%
  mutate(flightType = case_when(
    type %in% c("N", "R", "E", "H") ~ "D",
    type %in% c("I","N/I") ~ "I",
    type %in% c("C", "G", "L") ~ "C"
  ))

write.csv(result, file = "airportXnFlights.csv", row.names = FALSE)