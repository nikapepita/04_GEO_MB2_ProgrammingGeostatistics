###Create your Package
#Install Rtools

#install.packages(c("devtools","roxygen2"))

library(devtools)
library(roxygen2)

#Get ready to create a package
has_devel()

#check and define working directory 
setwd("./")
getwd()

#Create Package - all files need for a package
#create("C:/Users/Annika/Documents/Git/NAME/")

##build -> configure -> activate roxygen - check install and restart

#############################################  

###head - R script:
  
  #' Say hello to Eagle
  #' 
  #' This function says hello to Eagles depending on daytime.
  #' 
  #' @param eagles character, the names of the EAGLEs to be greeted.
  #' @param daytime character, optional, either "morning" or "evening"
  #' 
  #' @return Nothing, it will just say hello.
  #' 
  #' @importFrom lubridate hour --> packaga function
#' @export


###Description File/ Example

#Package: Random
#Title: This Package is personal
#Version: 0.0.1
#Authors@R: 
#  person(given = "Annika",
#         family = "Ludwig",
#         role = c("aut", "cre"),
#         email = "blabla@example.com")
#Description: Learn to create packages.
#License: GPL-3
#Encoding: UTF-8
#LazyData: true
#RoxygenNote: 7.0.0
#Imports:
#  lubridate

###load packages from github
devtools::install_github("16Eagle/MB2")

