##Indices
#install.packages("RStoolbox")
library(RStoolbox)
library(raster)
#Load lsat-data
data(lsat)

#Define NDVI function 

fun_ndvi <- function(nir, red){
  (nir-red)/(nir+red)
}

ndvi2 <- overlay(lsat$B4_dn,lsat$B3_dn, fun=fun_ndvi)
plot(ndvi2)

#Define SAVIfunction 

fun_savi <- function(nir, red){
  ((nir-red)/(nir+red+0.5))*(1+0.5)
}

savi <- overlay(lsat$B4_dn,lsat$B3_dn, fun=fun_savi)

ndvi2 <- calc(lsat, fun= function(x){(x[,4]-x[,3])/(x[,4]+x[,3])},forefun=TRUE)

plot(ndvi2)

##Use RStoolbox
#many Indices!

NDVI <- spectralIndices(lsat,red="B3_dn",nir="B4_dn", indices="NDVI")
SAVI <- spectralIndices(lsat,red="B3_dn",nir="B4_dn", indices="SAVI")

plot(NDVI)
plot(SAVI)


#plot rgb image:

ggRGB(lsat, r=4, g=3,b=2,alpha=0.5, stretch="lin")

library(RStoolbox)
library(raster)
data(lsat)

##all sprectral indices

all <- spectralIndices(lsat,blue=1, green=2,red=3, nir=4, swir3=7)


var <- calc(all, fun = var)
mean <- calc(all, fun = mean)
max <- calc(all, fun = max)


######unsupervised classification in R

library(raster)
library(cluster)

#raster data to data frame
raster <- lsat[[1:3]]

#raster data to data frame
raster_df <- lsat[]

#actual clustering
kmeans_out <- kmeans(raster_df, 12, iter.max = 100, nstart = 10)

#copy raster
kmeans_raster <- raster(raster)

#assign values to raster
kmeans_raster [] <- kmeans_out$cluster 
plot(kmeans_raster)

#unsupervised classification
uc <- unsuperClass(lsat, nClasses=3)
ggR(uc$map, forceCat= TRUE, geom_raster= TRUE)