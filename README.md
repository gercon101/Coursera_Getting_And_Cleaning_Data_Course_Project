## Getting and Cleaning Data Course Project

### Download the data
* The data for the course project can be found @ https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  Download the data to a folder on your local machine e.g. c:\coursera\getting and cleaning data\project\
  unzipping the data in c:\coursera\getting and cleaning data\project\ will create a subfolder \UCI HAR Dataset\ containing the data

### Run the R Script
* Place the R script run_analysis.R in the top level data folder \UCI HAR Dataset\


* set your working directory to be the top level data folder
  e.g setwd("c:\\coursera\\getting and cleaning data\\project\\UCI HAR Dataset\\")

* run the R script 
  source("run_analysis.R")

### What the R Script does
* The run_analysis.R script performs the following actions.

* loads the feature descriptions from \UCI HAR Dataset\features.txt
  loads the activity descriptions from \UCI HAR Dataset\activity_labels.txt

*  It then loads the test data, combining readings, subjects and activities data

  \UCI HAR Dataset\test\X_test.txt
  \UCI HAR Dataset\test\subject_test.txt
  \UCI HAR Dataset\test\y_test.txt

* In the process both features and activities are given their descriptive names, 
  futher more only mean and standard deviation feature columns are retained

* The same process is repeated for the training data

  \UCI HAR Dataset\train\X_train.txt
  \UCI HAR Dataset\train\subject_train.txt
  \UCI HAR Dataset\train\y_train.txt
  
* Next test and training datasets are combined using rbind

* The merged and cleaned data is written to the file \UCI HAR Dataset\merged_clean_data.csv

* Finally a summarized dataset is produced which provides the average of each feature for each activity and subject
  This summarized dataset is written to the file \UCI HAR Dataset\mean_features_by_subject_activity.csv

  