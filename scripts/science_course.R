#### Preamble ####
# Purpose: data cleaning for college science course
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

# extract the income and science course columns
science_course_2018 <- raw_data_2018[, c("science_course", "income")]
science_course_2016 <- raw_data_2016[, c("science_course", "income")]
science_course_2014 <- raw_data_2014[, c("science_course", "income")]

# combine three files into one
science_course_data <- bind_rows(
  science_course_2018 %>% mutate(year = "2018"),
  science_course_2016 %>% mutate(year = "2016"),
  science_course_2014 %>% mutate(year = "2014")
)

# only keep the income level 12
# calcualte the number of college science course by year
science_course_data <- science_course_data %>% 
  filter(income == 12) %>% 
  group_by(science_course, year) %>% 
  summarize(people = n())

# replace the college science course code 
science_course_replacements <- c("Yes", "No")
science_course_data$science_course <- ifelse(science_course_data$science_course == 1, 
                                             science_course_replacements[1],
                                             science_course_replacements[2])

# save the data frame as a csv file
write.csv(science_course_data, file = here::here("outputs/data/science_course_data.csv"), row.names = TRUE)


