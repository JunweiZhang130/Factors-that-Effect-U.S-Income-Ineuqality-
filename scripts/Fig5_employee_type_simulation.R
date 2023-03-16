#### Preamble ####
# Purpose: Simulates the figure 13-15 raw data
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 11 March 2023 
# Contact: junwei.zhang@mail.utoronto.ca/yx.fan@mail.utoronto.ca/myra.li@mail.utoronto.ca

library(janitor)
library(tibble)
library(tidyverse)

set.seed(123)
# Create vectors for each column
year <- sample(1972:2021, 300, replace = TRUE)
happy_level <- rep(1:3, length.out = 300)
employee_type <- sample(c("Self-employed", "Someone else" ), 300, replace = TRUE)

# Combine vectors into a tibble
simulated_data_employee_type <- tibble(year, happy_level, employee_type)

head(simulated_data_employee_type)