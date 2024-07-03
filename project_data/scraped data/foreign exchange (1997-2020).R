library(tidyverse)
library(rvest)
library(dplyr)

#This site contains statistics of our tourism industry
html <- read_html("https://en.wikipedia.org/wiki/Tourism_in_India")
data <- html %>% html_table()

#here we have created a dataframes

#This dataframe represents the number of foreign tourist 
# visiting india between 1997 and 2020
tourist_arrival <- data[[4]]
tourist_arrival <- tourist_arrival %>% slice(1:24)

#This dataframe represents the amount of money spent by the foreign tourist
forex <- data[[5]]

#this table ranks the source country of money gained in tourism
source_count <- data[[6]]

#This dataframe specifies the top 10 states which attracts the most foreign tourist
foreign_visit <- data[[8]]

#This dataframe specifies the top 10 states which attracts the most domestic tourist
domestic_visit <- data[[9]]

#this is a plot representing variation of number of arrivals in india 
#with respect to time (in years)
year <- tourist_arrival$Year
arrival_in_million <- tourist_arrival$`Arrivals (millions)`
plot(year , arrival_in_million , type = "o")











