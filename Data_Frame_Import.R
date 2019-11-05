install.packages("RCurl")

# get Data from GitHub from another User e.g. Martin df <- read.csv("https://raw.githubusercontent.com/

#download file from https://github.com/wegmann/R_data repository

df <- read.csv('./')#with that command you start on your getwd, with tab you can choose folders or files

df <- read.csv("sample_points_all_data_subset_withNames.csv")

#alternativ import - acess online
library(RCurl)
df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")
#other package: tidyverse

#write table
write.table(df,file="my_data.txt")

#Check File df, head, tail, summary, plot, str, names, dim, 
#class, levels

plot(df [,10])
summary(df[,10])
str(df [,10])

head(df)
dim(df)

##Indexing a Vector

#generate a vector
x <- seq(1,100,by=2.5) #create sequence from 1 to 100 by steps of 2,5
x[5] #query 5th position
x[4:10] #extract 4th to 10th position

#Get the last value
x[length(x)] #lengt of x and query this position
x[length(x)-1] #length of x and query this minus one postion

#Extract all but one position, e.g Postion 25
x[-25]

##Index: Extract or Omit a list of positions

idx <- c(1,4,6) #a vector with three numbers
x[idx] # shows values 1,4,6, query x based on idx numbers
x[-idx] #shows all despite of 1,4,6, omit x query of these three numbers

#Get TRUE or False
x>20 #above 20
(x<=10)|(x>=30) #below or equal 10 OR above or equal 30

#Get Value
x[x<=10|x>=30] # provide all data below 10 or above 30

##Changes Values
x2 <- numeric(length(x))
x2 [x<=30] <- 1
x2[(x>30) &(x<70)] <- 2
x2[x<70] <- 3
x2

#Alternative
install.packages("car")
library(car)
x2 <- recode(x,"0:30=1; 30:70=2; else=3")

#stats: summary, sum, cumsum
#modify: 
rev(x) #revert the order
sort(x, decreasing=TRUE) #doing the same
sample (x,10) #sample 10 values out of X

##Matrix

m1 <- matrix(c(seq(1,100,by=2)),nrow=2)
#or
m1 <- matrix(x)

m1 <- matrix(c(seq(1,100,by=2)),nrow=5, ncol=5,byrow=TRUE)

#Check!!!
#m1 <- matrix(c(seq(1,100,by=2))
 #            + nrow=5 
  #           + ncol=5
   #          + byrow=TRUE)


#Query Row / Column
m1[,2] #query 2.colum
m1[2,] #query 2.row
m1[2,2] #query 2.row and 2.column

#Create a Vector with 80 entries based on normally distributed data
numbers_1 <- rnorm(80,mean=0,sd=1)

#pupulate matrix with vector data in 20 rows in 4 columns
mat1 <- matrix(numbers_1,nrow=20,ncol=4)


#matrix  values into a dataframe
df_1 <- data.frame(mat1)

#Rename it, assign column names
names(df_1) <- c("var1","var2","var3","var4")

boxplot(df_1)
scatterplot(df_1$var1, df_1$var2)

##Data Frame
#generate a data frame with 2 colums
test <- data.frame(A=c(1,2,3),B=c("aB1","aB2","aB3")) 
#query just "A"
test[,1]

#get column by name
test[,"A"]
test$A

df1<- data.frame(plot="location_name_1", measure1=runif(100)*1000,measure2=round(runif(100)*100), 
                 value=rnorm(100,2,1), ID=rep(LETTERS, 100)[1:100])

df2<- data.frame(plot="location_name_2", measure1=runif(50)*100,measure2=round(runif(50)*10), 
                 value=rnorm(50), ID=rep(LETTERS, 50)[1:50])

df <- rbind(df1,df2)
#choose stuff, don't forget to combine!!!
df[,c("plot","measure1","measure2")]

df[c(-1),c("plot","measure1","measure2")]
df[c(2:5),c("plot","measure1","measure2")]
df[c(66:70),c("measure1","measure2")]

##List

a <- runif(199)
b <- c("aa","bb","cc","dd","ee")
c <- list(a,b)
c

#index second object
c[2]
#same as before but output the original data type e.g. data frame
c[[2]]
#first entry of second object
c[[2]][1]

##ComplexList

a <- list(obj_1=runif(100), obj_2=c("aa","bb"), obj_3=c(1,2,4))

#call the object name
a$obj_1
#or
a[["obj_1"]]
#or
a[[1]]

#a list wiht a matrix, vector and data frame of different size
a <- list(m1=matrix(runif(50), nrow=5), v1=c(1,6,10), df1=data.frame(a=runif(100), b=rnorm(100)))

#index a data frame or matrix as know
a$df[,1]

#plot measure 1 and measure 2

plot(df$measure1,df$measure2)
boxplot(df$measure1,df$measure2)
hist(df$measure1)

ggplot(df$measure1)

plot(df[c(1:10),c("measure1","measure12")])
coplot(df[c(1),c("measure1","measure2")])

plot(df[c(1:100),c("measure1","measure2")],
     #pointtype
     pch=19,
     #magnify symbols and text
     cex=2,
     # green or  html code with tranxlucency (60\%)
     col="#00ff0060")

df[df$value>3.0,] #index by column values

df[df$value>3.2 | df$measure1>50,] #combine with AND or OR
df[df$value>3.2 & df$measure1>50,] #combine with AND or OR

df$new_col <- df$measure1*df$measure2 #new column

df[grep("b",df$ID,ignore.case=T),] #you can use wildcards, index data by keyword


x1 <- rbinom(10,size=1,prob=0.5)
x2 <- factor(x1,labels=c("yes","no"))

summary(x2)
levels(x2)

as.character(x)

library(car)
recode(x2,"'yes'='sure';'no'='maybe'")

ifelse(x2=="no","maybe","sure") #!! ==!!



