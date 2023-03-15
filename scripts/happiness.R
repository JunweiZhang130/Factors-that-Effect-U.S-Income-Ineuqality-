#### Preamble ####
# Purpose: data cleaning for all year happiness
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

## input data
raw_data<-read.csv(here::here("outputs/data/raw_data.csv")) 

# extract the income and race columns
happiness_data <- raw_data[, c("Happy","Year")]

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
happiness_data$Happy <- ifelse(happiness_data$Happy == 1, happy_replacements[1],
                         ifelse(happiness_data$Happy == 2, happy_replacements[2],
                                happy_replacements[3]))

# calcualte the number of people by year
happiness_data <- happiness_data %>% 
  group_by(Year, Happy) %>% 
  summarize(People = n())

# save the data frame as a csv file
write.csv(happiness_data, file = here::here("outputs/data/happiness_data.csv"), row.names = TRUE)