---
title: "CodeBook"
output: html_document
---

## Description of Dataset
The cleaned up dataset contains measures from the Samsumg Galaxy SII Smartphone.
Instead of keeping all the measures from the original dataset, the cleaned up version mantains only the ones that provide estimates on the mean and standard deviations.
Besides the measures themselves, the dataset also includes a collumn with the name of the activity performed for a aparticular observation, and another collumn with the number of the subject in question.

The tidy dataset groups all observations by subject and activity performed, and calculates the avaerage of all the measures for a particular variable. Since there are 6 different activities and 30 different subjects, this results in 6*30 = 180 observations.

## Binding and transforming data
First the script loads all the text files provided into R dataframes. The 'Inertial Signals' folders were excluded, as they were not necessary for this analysis.  
Then the test and train sets are binded with their respective activity and subject IDs.  
The script then creates a unique dataset, by simply row binding the train and test datasets, as they contain exactly the same variables.  
The variable names are then identified using the 'features' dataframe, and the activities IDs are matched with their name.  
Te variables names with the suffix "-mean()" and "-std()" are then indexed, and these indices are used to subset the dataset, in order to keep only observations on the means and standard deviations, as well as the activitie's names and the subject's IDs.
The final tidy dataset is obrained by simply grouping the observations by their activity and subject names, and summarising the remaining collumns by their mean.

## Variables
__SubjectNumber__: The number of the subject   
__ActivityName__: A human readable name of the activity being performed when the measure was taken   
__Other Variables__: estimates on the mean and standard deviation of the measures on 3-axial linear acceleration and 3-axial angular velocity
