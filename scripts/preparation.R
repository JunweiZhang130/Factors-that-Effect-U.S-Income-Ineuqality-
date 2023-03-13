#### Preamble ####
# Purpose: Preparation for further data cleaning.
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 11 March 2023 
# Contact: myra.li@mail.utoronto.ca/yx.fan@mail.utoronto.ca


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
raw_data_2014<-read_dta(here::here("inputs/data/GSS2014.dta"))
raw_data_2016<-read_dta(here::here("inputs/data/GSS2016.dta"))
raw_data_2018<-read_dta(here::here("inputs/data/GSS2018.dta"))

# Select only certain columns
data_2014 <-
  raw_data_2014 |>
  select(
    id,
    educ,
    majorcol,
    rincome,
    race,
    sex
  )

data_2016 <-
  raw_data_2016 |>
  select(
    id,
    educ,
    majorcol,
    rincome,
    race,
    sex
  )

data_2018 <-
  raw_data_2018 |>
  select(
    id,
    educ,
    majorcol,
    rincome,
    race,
    sex
  )

# Delete the line if the value is NA
data_2014 <- na.omit(data_2014)
data_2016 <- na.omit(data_2016)
data_2018 <- na.omit(data_2018)

# Rename the column
data_2014 <-
  data_2014 |>
  rename(
    edu_year = educ,
    major = majorcol,
    income = rincome
  )

data_2016 <-
  data_2016 |>
  rename(
    edu_year = educ,
    major = majorcol,
    income = rincome
  )

data_2018 <-
  data_2018 |>
  rename(
    edu_year = educ,
    major = majorcol,
    income = rincome
  )

# Save data
write.csv(data_2014, file = here::here("outputs/data/preparation/GSS2014.csv"), row.names = FALSE)
write.csv(data_2016, file = here::here("outputs/data/preparation/GSS2016.csv"), row.names = FALSE)
write.csv(data_2018, file = here::here("outputs/data/preparation/GSS2018.csv"), row.names = FALSE)
