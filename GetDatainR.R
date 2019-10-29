#Get Data in R
getwd()
setwd ("04_GEO_MB2_ProgrammingGeostatistics/")

list.files()

my_db <- read.table("Boden2_06.02.csv", header=TRUE, sep = ";")
#or: my_db <- read.csv("Boden2_06.02.csv", header=TRUE, sep = ";")

head(my_db)
summary(my_db)

plot(my_db[,1])

write.table(my_db,file="my_data.txt")
