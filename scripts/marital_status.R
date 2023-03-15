#### Preamble ####
# Purpose: data cleaning for marital status
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
marital_status_data <- raw_data[, c("Marital_status","Happy","Year")]


# replace the degree code 
marital_status_replacements <- c("Married", "Widowed", "Divorced", 
                                "Separated", "Never married")

marital_status_data$Marital_status <- ifelse(marital_status_data$Marital_status == 1, marital_status_replacements[1],
                                           ifelse(marital_status_data$Marital_status == 2, marital_status_replacements[2],
                                                  ifelse(marital_status_data$Marital_status == 3, marital_status_replacements[3],
                                                         ifelse(marital_status_data$Marital_status == 4, marital_status_replacements[4],
                                                                ifelse(marital_status_data$Marital_status == 5, marital_status_replacements[5], 
                                                                       NA)))))

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
marital_status_data$Happy <- ifelse(marital_status_data$Happy == 1, happy_replacements[1],
                                   ifelse(marital_status_data$Happy == 2, happy_replacements[2],
                                          happy_replacements[3]))

# save the data frame as a csv file
write.csv(marital_status_data, file = here::here("outputs/data/marital_status_data.csv"), row.names = TRUE)


