#### Preamble ####
# Purpose: data cleaning for race
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 11 March 2023 
# Contact: junwei.zhang@mail.utoronto.ca/yx.fan@mail.utoronto.ca/myra.li@mail.utoronto.ca



# Loading in relevant libraries
library(tidyverse)
library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(readxl)
library(data.table)
library(lubridate)
library(haven)
library(readxl)
library(ggplot2)
library(reshape2)

# Input data
raw_data_2018<-read.csv(here::here("outputs/data/preparation/GSS2018.csv"))

# extract the income and race columns
income_race_data <- raw_data_2018[, c("race", "income")]

# calculate the number of income based on race
income_race_data <- income_race_data %>%
  group_by(race, income) %>%
  summarize(freq = n())

# add two empty rows for black income level 4, and black income level 6 to keep consistent
new_row <- data.frame(race = 2, income = 4, freq = 0)
income_race_data <- dplyr::bind_rows(income_race_data[1:15,], new_row, income_race_data[16:nrow(income_race_data),])
new_row <- data.frame(race = 2, income = 6, freq = 0)
income_race_data <- dplyr::bind_rows(income_race_data[1:17,], new_row, income_race_data[18:nrow(income_race_data),])

# replace the race code to White, Black, Others
race_replacements <- c("White", "Black", "Others")
income_race_data $race <- ifelse(income_race_data $race == 1, race_replacements[1],
                                 ifelse(income_race_data $race == 2, race_replacements[2], 
                                        race_replacements[3]))

# replace the income level code to White, Black, Others
income_race_data <- income_race_data %>%
  mutate(income = case_when(
    income == 1 ~ "LT $1000",
    income == 2 ~ "$1000 TO 2999",
    income == 3 ~ "$3000 TO 3999",
    income == 4 ~ "$4000 TO 4999",
    income == 5 ~ "$5000 TO 5999",
    income == 6 ~ "$6000 TO 6999",
    income == 7 ~ "$7000 TO 7999",
    income == 8 ~ "$8000 TO 9999",
    income == 9 ~ "$10000 - 14999",
    income == 10 ~ "$15000 - 19999",
    income == 11 ~ "$20000 - 24999",
    income == 12 ~ "$25000 OR MORE",
    TRUE ~ as.character(income)
  ))

# rename the column
income_race_data <-
  income_race_data |>
  rename(
    the_number_of_people = freq
  )

# save the data frame as a csv file
write.csv(income_race_data, file = here::here("outputs/data/race_income.csv"), row.names = TRUE)


