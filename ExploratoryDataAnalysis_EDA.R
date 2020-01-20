#install.packages("visdat")
library(visdat)

data(cars)
head(cars)

#visualize the data
vis_dat(cars)
vis_dat(cars, sort_type=FALSE)

#visualize missing data

vis_miss(cars)

#or

#install.packages("dataMaid")
library(dataMaid)

#create report

makeDataReport(cars)

#check the data
check(cars)

#visualize the data
visualize(cars)
