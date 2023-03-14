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
raw_data_2016<-read.csv(here::here("outputs/data/preparation/GSS2016.csv")) 
raw_data_2014<-read.csv(here::here("outputs/data/preparation/GSS2014.csv")) 

# extract the income and race columns
employee_status_2018 <- raw_data_2018[, c("employee_status", "income")]
employee_status_2016 <- raw_data_2016[, c("employee_status", "income")]
employee_status_2014 <- raw_data_2014[, c("employee_status", "income")]

# combine three files into one
employee_status_data <- bind_rows(
  employee_status_2018 %>% mutate(year = "2018"),
  employee_status_2016 %>% mutate(year = "2016"),
  employee_status_2014 %>% mutate(year = "2014")
)

# only keep the income level 12
# calcualte the number of each emplyee status by year
employee_status_data <- income_data %>% 
  filter(income == 12) %>% 
  group_by(employee_status, year) %>% 
  summarize(freq = n())

# replace the employee status code 
employee_status_replacements <- c("Self-employed", "Someone else")
employee_status_data$employee_status <- ifelse(employee_status_data$employee_status == 1, 
                                                      employee_status_replacements[1],
                                                      employee_status_replacements[2])