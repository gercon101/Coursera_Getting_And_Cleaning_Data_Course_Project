## CodeBook
        	
### Original Data Source

* The original data was obtained here; https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* The original dataset description can be found here; http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
		
### Data Set Information
		
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
        
The experiments was  carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the following data was captured, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were  video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
		
More detailed information on the dataset can be found in the dataset ReadMe file and here; http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
		
## The data

####   metadata files
        \UCI HAR Dataset\features.txt: List of all features i.e. quantitative measures recorded
	
        \UCI HAR Dataset\activity_labels.txt: Descriptive names for the activities i.e.walking, sitting, etc.

#### training data files
        \UCI HAR Dataset\train\X_train.txt': Training set.
	
        \UCI HAR Dataset\train\y_train.txt': Activity Codes recorded manually (1 to 6)
        
        \UCI HAR Dataset\train\subject_train.txt : The subject identifier who performed the activity for each (1 to 30)
	
#### test data files
        \UCI HAR Dataset\test\X_test.txt': Training set.
	
        \UCI HAR Dataset\test\y_test.txt': Activity Codes recorded manually (1 to 6)
        
        \UCI HAR Dataset\test\subject_test.txt : The subject identifier who performed the activity for each (1 to 30)

#### Other files 
        Other files in the UCI HAR Dataset were not used in this project
		
## Data Transformation
		
The run_analysis.R script performs the following transformations on the original data described above

        1. The quantitative measurement columns in x_train and x_test are named using the content extracted from features.txt
        2. The activity ids in y_train and y_test are translated to their longer descriptive names extracted from activity_labels.txt
        3. All but the mean and standard deviation features are removed from the training and test datasets.
        4. The column names are tidied up
        3. THe quantitative measures, activity labels and subjet ids are merged for both the training and test datasets (cbind).
        4. The training and test datasets are combined into a single dataset (rbind).
        5. The cleaned and merged dataset is written to the file \UCI HAR Dataset\merged_clean_data.txt
        6. A second independent data set with the average of each feature for each activity and subject is produced
        7. This second summary data set is written to the file \UCI HAR Dataset\mean_features_by_subject_activity.txt
		
