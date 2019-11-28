
#######FUNCTIONS
##Loop
##If-Else, eg. check condition


a <- 2

if (a>0)
{print("it is a positive number")
} else{
  print("number is not positive")
}


if (a==1)
{print("you won 1€")
} else if(a==2){
  print("you won 2³")
}else {
  print("you loose all")
}

#or
ifelse(a==2, "won","loose")

#for/Repeat -> for loops in R are slow...!!!

for (i in 1:100){
  print(i)
  
}

#While Loop e.g. create buffer around cities until the buffer oberlap
#version1
j <- 0
while (j<1)
{
  j <- j+0.1; print (j)
}

#version2
j <- 0

while (j<1){
  print (j)
  j <- j+0.1; 
}

#functions

#myfunction <- function(arg1,arg2,....){
#  statements
#  return (Object)
#}

#myfunction <- function (x,y){
#  z <- y+x
#  return(z)
#}

#paste - space betwenn, space0, no spae
greet <- function(name){
  paste("how are your",name)
}

greet <- function(name) {glue::glue("how are your,{name}")}

greet("Martin")

fun_ndvi <- function(nir,red) {(nir-red)/(nir+red)}  

#calc function to raster calculation, you dont need to extract values
output <- calc(nir,red,fun=fun_ndvi)  


##"morning" is default
hello_eagles <- function(name,daytime="morning"){
  paste0("hello, ", paste0(eagles, collapse=", "), "!")
}


# Random:: --> see all functions of the package


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


