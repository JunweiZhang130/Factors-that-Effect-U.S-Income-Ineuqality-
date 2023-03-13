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

# save the data frame as a csv file
write.csv(subset_data_freq, file = here::here("outputs/data/race_income.csv"), row.names = TRUE)


