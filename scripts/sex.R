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

# input data
raw_data_2018<-read.csv(here::here("outputs/data/preparation/GSS2018.csv")) 
raw_data_2016<-read.csv(here::here("outputs/data/preparation/GSS2016.csv")) 
raw_data_2014<-read.csv(here::here("outputs/data/preparation/GSS2014.csv")) 

# extract the income and sex columns
sex_2018 <- raw_data_2018[, c("sex", "income")]
sex_2016 <- raw_data_2016[, c("sex", "income")]
sex_2014 <- raw_data_2014[, c("sex", "income")]

# combine three files into one
sex_data <- bind_rows(
  sex_2018 %>% mutate(year = "2018"),
  sex_2016 %>% mutate(year = "2016"),
  sex_2014 %>% mutate(year = "2014")
)

# only keep the income level 12
# calcualte the number of each sex by year
sex_data <- sex_data %>% 
  filter(income == 12) %>% 
  group_by(sex, year) %>% 
  summarize(people = n())

# replace the sex code 
sex_replacements <- c("Male", "Female")
sex_data$sex <- ifelse(sex_data$sex == 1, 
                       sex_replacements[1],
                       sex_replacements[2])

# save the data frame as a csv file
write.csv(sex_data, file = here::here("outputs/data/sex_data.csv"), row.names = TRUE)
