###ggplot2
library(ggplot2)
#plot= data+aesthetics+geometry

ggplot(df,aes(x=df$X.1))+geom_histogram()

x11()
x <- data.frame(x=1,y=1,label="ggplot 2 introduction \n@ EAGLE")

ggplot(data=x,aes(x=x,y=y)) + geom_text(aes(label=label), size=15)

#Create Vector
x1 <- rnorm(1000,0,10000)
x2 <- rnorm(1000,5,10)
x3 <- rnorm(1000,5,100)
#x3 <- rep(c("catA","catB","catB","catC","catC","catC"),200)[1:1000]
x4 <- factor(rep(c("yes","no"),500))

#Create Dataframe
df <- data.frame (a=x1,b=x2,c=x3,d=x4)

#plot datafame
ggplot(df,aes(a,b)) + geom_point()

#select color by column
ggplot(df,aes(a,b,color=d)) + geom_point()

#set color translucency
ggplot(df,aes(a,b,color=d)) + geom_point(alpha=.5)

#set color translucency, add titel 
# \n - new line!
ggplot(df,aes(a,b,color=d)) + 
  geom_point(alpha=.5) + 
  labs(title="first plot",x="x asis \n and a new line")

#create a histogram
ggplot(df, aes(a)) +
  geom_histogram(color="white")

#create a density graph
ggplot(df, aes(a)) +
  geom_density()

#combining
#..density..!
p1 <- ggplot(df) +
  geom_histogram(aes(a, ..density..), fill="blue", color="darkgrey")+
  geom_density(aes(a, ..density..), color="yellow")+
  geom_rug(aes(a))

#bar plot put flipped
ggplot(df)+geom_bar(aes(c))+coord_flip()

#count statistics
ggplot(df, aes(a,color=c)) +
  geom_point(stat="count",size=4)

#....check lecture!!! Missed it!
###Steigerwald ggplot
#get Data
library(RCurl)
df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")

#Check Data
names(df)
head(df)

#adding information using colour
ggplot(df, aes(x=L8.ndvi, y=L8.savi, colour=SRTM)) + geom_point()
#adding smoothed lines
ggplot(df, aes(x=L8.ndvi, y=L8.savi, colour=SRTM)) + geom_point() +geom_smooth()
#split the plots by landcover(faceting)
ggplot(df, aes(x=L8.ndvi, y=L8.savi, colour=SRTM)) + geom_point() + geom_smooth()+facet_wrap(~LCname)

ggplot(df, aes(x=L8.ndvi, y=L8.savi))+
  geom_point(aes(color=LCname),size=2)+
               facet_grid(.~LCname)

ggplot(df, aes(x=LCname, y=L8.savi))+
  geom_jitter(aes(alpha=SRTM, size=TimeScan.NDVIsd, colour=L8.ndvi))+
  geom_boxplot(alpha=.5)


##adding ggplot ggridges
install.packages("ggridges")
library(ggridges)

ggplot(df, aes(x=L8.savi, y=LCname))+ geom_density_ridges2()

###3D 
#install.packages("rayshader")

###ggplot2
library(ggplot2)

#Create Vector
x1 <- rnorm(1000,0,10000)
x2 <- rnorm(1000,5,10)
x3 <- rnorm(1000,5,100)
#x3 <- rep(c("catA","catB","catB","catC","catC","catC"),200)[1:1000]
x4 <- factor(rep(c("yes","no"),500))

#Create Dataframe
df <- data.frame (a=x1,b=x2,c=x3,d=x4)

library(rayshader)

p1_df <-  ggplot(df) + 
  geom_point(aes(x = a, y = b,color=c)) 

p1_df

par(mfrow = c(1, 2)) #splits plot in two sides
plot_gg(p1_df,raytrace = FALSE, preview = TRUE)

plot_gg(p1_df, width = 3.5, multicore = TRUE, windowsize = c(800, 800), 
        zoom = 1, phi = 35, theta = 30, sunangle = 225, soliddepth = -100)
Sys.sleep(0.2)
render_snapshot(clear = TRUE)
