### Final Project!!!!

# check if data directory exists
if(!file.exists("data")){
  dir.create(("data"))
}

library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, dest="./data/dataset.zip", mode="wb") 
utils::unzip("./data/dataset.zip", exdir = "./data") # saved to data / UCI HAR Dataset

# get features
temp <- read.table("./data/UCI HAR Dataset/features.txt")
features <- temp[,2]

isMean = grepl("[m][e][a][n][(]", features) # find features with string 'mean('
isStd = grepl("[s][t][d][(]", features) # find features with string 'std('
isValid = isMean | isStd
validfeatures = tolower(features[isValid])

# collect X data
trainX <- tbl_df(read.table("./data/UCI HAR Dataset/train/X_train.txt", colClasses = "numeric"))
testX <- tbl_df(read.table("./data/UCI HAR Dataset/test/X_test.txt", colClasses = "numeric"))

# filter out non-relevant columns, add train/test label
filtered_trainX <- trainX[,isValid] %>% mutate(traintest = 'train')
filtered_testX <- testX[,isValid] %>% mutate(traintest = 'test')

# clean up X data
combinedX <- rbind(filtered_trainX, filtered_testX) # combine all observations
combinedX$traintest <- as.factor(combinedX$traintest) # convert labels to factors
names(combinedX) <- c(validfeatures, 'traintest') # rename features
combinedX <- combinedX %>% relocate(traintest) # move train/test label to front

# get activity labels
temp <- read.table("./data/UCI HAR Dataset/activity_labels.txt", colClasses = "factor")
activities = temp[,2]

# read in Y data
trainY <- tbl_df(read.table("./data/UCI HAR Dataset/train/Y_train.txt", colClasses = "factor"))
testY <- tbl_df(read.table("./data/UCI HAR Dataset/test/Y_test.txt", colClasses = "factor"))
combinedY = rbind(trainY, testY)
names(combinedY) <- 'activity' # rename column
levels(combinedY$activity) <- activities

# read in subject information
trainsubject <- tbl_df(read.table("./data/UCI HAR Dataset/train/subject_train.txt", colClasses = "factor"))
testsubject <- tbl_df(read.table("./data/UCI HAR Dataset/test/subject_test.txt", colClasses = "factor"))
combinedsubject = rbind(trainsubject, testsubject)
names(combinedsubject) <- 'subjectno' # rename column

# combine everything (#4)
dataset = cbind(combinedsubject, combinedY, combinedX)
View(dataset)

# create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
grouped_averages <- dataset %>% group_by(activity, subjectno) %>% 
  select(-traintest) %>% summarize_all(~ mean(.x, na.rm = TRUE))

# see grouped averages for each activity and subject
View(grouped_averages)

# write.table(grouped_averages, "./data/tidy.txt", row.name = FALSE)