#### Preamble ####
# Purpose: data cleaning for race
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

# Input data
raw_data_2018<-read.csv(here::here("outputs/data/preparation/GSS2018.csv"))
