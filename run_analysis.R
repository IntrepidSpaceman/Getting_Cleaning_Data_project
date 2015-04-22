# Script for cleaning human Activity Recognition datset

# Clean workspace
rm(list = ls())

# load packages
library(dplyr)

# load datasets
#
# test datasets
test_set <- read.table("test/X_test.txt")
test_act_labels <- read.table("test/y_test.txt")
test_subjects <-read.table("test/subject_test.txt")
#
# train datasets
train_set <- read.table("train/X_train.txt")
train_act_labels <- read.table("train/y_train.txt")
train_subjects <-read.table("train/subject_train.txt")
#
# labels
act_names <- read.table("activity_labels.txt")
features_names <- read.table("features.txt")


# Bind different test and training datasets
#
# test dataset
test_set <- cbind(test_set,  
                  ActivityLabel = test_act_labels[[1]], SubjectNumber = test_subjects[[1]]
                  )
# train dataset
train_set <- cbind(train_set,  
                  ActivityLabel = train_act_labels[[1]], SubjectNumber = train_subjects[[1]]
                  )
# row bind the two datsets
dataset <- rbind(test_set, train_set)


# label the dataset features according to the features names
names(dataset)[1:nrow(features_names)] <- as.character(features_names[[2]])

# Create new collumn with human with the human-readable names of the activities using merge
names(act_names)<- c("ActivityLabel", "ActivityName")
dataset <- merge(dataset, act_names, by = "ActivityLabel")


# Identify collumns with measurments on the mean and standard deviation
# This is done by identifying which collumn names contain the text "mean()" and "std()".
# We know  this is the case by reading the features_info.text doc
col_mean <- grep("mean()", names(dataset))
col_std <- grep("std()", names(dataset))
# Select only the identified collumnsplus the ones with the Subject Number and Activity Name
subset <- c(col_mean, col_std, 
            which("ActivityName" == names(dataset)), which("SubjectNumber" == names(dataset))
            )
dataset <- dataset[, subset]