# create example data frame
df <- data.frame(
  race = c("White", "Black", "Other", "White", "Black", "Other"),
  income = c("low", "low", "low", "high", "high", "high"),
  the_number_of_people = c(100, 150, 50, 200, 300, 100)
)

# aggregate the_number_of_people column for each income level
df_sum <- df %>%
  group_by(income) %>%
  summarise(total = sum(the_number_of_people))

# merge with original data frame to get percentage
df_percentage <- df %>%
  left_join(df_sum, by = "income") %>%
  group_by(race, income) %>%
  mutate(percentage = the_number_of_people / total * 100) %>%
  select(-total)

# create stacked bar chart with total number of people as y-axis
ggplot(df_percentage, aes(x = income, y = the_number_of_people, fill = race)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = c("White" = "blue", "Black" = "red", "Other" = "green")) +
  labs(x = "Income Level", y = "Total Number of People",
       title = "Percentage of Each Race by Income Level") +
  geom_text(aes(label = paste0(round(percentage, 1), "%"), y = cumsum(percentage) - percentage / 2), 
            position = position_stack(vjust = 0.5), size = 3)

df
