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

## input data
raw_data<-read.csv(here::here("outputs/data/raw_data.csv")) 

# extract the income and race columns
sex_data <- raw_data[, c("Sex", "Happy","Year")]

# replace the sex code 
sex_replacements <- c("Male", "Female")
sex_data$Sex <- ifelse(sex_data$Sex == 1, 
                       sex_replacements[1],
                       sex_replacements[2])

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
sex_data$Happy <- ifelse(sex_data$Happy == 1, happy_replacements[1],
                          ifelse(sex_data$Happy == 2, happy_replacements[2],
                                 happy_replacements[3]))

# save the data frame as a csv file
write.csv(sex_data, file = here::here("outputs/data/sex_data.csv"), row.names = TRUE)

