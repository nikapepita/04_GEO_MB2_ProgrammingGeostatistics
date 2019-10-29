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