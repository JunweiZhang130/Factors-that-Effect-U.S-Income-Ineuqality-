#### Preamble ####
# Purpose: data cleaning for employee status
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

## input data
raw_data<-read.csv(here::here("outputs/data/raw_data.csv")) 

# extract the income and race columns
employee_status_data <- raw_data[, c("Employee_status","Happy","Year")]

# replace the employee status code 
Employee_status_replacements <- c("Self-employed", "Someone else")
employee_status_data$Employee_status <- ifelse(employee_status_data$Employee_status == 1, 
                                               employee_status_replacements[1],
                                               employee_status_replacements[2])

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
employee_status_data$Happy <- ifelse(employee_status_data$Happy == 1, happy_replacements[1],
                          ifelse(employee_status_data$Happy == 2, happy_replacements[2],
                                 happy_replacements[3]))

# save the data frame as a csv file
write.csv(employee_status_data, file = here::here("outputs/data/employee_status_data.csv"), row.names = TRUE)



