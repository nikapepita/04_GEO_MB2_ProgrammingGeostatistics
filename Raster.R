#("RCurl")

# get Data from GitHub from another User e.g. Martin df <- read.csv("https://raw.githubusercontent.com/

#download file from https://github.com/wegmann/R_data repository

#df <- read.csv('./')#with that command you start on your getwd, with tab you can choose folders or files

#df <- read.csv("sample_points_all_data_subset_withNames.csv")

#alternativ import - acess online
library(RCurl)
df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")
#other package: tidyverse

#check data
head(df)

#Indexin Dataframe

#Select Column 
df[,1]
df[[1]]
#Select row
df$LUCAS_LC
#select second last column
df[,length(df)-2]
#select all columns, but first 10 rows
df[1:10,]
#select column LUCAS_LC, SRTM
df[c("LUCAS_LC","SRTM")]

df [,c(2,13)]
##Plot Stuff
head(df)


plot(df[df$L8.ndvi>0.4, "SRTM"])

subset(df$SRTM, df$L8.ndvi<0.44)

#Indexing Dataframe by different rules
# df[rule, access]
c <- df[df$SRTM>10 & df$LCname=="cropland", "L8.ndvi"]
c <- df[df$SRTM>10 & df$LCname=="cropland", "L8.ndvi"]
c <- data.frame(df[df$L8.ndvi>0.5,1:45])

plot(df[df$L8.ndvi>0.4, c("SRTM","LUCAS_LC")])

###DF to SPDF

#install.packages("SPDF")
#create a copy
spdf.obj <- df
#check names
names(spdf.obj)

library(sp)
#define coordinates
coordinates(spdf.obj) <- ~x+y

#install.packages("rgdal")
library(rgdal)
#projection
proj4string(spdf.obj) <- CRS("+init=epsg:32632")

plot(spdf.obj)

str(spdf.obj)
head(spdf.obj)

#add dataframe to spatial point object
spdf.obj@data <- df

library(rgdal)

#Write Shapefiel
writeOGR(spdf.obj,"test.shp",driver="ESRI Shapefile","data")

spdf.obj[c(1:10),1] #first column, 10 variables

# extract data and convert it back to data.frame
x <- as.data.frame(spdf.obj[c(1:10),1:2]) 



#install.packages("raster")
library(raster)

df$measure1
#check the length of the column
length(df$LUCAS_LC)

#create empty raster
r1 <- raster(nrows=100,ncols=100)
#populate empty raster with columsn values
r1[] <- df$L8.ndvi[1:1000]
plot(r1)

r2 <- raster(nrows=100,ncols=100)
r2[] <- df$L7.ndvi[1:1000]
plot(r2)

#stack raster together
r12 <- stack(r1,r2)
plot(r12)

#plot 1 raster
plot(r12 [[1]])

##Raster Calculation
#Create a new raster layer
r12$new <- r12[[1]]*r12[[2]]^2
r12

plot(r12)
#Convert back to Dataframe
df12 <- r12[]
head(df12)

#Create raster from scratch

library(raster)
#empty raster
r3 <- raster(nrows=10, ncols=10)
#fill raster
r3[] <- rnorm(100) ##Without brackets you create a vector!!!
plot(r3)