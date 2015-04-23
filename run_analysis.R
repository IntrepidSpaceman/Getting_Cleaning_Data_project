# Script for cleaning human Activity Recognition datset

# Clean workspace
rm(list = ls())

# load packages
library(dplyr)

# load datasets
#
# This assumes the folders with the raw data are in the working directory 
# and are organized like in the zip file provided 
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
# labels datasets
act_names <- read.table("activity_labels.txt")
features_names <- read.table("features.txt")


# Bind different test and training datasets
#
# test dataset
test_set <- cbind(test_set,  
                  ActivityLabel = test_act_labels[[1]], 
                  SubjectNumber = test_subjects[[1]]
                  )
# train dataset
train_set <- cbind(train_set,  
                  ActivityLabel = train_act_labels[[1]],
                  SubjectNumber = train_subjects[[1]]
                  )
# row bind the two datsets
dataset <- rbind(test_set, train_set)


# label the dataset features according to the features_names vector
names(dataset)[1:nrow(features_names)] <- as.character(features_names[[2]])

# Create new collumn with the human-readable names of the activities using merge
names(act_names)<- c("ActivityLabel", "ActivityName")
dataset <- merge(dataset, act_names, by = "ActivityLabel")


# Identify collumns with measurments on the mean and standard deviation
# This is done by identifying which collumn names contain the text "mean()" and "std()".
# We know  this is the case by reading the features_info.text doc, 
# that indicates that measurements on the mean and standard deviation have the suffixes mentioned
col_mean <- grep("mean()", names(dataset))
col_std <- grep("std()", names(dataset))
# Select only the identified collumnsplus the ones with the Subject Number and Activity Name
subset <- c(col_mean, col_std, 
            which("ActivityName" == names(dataset)), which("SubjectNumber" == names(dataset))
            )
dataset <- dataset[, subset]


# Create the tidy dataset with the averages by using dplyr package
# First group by subject and activity
# Then calculate the mean for each remaining collumn
averages_dataset <- dataset %>%
        group_by(
                SubjectNumber,
                ActivityName
        ) %>%
        summarise_each(
                funs(mean)
        )
# Re-write the all collumn names, except first two, to indicate that they measure the averages
names(averages_dataset)[-c(1,2)] <- paste0("avrg-", names(averages_dataset)[-c(1,2)])


# Write table to .txt file
#write.table(averages_dataset, file = "tidy_set_averages.txt", row.names = FALSE)