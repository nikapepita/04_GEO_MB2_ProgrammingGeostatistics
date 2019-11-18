###my own plots 

###
library(plyr)
library(ggplot2)
library(base)
library(scales)


getwd()
setwd("./04_GEO_MB2_ProgrammingGeostatistics/")

hiking_db <- read.csv("LandUseRoutes.csv", header=TRUE, sep=",")
corine_classes <- read.csv("Corine.csv", header=TRUE, sep=",")



Route_Name <- c("Wildpark")
Route <- count( hiking_db[grep(Route_Name,hiking_db$name,ignore.case=T),], vars = "class", wt_var = NULL))

Route$name <- Route_Name
Route$precentage <- as.integer((Route$freq*100)/sum(Route$freq))
Route


plot2 <- ggplot(Route, aes(x=class, y=precentage))+
  geom_bar(aes(fill = class), width = 0.5, stat = "identity")+
  facet_grid(.~name) +
  ggtitle("Corine Landcover Class for Hikinig Route:")+
  ylab("Precentage of LC-Class")+
  xlab("Landcover Class")

plot2

#fancy plot land class coverage

plot1 <- ggplot(Route, aes(x=class, y=precentage))+
  geom_bar(aes(fill = class), width = 0.5, stat = "identity")+
  facet_grid(.~name) +
  ggtitle("Corine Landcover Class for Hikinig Route:")+
  ylab("Precentage of LC-Class")

pie <- plot1 + coord_polar("y", start=0) + 
  geom_text( label = paste( Route$precentage, "%" ),size=5)

pie


plot1 <- ggplot(Route, aes(x="", y=precentage))+
  geom_bar(aes(fill = class), width = 0.5, stat = "identity")+
  facet_grid(.~name) +
  ggtitle("Corine Landcover Class for Hikinig Route:")+
  ylab("Precentage of LC-Class")

pie <- plot1 + coord_polar("y", start=0)
pie




