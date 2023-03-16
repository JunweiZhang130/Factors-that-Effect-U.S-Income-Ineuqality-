#### Preamble ####
# Purpose: data cleaning for degree
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
degree_data <- raw_data[, c("Degree","Happy_level","Year")]

# replace the degree code 
degree_replacements <- c("Less than high school", "High school", "Associate/junior college", 
                         "Bachelor's", "Graduate")
degree_data$Degree <- ifelse(degree_data$Degree == 0, degree_replacements[1],
                         ifelse(degree_data$Degree == 1, degree_replacements[2],
                                ifelse(degree_data$Degree == 2, degree_replacements[3],
                                       ifelse(degree_data$Degree == 3, degree_replacements[4],
                                              ifelse(degree_data$Degree == 4, degree_replacements[5], NA)))))

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
degree_data$Happy <- ifelse(degree_data$Happy == 1, happy_replacements[1],
                          ifelse(degree_data$Happy == 2, happy_replacements[2],
                                 happy_replacements[3]))

# save the data frame as a csv file
write.csv(degree_data, file = here::here("outputs/data/degree_data.csv"), row.names = TRUE)
