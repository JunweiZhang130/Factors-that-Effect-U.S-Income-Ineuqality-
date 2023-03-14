#### Preamble ####
# Purpose: data cleaning for three year income
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
income_2018<-read.csv(here::here("outputs/data/preparation/GSS2018.csv")) %>% select(income)
income_2016<-read.csv(here::here("outputs/data/preparation/GSS2016.csv")) %>% select(rincome)
income_2014<-read.csv(here::here("outputs/data/preparation/GSS2014.csv")) %>% select(rincome)

# rename the column
income_2016 <-
  income_2016|>
  rename(
    income = rincome
  )
income_2014 <-
  income_2014|>
  rename(
    income = rincome
  )

# Combine the data frames and add a column for the file name
income_data <- bind_rows(
  data.frame(year = "2018", income = income_2018),
  data.frame(year = "2016", rincome = income_2016),
  data.frame(year = "2014", rincome = income_2014))

# group by year and income, count the number
income_data_count <- income_data %>%
  group_by(year, income) %>%
  count() %>%
  rename(number = n)

# replace the income level code
income_data_count <- income_data_count %>%
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
income_data_count <-
  income_data_count|>
  rename(
    Number = number,
    Year = year,
    Income = income
  )

# aggregate number column for each income level
Number_Sum <- income_data_count %>%
  group_by(Income) %>%
  summarise(total = sum(Number))

# merge with original data frame to get percentage
income_data_percentage <- income_data_count %>%
  left_join(Number_Sum, by = "Income") %>%
  group_by(Year, Income) %>%
  mutate(Percentage = Number/ total * 100) %>%
  select(-total)

# save as csv file
write.csv(income_data_percentage, file = here::here("outputs/data/income_3years.csv"), row.names = TRUE)