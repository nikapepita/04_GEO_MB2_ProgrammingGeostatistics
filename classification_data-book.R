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

sc_88x10 <- sc_88$map*10
sc_88_11 <- sc_88x10+sc_11$map


########################################################
#Accurarcy
########################################################

Acc_sc_88_v1 <- sc_88$validation$performance$overall
Acc_sc_11_v1 <- sc_11$validation$performance$overall

Acc_sc_88_v2 <- getValidation(sc_88, metrics = "classwise")
Acc_sc_11_v2 <- getValidation(sc_11, metrics = "classwise")

Acc_sc_88_v3 <- getValidation(sc_88, metrics = "overall")
Acc_sc_88_v3 
Acc_sc_11_v3 <- getValidation(sc_11, metrics = "overall")
Acc_sc_11_v3

Acc_sc_88_v4 <- getValidation(sc_88, metrics = "confmat")
Acc_sc_88_v4
Acc_sc_11_v4 <- getValidation(sc_11, metrics = "confmat")
Acc_sc_11_v4

########################################################
#multidate
########################################################

Isat88 <- brick("./data_book/raster_data/final/p224r63_1988.gri")
Isat11 <- brick("./data_book/raster_data/final/p224r63_2011.gri")

Isat88_11 <- stack(Isat88,Isat11)

#traindata change
td_88_11 <- readOGR("./data_book/vector_data/change_classes_1988_2011.shp")

#Classification
sc_88_11_md <- superClass(Isat88_11, trainData=td_88_11,  responseCol = "class", 
                          model = "rf", tuneLength = 1, trainPartition = 0.7)

plot(sc_88_11_md$map)
#validateMap(sc_88_11_md$map)

Acc_sc_88_11_md <- sc_88_11_md$validation$performance$overall

Acc_sc_88_11_md_v2 <- getValidation(sc_88_11_md, metrics = "classwise")
Acc_sc_88_11_md_v3 <- getValidation(sc_88_11_md, metrics = "overall")
Acc_sc_88_11_md_v4 <- getValidation(sc_88_11_md, metrics = "confmat")

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
#Plot
########################################################
p1 <- ggR(sc_88$map, geom_raster = T)+
  scale_fill_manual(values = c("green1", "dimgrey", "dodgerblue2"))+
  # , guide = F
  labs(x="",y="")+
  ggtitle("Land Cover 1988")+
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
  theme(legend.title = element_text(size = 12, face = "bold"))+
  theme(legend.text = element_text(size = 10))+
  theme(axis.text.y = element_text(angle=90))+
  xlab("")+
  ylab("")



p2 <- ggR(sc_11$map, geom_raster = T)+
  scale_fill_manual(values = c("green1", "dimgrey", "dodgerblue2"))+
  # , guide = F
  labs(x="",y="")+
  ggtitle("Land Cover 2011")+
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
  theme(legend.title = element_text(size = 12, face = "bold"))+
  theme(legend.text = element_text(size = 10))+
  theme(axis.text.y = element_text(angle=90))+
  xlab("")+
  ylab("")


df$class <- ifelse(df$value==11,"11 No Change",
                   ifelse(df$value == 12, "12 Forest to No Forest",
                          ifelse(df$value == 13, "13 Forest to Water",
                                 ifelse(df$value == 21, "21 No Forest to Forest",
                                        ifelse(df$values == 22, "22 No Change",
                                               ifelse(df$value == 23, "23 Forest to Water",
                                                      ifelse(df$value == 31, "31 Water to Forest",
                                                             ifelse(df$value == 32, "32 Water to No Forest",
                                                                    ifelse(df$value == 33, "33 No Change", "NA")))))))))
p3 <- ggplot(df, aes(x,y,fill=class))+geom_raster()+
  scale_fill_manual(values = c("red", "grey", "dodgerblue2","green"))+
  labs(x="",y="",title = "Land Cover Change 1988 to 2011", 
       subtitle = "Classes 22,23,31,32,33 do not occur", 
       caption = "Annika Ludwig. ggplot2: Land Cover Change Analyse with SuperClass, 2020.")+
  theme(plot.title = element_text(hjust = 0.5, face="bold", size=15))+
  theme(legend.title = element_text(size = 12, face = "bold"))+
  theme(legend.text = element_text(size = 8))+
  theme(axis.text.y = element_text(angle=90))+
  xlab("")+
  ylab("")

plot(p3)

pdf("Land Cover Change 1988 & 2011.pdf", width = 14, height = 8)
grid.arrange(p1, p2, p3, ncol=2)
dev.off()