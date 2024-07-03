library(tidyverse)
library(rvest)
library(dplyr)

html <- read_html("https://en.wikipedia.org/wiki/Tourism_in_India")
names <- html %>% html_elements(".gallerytext") %>% html_text()

#We will extract the list of tourist destinations in India
spl <- strsplit(names, "\n")
tourism <- NULL
for (i in 1:97)
{
  tourism[i] <- spl[[i]][2]
}


tourism_1 <- tourism[1:84]

#Now we have to map all these destinations with the region 
#they are located in eg north, south, central, east, west
part_of_india <- NULL

i <- 1
while(i<= 21)
{
  part_of_india[i] <- "North India"
  i <- i+1
}

j <- 22
while(j<= 36)
{
  part_of_india[j] <- "South India"
  j <- j+1
}

k <- 37
while(k<= 49)
{
  part_of_india[k] <- "Central India"
  k <- k+1
}

l <- 50
while(l<= 65)
{
  part_of_india[l] <- "West India"
  l <- l+1
}

m <- 66
while(m<= 78)
{
  part_of_india[m] <- "East India"
  m <- m+1
}

n <- 79
while(n<= 84)
{
  part_of_india[n] <- "NorthEast India"
  n <- n+1
}

#Now we create a dataframe df which gives us the list of 
#tourist destinations in that region
df <- data.frame(part_of_india , tourism_1)
df