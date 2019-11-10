###Import CSV Files in R 

##install.packages("RCurl")

#set working directory
getwd()
#alternative: set_dir <- "/"
setwd('./')
# get Data from GitHub from another User e.g. Martin df <- read.csv("https://raw.githubusercontent.com/
#download file from https://github.com/wegmann/R_data repository

df <- read.csv('./')#with that command you start on your getwd, with tab you can choose folders or files

df <- read.csv("sample_points_all_data_subset_withNames.csv")

#alternativ import - acess online
library(RCurl)
df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")
#or
df <- read.table("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv",
                 header=TRUE,sep=",")
head(df)
#other package: tidyverse

#Check File df, head, tail, summary, plot, str, names, dim, 
#class, levels, mode

summary(df[,10])
plot(df [,10])
str(df [,10])

head(df)
dim(df)

#write table
write.table(df,file="my_data.txt")

