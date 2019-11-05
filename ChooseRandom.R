Eagle2019 <- c("Annika","Helena","Larissa","Luisa","Jakob","Marius","James","Nils","Kevin","Kemeng","Diego", "Chris",
               "Sofia","Antonio","Waldi","Sanaz")
length(Eagle2019)

for (i in 1:length(8)) {
  volunteer<-sample(Eagle2019,1)
  #Eagle2019 <-Eagle2019 [Eagle2019  != volunteer]
  print(paste("It's your turn,", volunteer)) 
}

for (i in 1:10) {
  volunteer<-sample(Eagle2019,1)
  print(paste("It's your turn,", volunteer)) 
}


####Script MArius

library(datapasta)
library(ggplot2)


# a <-sample(1:length(df$Id), 1000000, replace = T)
# hist(a)

# Randomizer, Input dataframe column names needed: Id, Name 

randomPerson <- function(data, print = T){
  rNumVector <- seq(1,length(data$Id),1)
  rNum <- rNumVector[sample(1:length(rNumVector),1)]
  Name <- data[rNum,"Name"]
  return(Name)
}

# Function to check for uniform distribution after n repeats 

distribution <- function(data, NRep, print = T){
  Factors <- as.factor(replicate(NRep, randomPerson(data)))
  freq <- table(unlist(Factors))
  plot <- ggplot(data.frame(Factors), aes(x = Factors)) + 
    geom_bar() + geom_hline(yintercept = mean(freq))
  results <- list("text" = paste("Histogram of the results after", NRep, "repetitions", sep = " "), "plot" = plot)
  return(results)
}


##################################################################################################################

df <- data.frame(stringsAsFactors=FALSE,
                 Name = c("Marius", "Annika", "Jakob", "Kemeng", "Helena", "James",
                          "Kevin", "Diego", "Antonio", "Nils", "Luisa", "Larissa",
                          "Christabel", "Walid", "Sofia", "Diana", "Chris", "Sanaz"),
                 Id = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
)


distribution(df, 5000)    # the strong law of large numbers dictates that in an random experiment, the sample average will 
randomPerson(df)          # converge to the expected value for a large amount of repeats.
