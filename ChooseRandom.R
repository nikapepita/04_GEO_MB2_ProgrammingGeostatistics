##Choose Random Person 

#Create Dataframe with all Course-Members

library(datapasta)
library(ggplot2)

#Choose a RandomPerson
Eagle2019 <- data.frame(stringsAsFactors=FALSE,
                 Name = c("Marius", "Annika", "Jakob", "Kemeng", "Helena", "James",
                          "Kevin", "Diego", "Antonio", "Nils", "Luisa", "Larissa",
                          "Christabel", "Walid", "Sofia", "Diana", "Chris", "Sanaz"),
                 Id = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
)

random <- function(df, print = T){
  volunteer <-sample(df$Id, 1, replace = T)
  Name <- df[volunteer,"Name"]
  return(Name)
}

random(Eagle2019)

#Check Distribution

distribution <- function(df,rePeat, print = T){
  Factors <- as.factor(replicate(rePeat, random(df)))
  freq <- table(Factors)
  
  #Greyscale: Attention: you need to add fill in aes to add scale_fill
  plot_dist1 <- ggplot(data.frame(Factors), aes(x = Factors,fill=Factors)) + geom_bar() +
    geom_hline(yintercept = mean(freq)) +theme_minimal()+ scale_fill_grey()
  
  #Rainbow-Fill
  plot_dist2 <- ggplot(data.frame(Factors), aes(x = Factors,fill=Factors)) + geom_bar() +
    geom_hline(yintercept = mean(freq)) +theme_minimal()
  return(plot_dist1)
}


distribution(Eagle2019,1000)
##Question: Distribution, changes?!?!

#### Copy Marius 

distribution <- function(data, NRep, print = T){
  Factors <- as.factor(replicate(NRep, randomPerson(data)))
  freq <- table(unlist(Factors))
  plot <- ggplot(data.frame(Factors), aes(x = Factors)) + 
    geom_bar() + geom_hline(yintercept = mean(freq))
  results <- list("text" = paste("Histogram of the results after", NRep, "repetitions", sep = " "), "plot" = plot)
  return(results)
}

















