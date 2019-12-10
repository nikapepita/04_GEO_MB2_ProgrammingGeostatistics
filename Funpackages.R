#install.packages("fun")
library(fun)
if (.Platform$OS.type =="windows") x11() else x11(type="Xlib")
mine_sweeper()

#install.packages("sudoku")
library(sudoku)
if (.Platform$OS.type =="windows") x11() else x11(type="Xlib") #need for 
sudoku()

#install.packages("devtools")
library(devtools)

#devtools::install_github("gaborcsadri/praise")
library(praise)
praise()

difftime("2019-12-24",Sys.Date(),units="days")

#install.packages("fortunes")
library(fortunes)
#call a quote
fortune()

fortune("memory")

#install.packages("cowsay")
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
cedr
#install.packages("suncalc")
#install.packages("V8")
library(V8)
library(suncalc)

getSunlightTimes(date=Sys.Date(),lat=49.782332, lon=9.970187, tz="CET")


##Check out - Lego Style Picture

install.packages("rwhatsapp")

##more Fun - 26.11.2019 - sounds
library(devtools)
if(!require(devtools)) {intall.packages(devtools)}
devtools::install_github("brooke-watson/BRRR")
library(BRRR)

skrrrahh("drummaboy")
skrrrahh(41)

##Date and Time

install.packages("lubridate")
library("lubridate")

today()

Sys.time()


##use image instead of point

library(ggplot2)
library(ggimage)

d <- data.frame(x=rnorm(10), y=rnorm(10))

ggplot(d, aes(x,y)) + geom_pokemon(aes(image=ifelse(x>0, 'pikachu','tauros')), size=.1)


### ANIMATED SNOW === BY PAULVANDERLAKEN.COM
# PACKAGES ####
pkg <- c("here", "tidyverse", "gganimate", "animation")
sapply(pkg, function(x){
  if (!x %in% installed.packages()){install.packages(x)}
  library(x, character.only = TRUE)
})

# CUSTOM FUNCTIONS ####
map_to_range <- function(x, from, to) {
  # Shifting the vector so that min(x) == 0
  x <- x - min(x)
  # Scaling to the range of [0, 1]
  x <- x / max(x)
  # Scaling to the needed amplitude
  x <- x * (to - from)
  # Shifting to the needed level
  x + from
}

# CONSTANTS ####
N <- 500 # number of flakes
TIMES <- 100 # number of loops
XPOS_DELTA <- 0.01
YSPEED_MIN = 0.005
YSPEED_MAX = 0.03
FLAKE_SIZE_COINFLIP = 5
FLAKE_SIZE_COINFLIP_PROB = 0.1
FLAKE_SIZE_MIN = 4
FLAKE_SIZE_MAX = 20

# INITIALIZE DATA ####
set.seed(1)

size <- runif(N) + rbinom(N, FLAKE_SIZE_COINFLIP, FLAKE_SIZE_COINFLIP_PROB) # random flake size
yspeed <- map_to_range(size, YSPEED_MIN, YSPEED_MAX)

# create storage vectors
xpos <- rep(NA, N * TIMES)
ypos <- rep(NA, N * TIMES)

# loop through simulations
for(i in seq(TIMES)){
  if(i == 1){
    # initiate values
    xpos[1:N] <- runif(N, min = -0.1, max = 1.1)
    ypos[1:N] <- runif(N, min = 1.1, max = 2)
  } else {
    # specify datapoints to update
    first_obs <- (N * i - N + 1)
    last_obs <- (N * i)
    # update x position 
    # random shift
    xpos[first_obs:last_obs] <- xpos[(first_obs-N):(last_obs-N)] - runif(N, min = -XPOS_DELTA, max = XPOS_DELTA)
    # update y position
    # lower by yspeed
    ypos[first_obs:last_obs] <- ypos[(first_obs-N):(last_obs-N)] - yspeed
    # reset if passed bottom screen
    xpos <- ifelse(ypos < -0.1, runif(N), xpos) # restart at random x
    ypos <- ifelse(ypos < -0.1, 1.1, ypos) # restart just above top
  }
}


# VISUALIZE DATA ####
cbind.data.frame(ID = rep(1:N, TIMES)
                 ,x = xpos
                 ,y = ypos 
                 ,s = size
                 ,t = rep(1:TIMES, each = N)) %>%
  # create animation
  ggplot() +
  geom_point(aes(x, y, size = s, alpha = s), color = "white", pch = 42) +
  scale_size_continuous(range = c(FLAKE_SIZE_MIN, FLAKE_SIZE_MAX)) +
  scale_alpha_continuous(range = c(0.2, 0.8)) +
  coord_cartesian(c(0, 1), c(0, 1)) +
  theme_void() +
  theme(legend.position = "none", 
        panel.background = element_rect("black")) +
  transition_time(t) +
  ease_aes('linear') ->
  snow_plot

snow_anim <- gganimate(snow_plot, nframes = TIMES, width = 600, height = 600)