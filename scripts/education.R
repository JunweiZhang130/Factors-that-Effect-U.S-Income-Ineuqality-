#### Preamble ####
# Purpose: data cleaning for education
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
income_eduyear_data <- raw_data_2018[, c("edu_year", "income")]

# calculate the number of income based on race
income_eduyear_data <- income_eduyear_data %>%
  group_by(edu_year, income) %>%
  summarize(freq = n())

# rename the column
income_eduyear_data <-
  income_eduyear_data |>
  rename(
    The_Number_Of_People = freq,
    EduYear = edu_year,
    Income = income
  )

# aggregate the_number_of_people column for each income level
The_Number_Of_People_Sum <- income_eduyear_data %>%
  group_by(Income) %>%
  summarise(total = sum(The_Number_Of_People))

# merge with original data frame to get percentage
income_eduyear_data_percentage <- income_eduyear_data %>%
  left_join(The_Number_Of_People_Sum, by = "Income") %>%
  group_by(EduYear, Income) %>%
  mutate(Percentage = The_Number_Of_People / total * 100) %>%
  select(-total)

# save the data frame as a csv file
write.csv(income_eduyear_data_percentage, file = here::here("outputs/data/eduyear_income_data.csv"), row.names = TRUE)


