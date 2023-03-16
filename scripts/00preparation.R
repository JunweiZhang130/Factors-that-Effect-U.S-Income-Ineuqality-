#### Preamble ####
# Purpose: Preparation for further data cleaning.
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

# Input raw data
raw_data<-read_dta(here::here("inputs/data/gss7221_r3b.dta"))

# Select only certain columns
raw_data <- raw_data %>%
  select(
    race,
    year,
    happy,
    degree,
    wrkslf,
    marital,
    sex
  )

# Delete the line if the value is NA
raw_data <- na.omit(raw_data)

# Rename the column
raw_data <-
  raw_data|>
  rename(
    Race = race,
    Year = year,
    Happy_level = happy,
    Degree = degree,
    Marital_status = marital,
    Sex = sex,
    Employee_type = wrkslf,
  )

# Save dat
write.csv(raw_data, file = here::here("outputs/data/raw_data.csv"), row.names = FALSE)
