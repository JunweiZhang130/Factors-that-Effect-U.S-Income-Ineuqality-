#### Preamble ####
# Purpose: data cleaning for race
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
raw_data<-read.csv(here::here("outputs/data/raw_data.csv")) 

# extract the income and race columns
race_data <- raw_data[, c("Race", "Happy_level","Year")]

# replace the race code 
race_replacements <- c("White", "Black","Others")
race_data$Race <- ifelse(race_data$Race == 1, race_replacements[1],
                         ifelse(race_data$Race == 2, race_replacements[2],
                                race_replacements[3]))

# replace the happy code
happy_replacements <- c("Very happy", "Pretty happy","Not too happy")
race_data$Happy <- ifelse(race_data$Happy == 1, happy_replacements[1],
                         ifelse(race_data$Happy == 2, happy_replacements[2],
                                happy_replacements[3]))

# save the data frame as a csv file
write.csv(race_data, file = here::here("outputs/data/race_data.csv"), row.names = TRUE)
