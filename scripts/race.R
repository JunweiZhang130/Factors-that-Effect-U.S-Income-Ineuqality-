#### Preamble ####
# Purpose: data cleaning for race
# Author: Rae Zhang, Faustine Fan, Myra Li
# Data: 11 March 2023 
# Contact: junwei.zhang@mail.utoronto.ca/yx.fan@mail.utoronto.ca/myra.li@mail.utoronto.ca

# input data
raw_data_2018<-read.csv(here::here("outputs/data/preparation/GSS2018.csv")) 
raw_data_2016<-read.csv(here::here("outputs/data/preparation/GSS2016.csv")) 
raw_data_2014<-read.csv(here::here("outputs/data/preparation/GSS2014.csv")) 

# extract the income and race columns
race_2018 <- raw_data_2018[, c("race", "income")]
race_2016 <- raw_data_2016[, c("race", "income")]
race_2014 <- raw_data_2014[, c("race", "income")]

# combine three files into one
race_data <- bind_rows(
  race_2018 %>% mutate(year = "2018"),
  race_2016 %>% mutate(year = "2016"),
  race_2014 %>% mutate(year = "2014")
)

# only keep the income level 12
# calcualte the number of each race by year
race_data <- race_data %>% 
  filter(income == 12) %>% 
  group_by(race, year) %>% 
  summarize(people = n())

# replace the college science course code 
race_replacements <- c("White", "Black","Others")
race_data$race <- ifelse(race_data$race == 1, race_replacements[1],
                                ifelse(race_data$race == 2, race_replacements[2],
                                       race_replacements[3]))

# save the data frame as a csv file
write.csv(race_data, file = here::here("outputs/data/race_data.csv"), row.names = TRUE)


