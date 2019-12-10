###classifcation - Qgis and R
library(RStoolbox)
library(rgdal)
library(raster)


td <- readOGR("C:/Users/Annika/Documents/R_Classifcation/TrainingData3.shp")
allbands <- brick("C:/Users/Annika/Documents/R_Classifcation/Raster_virtuel2.tif")

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

vec <- readOGR("C:/Users/Annika/Documents/R_Classifcation/TrainingData3.shp")
satImage <- brick("C:/Users/Annika/Documents/R_Classifcation/Raster_virtuel2.tif")

#number of sample per landcoverclass /define number of samples for each class
numsamps <- 100

#Name of the attribute that holds the integer landcovertype identifyer (very important to consinder 
#when doing the training datasets
#name of the integer of the class for the training data

attName <- 'class_name'

#Name and path of  the outputGeoTiffimage
outImage <- 'classifresult.tif'

#loop over each class, selecting all polygons and assign random points
#save classes in vector
uniqueAtt <- unique(vec[[attName]])

# get 100 trainingpoints for each class and create a vector with coordinates for each point

#try loop with testdata before!

for (x in 1:length(uniqueAtt)) { #query the number of classes
        classdata <- vec[vec[[attName]]==uniqueAtt[x],] #extract the polygons with class n
        classpts <- spsample (classdata, type = "regular", n=numsamps) #set random points in selected polygons
        # first run: create new spatial point rs dataframe, 
        if(x==1){
                xy <-  classpts
        } else {
                xy <-rbind(xy, classpts)
        }
}

#plot the random generated points on one of the raster for visual checking only,
#image will be savecd in the filesystemaspf
# generate a pdf with your raster and sampling points
#create a pdf with raster as background and the sample points

pdf("training_points.pdf")
image(satImage, 1)
points(xy)
dev.off() #means stopp and save it

temp<- over(x=xy, y=vec) #extract values of vector behind random points / extract class for each point
response <- factor(temp[[attName]]) #extract class names as factor
trainvals <- cbind(response, extract(satImage, xy)) # combine points with rastervalues #extracts values from raster objects based on the created coordinates
#and cbind it with the class name

print ("Starting to calculate randomforestobject")
ranfor<-randomForest(as.factor(response)~.,
                     data=trainvals, na.action=na.omit, confusion=T)
#calculate a random forest, ~ separating x from the y, . =shortcut take everything from the bands

print("Startingpredictions")
pred<-predict(satImage, ranfor, filname=outPut, progress='text', format='GTiff', datatype='INT1U', type='response', overwrite=TRUE)
#classify the raster based on the random forest and wirte a tiff and save it


###superclassifciation and Indices - do it again :-)