install.packages("RCurl")

# get Data from GitHub from another User e.g. Martin df <- read.csv("https://raw.githubusercontent.com/

#download file from https://github.com/wegmann/R_data repository

df <- read.csv('./')#with that command you start on your getwd, with tab you can choose folders or files

df <- read.csv("sample_points_all_data_subset_withNames.csv")

#alternativ import - acess online
library(RCurl)
df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")
#other package: tidyverse

#check data
head(df)

#Index: PRACTICE!!!! Index and plot with index!

df[1,] 
df[,1]

df$LUCAS_LC
df[,2]
df[,3:12]
df[,length(df)-1]
df[1:10,]
df[,c(c,13)]


#DF to SPDF

install.packages("SPDF")
spdf.obj <- df
names(spdf.obj)
library(sp)
coordinates(spdf.obj) <- ~x+y

install.packages("rgdal")
library(rgdal)
proj4string(spdf.obj) <- CRS("+init=epsg:32632")

plot(spdf.obj)

str(spdf.obj)
head(spdf.obj)

library(rgdal)

writeOGR(spdf.obj,"test.shp",driver="ESRI Shapefile","data")

spdf.obj[c(1:10),1] #first column, 10 variables

x <- as.data.frame(spdf.obj[c(1:10),1:2]) # extract data and convert it back to data.frame



install.packages("raster")
library(raster)

df$measure1
length(df$LUCAS_LC)

r1 <- raster(nrows=100,ncols=100)
r1[] <- df$L8.ndvi[1:1000]
plot(r1)

r2 <- raster(nrows=100,ncols=100)
r2[] <- df$L7.ndvi[1:1000]
plot(r2)

r12 <- stack(r1,r2)
plot(r12)

r12$new <- r12[[1]]*r12[[2]]^2
r12

plot(r12)
df12 <- r12[]
head(df12)