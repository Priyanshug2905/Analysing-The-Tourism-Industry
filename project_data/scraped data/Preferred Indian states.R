library(tidyverse)
library(rvest)
library(dplyr)

#This site contains statistics of our tourism industry
html <- read_html("https://en.wikipedia.org/wiki/Tourism_in_India")
data <- html %>% html_table()

outside <- data[[8]]
inside <- data[[9]]

outside <- outside[1:10,]
inside <- inside[1:10,]