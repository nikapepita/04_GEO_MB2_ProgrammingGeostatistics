install.packages("RCurl")

# get Data from GitHub from another User e.g. Martin df <- read.csv("https://raw.githubusercontent.com/

library(RCurl)
df <- read.csv("https://raw.githubusercontent.com/wegmann/R_data/master/Steigerwald_sample_points_all_data_subset_withNames.csv")

#Check File df, head, tail, summary, plot, str, names, dim, class, levels

plot(df [,10])
summary(df[,10])
str(df [,10])

head(df)
dim(df)

x <- seq(1,100,by=2.5)
x[5]
x[4:10]

#Get the last value
x[length(x)]

#Extract all but one position, e.g Postion 25
x[-25]

##Index: Extract or Omit a list of positions

idx <- c(1,4,6) 
x[idx] # shows values 1,4,6
x[-idx] #shows all despite of 1,4,6

#Get TRUE or False
x>20
(x<=10)|(x>=30)

#Get Value
x[x<=10|x>=30]

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
#modify: rev, sort, sample

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
m1[,2]
m1[1,1]

#Create Matrix
numbers_1 <- rnorm(80,mean=0,sd=1)

mat1 <- matrix(numbers_1,nrow=20,ncol=4)

df_1 <- data.frame(mat1)

#Rename it
names(df_1) <- c("var1","var2","var3","var4")

boxplot(df_1)
scatterplot(df_1$var1, df_1$var2)

test <- data.frame(A=c(1,2,3),B=c("aB1","aB2","aB3")) 
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