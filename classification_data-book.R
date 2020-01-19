########################################################
########################################################
#postclassification
########################################################
########################################################
library(RStoolbox)
library(raster)
library(rgdal)

setwd("C:/Users/Annika/Documents/Git/04_GEO_MB2_ProgrammingGeostatistics/")

########################################################
#postclassification
########################################################


Isat88 <- brick("./data_book/raster_data/final/p224r63_1988.gri")
Isat11 <- brick("./data_book/raster_data/final/p224r63_2011.gri")

#traindata for each year
td_88 <- readOGR("./data_book/vector_data/training_1988.shp")
td_11 <- readOGR("./data_book/vector_data/training_2011.shp")

#Classification
sc_88 <- superClass(Isat88, trainData=td_88, responseCol = "class_name", 
model = "rf", tuneLength = 1, trainPartition = 0.7)

sc_11 <- superClass(Isat88, trainData=td_11, responseCol = "class_name", 
model = "rf", tuneLength = 1, trainPartition = 0.7)

sc88x10 <- sc88$map*10
sc88_11 <- sc88x10+sc11$map

########################################################
#multidate
########################################################

Isat88 <- brick("./data_book/raster_data/final/p224r63_1988.gri")
Isat11 <- brick("./data_book/raster_data/final/p224r63_2011.gri")

Isat88_11 <- stack(Isat88,Isat11)

#traindata for each year
td_88_11 <- readOGR("./data_book/polygon_shape_file_1988_2011.shp")

#Classification
sc_88_11 <- superClass(Isat88_11, trainData=td_88_11, responseCol = "class", 
model = "rf", tuneLength = 1, trainPartition = 0.7)

########################################################
#Change vector Analysis
########################################################

x88 <- brick("./data_book/raster_data/final/p224r63_1988.gri")
x11 <- brick("./data_book/raster_data/final/p224r63_2011.gri")

#change vector analysis using RED and NIR band:

cva_88_11 <- rasterCVA(x88[[3:4]],x11[[3:4]])

#or using two indices instead of surface reflectance

#tasseledCap analysis producing greeness, wetness and brightness
tc_88 <- tasseledCap(x88[[c(1:5,7)]], sat="Landsat5TM")
tc_11 <- tasseledCap(x11[[c(1:5,7)]], sat="Landsat5TM")

#change vector analysis using wetness and greeness
cvat_tc_88_11 <- rasterCVA(tc_88[[2:3]], tc_11[[2:3]])

########################################################
#Accurarcy
########################################################

sc_88_11 <- sc_88_11$validation$performance$overall[1]