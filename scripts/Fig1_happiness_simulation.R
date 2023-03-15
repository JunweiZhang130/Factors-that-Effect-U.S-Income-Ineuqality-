#### Preamble ####
# Purpose: Simulates the figure 1 (Fig1-Changes in happiness levels from 1972 to 2021) raw data
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 11 March 2023 
# Contact: junwei.zhang@mail.utoronto.ca/yx.fan@mail.utoronto.ca/myra.li@mail.utoronto.ca

library(janitor)
library(tibble)
library(tidyverse)

# Create vectors for each column
year <- rep(1972:2021, each = 3)
happy_level <- rep(1:3, length(year)/3)
people <- sample(1:100, length(year), replace = TRUE)

# Combine vectors into a tibble
simulated_data_happiness <- tibble(year, happy_level, people)

head(simulated_data_happiness)