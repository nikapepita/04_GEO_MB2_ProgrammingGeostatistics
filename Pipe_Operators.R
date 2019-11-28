##Pipe Operators
# %>% - split up nested functions

#log(x)
#is the same as:
#x%>%log()

install.packages("babynames")
library(babynames)
library(dplyr)

temp1 <- filter(babynames,sex=="M",name=="Mary")
temp2 <- select(temp1,5)
temp3 <- sum(temp2)
temp3

babynames%>%filter(sex=="M",name=="Mary")%>%
  select(5)%>%
  sum

babynames%>%filter(sex=="F",name=="Taylor")%>%
  select(6)%>%
  sum


###my own plots 
##open task-add srtm -> terrain profil?
###
library(plyr)
library(ggplot2)
library(base)
library(scales)

#check: ggplot: https://www.datanovia.com/en/blog/how-to-create-a-ggplot-with-multiple-lines/

getwd()
setwd("C:/Users/Annika/Documents/Git/04_GEO_MB2_ProgrammingGeostatistics")

hiking_db2 <- read.csv("LandUse2.csv", header=TRUE, sep=";")
head(hiking_db2)

hiking_db2%>%filter(Name=="Hutten",Year=="2016")%>%
  select(2)%>%
  sum


