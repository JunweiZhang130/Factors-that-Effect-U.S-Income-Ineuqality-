#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Data: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


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
raw_data_2016<-read_dta(here::here("inputs/data/GSS2016.dta"))
raw_data_2018<-read_dta(here::here("inputs/data/GSS2018.dta"))
raw_data_2021<-read_dta(here::here("inputs/data/GSS2021.dta"))

### Clean data ###
data_2016 <-
  raw_data_2016 |>
  # Select only certain columns
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
  # Select only certain columns
  select(
    id,
    educ,
    majorcol,
    rincome,
    race,
    sex
  )
data_2021 <-
  raw_data_2021 |>
  # Select only certain columns
  select(
    id,
    educ,
    race,
    sex
  )
write.csv(data_2016, file = here::here("outputs/data/GSS2016.csv"), row.names = FALSE)
write.csv(data_2018, file = here::here("outputs/data/GSS2018.csv"), row.names = FALSE)
write.csv(data_2021, file = here::here("outputs/data/GSS2021.csv"), row.names = FALSE)