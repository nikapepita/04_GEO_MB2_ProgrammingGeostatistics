###classifcation - Qgis and R
library(RStoolbox)
library(rgdal)
library(raster)


td <- readOGR("C:/Users/Annika/Documents/R_Classifcation/TrainingData2.shp")
allbands <- brick("C:/Users/Annika/Documents/R_Classifcation/Raster_virtuel.tif")

plot(allbands[[1]])
plot(td, add=TRUE)


sc <- superClass(allbands, trainData= td, 
                 responseCol = "class_name", model="rf",
                 filename= "myClassification.tif")

plot(sc$map)


library(maptools)
library(randomForest)
library(raster)

#setwd(„/…/script/“)


#enter path and name (without suffix) to the import vector command

vec <- readOGR("C:/Users/Annika/Documents/R_Classifcation/TrainingData.shp")
satImage <- brick("C:/Users/Annika/Documents/R_Classifcation/Raster_virtuel.tif")

#number of sample per landcoverclass
numsamps <- 100

#Name of the attribute that holds the integer landcovertype identifyer (very important to consinder 
#when doing the training datasets

attName <- 'class_name'

#Name and path of  the outputGeoTiffimage
outImage <- 'classifresult.tif'

#loop over each class, selecting all polygons and assign random points
uniqueAtt <- unique(vec[[attName]])

for (x in 1:length(uniqueAtt)) { #query the number of classes
        classdata <- vec[vec[[attName]]==uniqueAtt[x],] #extract the polygons with class n
        classpts <- spsample (classdata, type = "random", n=numsamps) #set random points in selected polygons
        # first run: create new spatial point rs dataframe, 
        if(x==1){
                xy <-  classpts
        } else {
                xy <-rbind(xy, classpts)
        }
}

#plot the random generated points on one of the raster for visual checking only,
#image will be savecv in the filesystemaspf
# generate a pdf with your raster and sampling points


pdf("training_points.pdf")
image(satImage, 1)
points(xy)
dev.off()

temp<- over(x=xy, y=vec) #extract values of vector behind random points
response <- factor(temp[[attName]])
trainvals <- cbind(response, extract(satImage, xy)) # combine points with rastervalues

print ("Starting to calculate randomforestobject")
ranfor<-randomForest(as.factor(response)~.,
                     data=trainvals, na.action=na.omit, confusion=T)
print("Startingpredictions")
pred<-predict(satImage, ranfor, filname=outPut, progress='text', format='GTiff', datatype='INT1U', type='response', overwrite=TRUE)


