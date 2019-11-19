###my own plots 
##open task-add srtm -> terrain profil?
###
library(plyr)
library(ggplot2)
library(base)
library(scales)


getwd()
setwd("C:/Users/Annika/Documents/Git/04_GEO_MB2_ProgrammingGeostatistics")

hiking_db <- read.csv("LandUseRoutes.csv", header=TRUE, sep=",")
corine_classes <- read.csv("Corine.csv", header=TRUE, sep=",")


Names_Route <- count(hiking_db$name)
Route_Name <- Names_Route$x
Route <- count( hiking_db[grep(Route_Name[2],hiking_db$name,ignore.case=T),], vars = "class", wt_var = NULL)

Route$name <- Route_Name[2]
Route$precentage <- as.integer((Route$freq*100)/sum(Route$freq))
Route
#write.table(Route,file="LandUse2.csv")



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



anim <- pie + 
  transition_states(Route$precentage)

anim




plot1 <- ggplot(Route, aes(x="", y=precentage))+
  geom_bar(aes(fill = class), width = 0.5, stat = "identity")+
  facet_grid(.~name) +
  ggtitle("Corine Landcover Class for Hikinig Route:")+
  ylab("Precentage of LC-Class")

pie <- plot1 + coord_polar("y", start=0)
pie


library(gganimate)

hiking_db2 <- read.csv("LandUse2.csv", header=TRUE, sep=";")
head(hiking_db2)

# + geom_line(aes(y=Urban,color='Y2')) +
#  geom_line(aes(y=Mixed_forest,color='blue')) + geom_line(aes(y=Grassland,color='blue'))+
#  +geom_dl(aes(label = label), method = list(dl.trans(x = x + .2), "last.points")) +
#  geom_dl(aes(label = label), method = list(dl.trans(x = x - .2), "first.points")) 


plot3 <- ggplot(hiking_db2,aes(x=Year,y="")) + geom_line(aes(y=Broad.leaved,color='Broad.leaved'))+
  geom_line(aes(y=Coniferous,color='Coniferous')) +
  scale_color_manual(values = c(
    'Broad leaved Forest' = 'green',
    'Coniferous Forest' = 'blue')) +
  labs(color = 'Land Cover Class')

plot3



plot3
+ transition_reveal(Year)
plot3
