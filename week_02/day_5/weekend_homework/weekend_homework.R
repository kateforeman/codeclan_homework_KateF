
library(tidyverse) 
library(dplyr) 
library(assertr)

#Read the data into R 


meteorite_data <- read_csv("meteorite_landings.csv") 
str(meteorite_data) 
head(meteorite_data) 


#Change the names of the variables to follow our naming standards 


library(janitor) 
clean_meteorite_data <- clean_names(meteorite_data)


#Split in column GeoLocation into latitude and longitude, the new latitude and longitude columns should be numeric 


seperated_clean_meteorite_data <- clean_meteorite_data %>%
  mutate(geo_location = gsub("[^0-9,.-]", "", geo_location)) %>%
  separate(geo_location, c("latitude", "longitude"), sep = ",") %>%
  mutate(latitude = as.numeric(latitude)) %>%
  mutate(longitude = as.numeric(longitude)) 



seperated_clean_meteorite_data 


#Replace any missing values in latitude and longitude with zeros 


clean_lat_long_columns <- seperated_clean_meteorite_data %>% 
  mutate(latitude = coalesce(latitude, 0)) %>% 
  mutate(longitude = coalesce(longitude, 0))


#Remove meteorites less than 1000g in weight from the data 


filtered_weight_meteorite_data <- clean_lat_long_columns %>% 
  filter(mass_g > 1000)


#Order the data by the year of discovery 


meteorite_arranged_by_year <- filtered_weight_meteorite_data %>% 
  group_by(year) %>% 
  arrange(year)


#We would also like you to include assertive programming to make sure that:
  
#1. The data has the variable names we expect (“id”, “name”, “mass (g)”, “fall”, “year”, “GeoLocation”) 
#2. Latitude and longitude are valid values. (Latitude between -90 and 90, longitude between -180 and 180) 


meteorite_arranged_by_year %>% 
  verify(latitude >= -90 & latitude <= 90) %>% 
  verify(longitude >= -180 & longitude <= 180) 

