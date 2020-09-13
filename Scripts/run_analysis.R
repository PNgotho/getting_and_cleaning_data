#Load needed libraries
library(stringr)
library(dplyr)
library(tidyr)

#Clear the R environment before running script
rm(list = ls())

#Set working directory
setwd("D:\\R_Training/getting_and_cleaning_data/getting_and_cleaning_data2")

#Set up variable for columns to extract on test data
thewidths <- c(17)
for (i in 1:560){
  thewidths <- cbind(thewidths, c(16))
}

#Load the raw data into R
features <- read.delim("features.txt", header = FALSE, sep = " ")
features$V2 <- gsub(',', '_', features$V2) #Remove the "," from the labels: these will become column names
activity <- read.delim("activity_labels.txt", header = FALSE, sep = " ")
colnames(activity) <- c("activity_code", "activity_desc")

subject_test <- read.delim("./Data/test/subject_test.txt", header = FALSE)
y_test <- read.delim("./Data/test/y_test.txt", header = FALSE)
x_test <- read.fwf("./Data/test/X_test.txt", widths = thewidths, header = FALSE)

subject_train <- read.delim("./Data/train/subject_train.txt", header = FALSE)
y_train <- read.delim("./Data/train/y_train.txt", header = FALSE)
x_train <- read.fwf("./Data/train/X_train.txt", widths = thewidths, header = FALSE)

#Tidy the test data
colnames(x_test) <- features$V2
colnames(y_test) <- c("activity_code")
colnames(subject_test) <- c("subject_code")
subject_test$data_set <- rep("Test", nrow(subject_test)) #Add a variable to identify the data set
x_test <- cbind(subject_test, y_test, x_test)

#Tidy the train data
colnames(x_train) <- features$V2
colnames(y_train) <- c("activity_code")
colnames(subject_train) <- c("subject_code")
subject_train$data_set <- rep("Train", nrow(subject_train)) #Add a variable to identify the data set
x_train <- cbind(subject_train, y_train, x_train)

#Merge the tidy test & train data
merged_data <- rbind(x_test, x_train)

#Extracts the measurements on the mean and standard deviation for each measurement
merged_data <- merged_data[grep('subject_code|data_set|activity_code|std|mean', names(merged_data))]
merged_data_std_mean <- merged_data %>%
  subset(., select=which(!duplicated(names(.)))) %>% 
  tbl_df() %>%
  merge(activity, .) %>%
  select(-activity_code)

#Create a new data set that is grouped by activity and by subject
merged_data_std_mean_summarized <- merged_data_std_mean %>%
  group_by(activity_desc, subject_code) %>%
  summarize_if(is.numeric, mean)

#Export the data summarized data to a csv file
write.csv(merged_data_std_mean_summarized,"./Output/final_output.csv", row.names = FALSE)
