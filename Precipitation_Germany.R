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
prev_avg <- cellStats(prec_ger2, stat="mean")

# plot
plot(prev_avg,
#pointtype
pch=19,
#magnify symbols and text
cex=2,
# green or  html code with tranxlucency (60\%)
col="#00ff0060"

# a smoothed line connecting the point 
lines(lowess(prev_avg, f=.2))

          