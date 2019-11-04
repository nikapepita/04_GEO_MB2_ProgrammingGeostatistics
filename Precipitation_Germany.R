###Precipitation Germany
##Get Data and Plot
install.packages("raster")
library(raster)

#get country borders, other codes can be found in the manual
germany <- getData("GADM", country="DEU", level=2)

#plot germany borders
#plot(germany)

#get precipitation data, lon/lat only needed for res=5
prec <- getData("worldclim", var="prec", res=.5,lon=10,lat=51)

#plot precipitation
#plot(prec)

#crop precipitation to extent of germany
prec_ger1 <- crop(prec,germany)

#plot result
#spplot(prec_ger1)

#mask percipitation to shape of germany
prec_ger2 <- mask(prec_ger1, germany)

#plot result
spplot(prec_ger2)

##Extract Precipiation
#Extract Precipiation average of germany, other statistics possible as well
prec_avg <- cellStats(prec_ger2, stat="mean")

# plot
plot(prec_avg,
#pointtype
pch=19,
#magnify symbols and text
cex=2,
# green or  html code with tranxlucency (60\%)
col="#00ff0060")

# a smoothed line connecting the point 
lines(lowess(prec_avg, f=.2))


plot(prec_avg[4:9]) #plot the data "prec" from April to Sep

#Subscract the January from the Feb. precipitation
prec_avg[2]-prec_avg [1]

#sum of preciptation
sum(prec_avg)

#cummulative sum of preciptation
cumsum(prec_avg)
          
#maximum precipitation
max(prec_avg)

#range of values
range(prec_avg)

#which is the minium value
which.min(prec_avg)

#which is the closest to value x
which.min(abs(prec_avg-50))

#difference between elements
diff(prec_avg)