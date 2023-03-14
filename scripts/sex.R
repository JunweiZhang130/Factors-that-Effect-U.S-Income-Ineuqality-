#### Preamble ####
# Purpose: data cleaning for sex
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
income_sex_data <- raw_data_2018[, c("sex", "income")]

# calculate the number of income based on race
income_sex_data <- income_sex_data %>%
  group_by(sex, income) %>%
  summarize(freq = n())

# add one empty rows for male income level 6, and black income level 6 to keep consistent
new_row <- data.frame(sex = 1, income = 6, freq = 0)
income_sex_data <- dplyr::bind_rows(income_sex_data[1:5,], new_row, income_sex_data[6:nrow(income_sex_data),])

# replace the sex code to Male and Female 
sex_replacements <- c("Male", "Female")
income_sex_data$sex <- ifelse(income_sex_data$sex == 1, sex_replacements[1],
                                sex_replacements[2])

# replace the income level code
income_sex_data <- income_sex_data %>%
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
income_sex_data <-
  income_sex_data |>
  rename(
    The_Number_Of_People = freq,
    Sex = sex,
    Income = income
  )

# aggregate the_number_of_people column for each income level
The_Number_Of_People_Sum <- income_sex_data %>%
  group_by(Income) %>%
  summarise(total = sum(The_Number_Of_People))

# merge with original data frame to get percentage
income_sex_data_percentage <- income_sex_data %>%
  left_join(The_Number_Of_People_Sum, by = "Income") %>%
  group_by(Sex, Income) %>%
  mutate(Percentage = The_Number_Of_People / total * 100) %>%
  select(-total)

# save the data frame as a csv file
write.csv(income_sex_data_percentage, file = here::here("outputs/data/sex_income.csv"), row.names = TRUE)
