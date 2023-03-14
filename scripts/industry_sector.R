#### Preamble ####
# Purpose: data cleaning for industry sector
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 11 March 2023 
# Contact: junwei.zhang@mail.utoronto.ca/yx.fan@mail.utoronto.ca/myra.li@mail.utoronto.ca

# loading in relevant libraries
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

# extract the income and industry sector columns
industry_sector_2018 <- raw_data_2018[, c("industry_sector", "income")]
industry_sector_2016 <- raw_data_2016[, c("industry_sector", "income")]
industry_sector_2014 <- raw_data_2014[, c("industry_sector", "income")]

# combine three files into one
industry_sector_data <- bind_rows(
  industry_sector_2018 %>% mutate(year = "2018"),
  industry_sector_2016 %>% mutate(year = "2016"),
  industry_sector_2014 %>% mutate(year = "2014")
)

# only keep the income level 12
# calcualte the number of each industry sector by year
industry_sector_data <- industry_sector_data %>% 
  filter(income == 12) %>% 
  group_by(industry_sector, year) %>% 
  summarize(people = n())

# replace the industry sector code 
industry_sector_replacements <- c("Government", "Private")
industry_sector_data$industry_sector <- ifelse(industry_sector_data$industry_sector == 1, 
                                               industry_sector_replacements[1],
                                               industry_sector_replacements[2])

# save the data frame as a csv file
write.csv(industry_sector_data, file = here::here("outputs/data/industry_sector_data.csv"), row.names = TRUE)


