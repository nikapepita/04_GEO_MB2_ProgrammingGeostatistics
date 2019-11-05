install.packages("fun")
library(fun)
if (.Platform$OS.type =="windows") x11() else x11(type="Xlib")
mine_sweeper()

install.packages("sudoku")
library(sudoku)
if (.Platform$OS.type =="windows") x11() else x11(type="Xlib") #need for 
sudoku()

install.packages("devtools")
library(devtools)

devtools::install_github("gaborcsadri/praise")
library(praise)
praise()

difftime("2019-12-24",Sys.Date(),units="days")

install.packages("fortunes")
library(fortunes)
#call a quote
fortune()

fortune("memory")

install.packages("cowsay")
library(cowsay)
say("Hello World")

#change it a bit

someone_say_hello <- function() {
  animal <- sample(names(animals),1)
  say(paste("Hello, I'm a", animal,".", collapse = ""), by=animal)
}

someone_say_hello()



someone_say_my_fortune <- function(){
  animal <- sample(names(animals),1)
  say(paste(fortune(),collapse="\n"),by=animal)
}

someone_say_my_fortune()

install.packages("suncalc")
install.packages("V8")
library(V8)
library(suncalc)

getSunlightTimes(date=Sys.Date(),lat=49.782332, lon=9.970187, tz="CET")


