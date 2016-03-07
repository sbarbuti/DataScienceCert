#import data
#Merges the training and the test sets to create one data set.
#Extracts columns containing mean and standard deviation for each measurement 
#(Hint: Since some feature/column names are repeated, you may need to use the make.names() function in R)
#Creates variables called ActivityLabel and ActivityName that label all observations with the corresponding activity labels and names respectively
#From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.library(plyr)

setwd("C:/Users/sb52299/Documents/DataScienceCert/Data")
library(plyr)
library(dplyr)
paths <- dir(path = "C:/Users/sb52299/Documents/DataScienceCert/Data", pattern = "\\.csv")
names(paths) <- basename(paths)
tennisdata <- ldply(paths, read.csv)

#snapshot
glimpse(tennisdata)
summary(tennisdata)
dim(tennisdata)  

#rename variable
tennisdata <- rename(tennisdata, tournamentname=.id)

#see all tournament names
tennisdata %>% select(tournamentname) %>% distinct

#mean and stdev
tennisdata %>% 
  #group_by(paths) %>% 
  summarise_each(funs(mean,sd(., na.rm=TRUE)))

#new dataset with averages by tournament
tennisdatamean<-
tennisdata %>% 
  group_by(tournamentname) %>% 
  summarise_each(funs(mean(., na.rm=TRUE)))

#output tidy dataset
write.csv(tennisdatamean,file = "tennisdatamean.csv")
