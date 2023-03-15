#### Preamble ####
# Purpose: Test all cleaned data
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 15 March 2023 
# Contact: junwei.zhang@mail.utoronto.ca/yx.fan@mail.utoronto.ca/myra.li@mail.utoronto.ca

library(tidyverse)

########Input data ########
figure1_data<-read.csv(here::here("outputs/data/happiness_data.csv"))
figure2_4_data<-read.csv(here::here("outputs/data/sex_data.csv"))
figure5_7_data<-read.csv(here::here("outputs/data/race_data.csv"))
figure8_12_data<-read.csv(here::here("outputs/data/degree_data.csv"))
figure13_15_data<-read.csv(here::here("outputs/data/employee_status_data.csv"))
figure16_18_data<-read.csv(here::here("outputs/data/marital_status_data.csv"))

########Figure 1########
#test for year
figure1_data$Year |> min() >= 1972
figure1_data$Year |> max() <= 2021
#test for happy level
figure1_data$Happy |> 
  unique() == c("Not too happy", "Pretty happy", "Very happy")
#test for people
figure1_data$People |> min() >= 0

########Figure 2-4 ########
#test for year
figure2_4_data$Year |> min() >= 1972
figure2_4_data$Year |> max() <= 2021
#test for happy level
figure2_4_data$Happy |> 
  unique() == c("Not too happy", "Pretty happy", "Very happy")
#test for sex
figure2_4_data$Sex |> 
  unique() == c("Female", "Male")

########Figure 5-7 ########
#test for year
figure5_7_data$Year |> min() >= 1972
figure5_7_data$Year |> max() <= 2021
#test for happy level
figure5_7_data$Happy |> 
  unique() == c("Not too happy", "Pretty happy", "Very happy")
#test for race
figure5_7_data$Race |> 
  unique() == c("White", "Black","Others")

########Figure 8-12 ########
#test for year
figure8_12_data$Year |> min() >= 1972
figure8_12_data$Year |> max() <= 2021
#test for happy level
figure8_12_data$Happy |> 
  unique() == c("Not too happy", "Pretty happy", "Very happy")
#test for race
figure8_12_data$Degree |> 
  unique() == c("Bachelor's", "Less than high school","High school","Graduate","Associate/junior college")

########Figure 13-15 ########
#test for year
figure13_15_data$Year |> min() >= 1972
figure13_15_data$Year |> max() <= 2021
#test for happy level
figure13_15_data$Happy |> 
  unique() == c("Not too happy", "Pretty happy", "Very happy")
#test for race
figure13_15_data$Employee_status |> 
  unique() == c("Someone else", "Self-employed")

########Figure 16-18 ########
#test for year
figure16_18_data$Year |> min() >= 1972
figure16_18_data$Year |> max() <= 2021
#test for happy level
figure16_18_data$Happy |> 
  unique() == c("Not too happy", "Pretty happy", "Very happy")
#test for marital status
figure16_18_data$Marital_status |> 
  unique() == c("Never married", "Married","Divorced","Separated","Widowed")