###classifcation - Qgis and R
library(RStoolbox)
library(rgdal)
library(raster)


td <- readOGR("C:/Users/Annika/Documents/R_Classifcation/TrainingData3.shp")
allbands <- brick("C:/Users/Annika/Documents/R_Classifcation/Raster_virtuel2.tif")

#hold out proportion

library(dismo)

try <- kfold(td, k=3)

sc_rf <- superClass(allbands, trainData=td, responseCol = "class_name", trainPartition = 0.5, model="rf")
sc_mlc <- superClass(allbands, trainData=td, responseCol = "class_name", trainPartition = 0.5, model="mlc")
sc_svmRadial <- superClass(allbands, trainData=td, responseCol = "class_name", trainPartition = 0.5, model="svmRadial")

sc1 <- sc_rf$validation$performance$overall[1]
sc2 <- sc_mlc$validation$performance$overall[1]
sc3 <- sc_svmRadial$validation$performance$overall[1]

sc <- as.data.frame(cbind(sc1,sc2,sc3))

# pr-defined hold-outs

try <- kfold(td, k=3)

sc <- superClass(allbands, trainData=td, valData=valdidationPolygons, responseCol = "class_name")

sc$validation$performance


plot(sc$map)


################## Loop vs. Apply

m <- matrix(data=cbind(rnorm(30,0), rnorm(30,2), rnorm(30,5)), nrow=30, ncol=3)

mean <- mean(m)

mean (m[,1])
mean (m[,2])

# or

m.mean <- vector()
for(i in 1:ncol(m))
  {m.mean[i] <- mean(m[,1]) 
  }

#apply 
apply(m, 1, mean)
apply(m, 2, mean)

apply (m, 2, function(x) length(x[x<0]))



#sapply: insert a list or vector data and all values will be run through this function

sapply(1:3, function(x) x^2)

#------------------------------------
#reshaphing your data
#------------------------------------

#packages: reshape2, tidyr, dplyr

#try with lsat-Data:

fieldata_wide <- read.table (header)

