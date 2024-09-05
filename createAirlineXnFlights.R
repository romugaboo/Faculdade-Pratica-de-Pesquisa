library(dplyr)

df_filtered <- combined_df %>%
  filter(!is.na(type), type != "X") %>%  # removendo linhas com NA ou "X"
  group_by(company) %>%
  filter(n() >= 15000)


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

write.csv(result, file = "airlineXnFlights.csv", row.names = FALSE)