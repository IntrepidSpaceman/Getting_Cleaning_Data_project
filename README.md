# Getting Cleaning Data project
 
## Overview
This repo contains only one script 'run_analysis.R' that loads the raw data and contructs two datasets:   
__'dataset'__: dataset that merges test and training data, labels them and mantains onlly the measurments on the mean and standard deviation.   
__'averages_dataset'__: produced from the previous dataset by grouping all hte observations by subject number and activity name, and summarising the remaining variables by thei average.  
   
The script assumes that in the working directory there are two folders, 'test' and 'train', which contain the datasets. Also on the working directory, the features.txt andactivity_labels.txt files should be present.