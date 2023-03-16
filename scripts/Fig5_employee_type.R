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
employee_type_data <- raw_data[, c("Employee_status","Happy_level","Year")]

# replace the employee status code 
Employee_type_replacements <- c("Self-employed", "Someone else")
employee_type_data$Employee_type <- ifelse(employee_type_data$Employee_type == 1, 
                                               Employee_type_replacements[1],
                                               Employee_type_replacements[2])

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
employee_type_data$Happy_level <- ifelse(employee_type_data$Happy_level == 1, 
                                           happy_replacements[1],
                          ifelse(employee_type_data$Happy_level == 2, happy_replacements[2],
                                 happy_replacements[3]))

# save the data frame as a csv file
write.csv(employee_type_data, file = here::here("outputs/data/employee_status_data.csv"), row.names = TRUE)



