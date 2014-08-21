
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



rm(list=ls())  

library("reshape2")


# set the working directory
setwd("C:\\Users\\ConwayGn\\Documents\\Coursera\\Getting and Cleaning Data\\project\\UCI HAR Dataset")


# read and store feature labels and activity labels
features = read.table('./features.txt',header=FALSE); 
activity_labels = read.table('./activity_labels.txt',header=FALSE); 

# assign meaningful column names to feature and activity_label data frames
names(features)<-c("Feature ID", "Feature")
names(activity_labels)<-c("Activity ID", "Activity")

# assess the content of features and activity label data frames
# str(features)
# str(activity_labels)

# read and store test data (x_test), test subjects (subject_test) and test activity type data (y_test)
x_test = read.table('./test/x_test.txt')
subject_test = read.table('./test/subject_test.txt')
y_test = read.table('./test/y_test.txt')

# Apply actual feature names to x_test columns
names(x_test)<-features$Feature
names(subject_test)<-c("SubjectID")
names(y_test)<-c("Activity")

# Swap the activity IDs for descriptive Activity Labels
y_test[,1] = activity_labels[y_test[,1], 2]

# read and store training data (x_train), training subjects (subject_train) and training activity type data (y_train)
x_train = read.table('./train/x_train.txt')
subject_train = read.table('./train/subject_train.txt')
y_train = read.table('./train/y_train.txt')

# Apply actual feature names to x_train columns
names(x_train)<-features$Feature
names(subject_train)<-c("SubjectID")
names(y_train)<-c("Activity")
y_train[,1] = activity_labels[y_train[,1], 2]

# Select on the mean and standard deviation features
x_test<-x_test[,grep('mean|std',names(x_test))]
x_train<-x_train[,grep('mean|std',names(x_train))]

names(x_test) <- gsub("\\(|\\)", "", names(x_test))
names(x_test) <- gsub("-", " ", names(x_test))
names(x_train) <- gsub("\\(|\\)", "", names(x_train))
names(x_train) <- gsub("-", " ", names(x_train))


clean_test<-cbind(subject_test, y_test,x_test)
clean_train<-cbind(subject_train, y_train,x_train)

merged_clean_data<-rbind(clean_test,clean_train)



merged_clean_data_melt <- melt(merged_clean_data,id=c("SubjectID","Activity"),measure.vars=names(merged_clean_data)[c(-1,-2)])
mean_features_by_subject_activity <- dcast(merged_clean_data_melt,  SubjectID + Activity ~ variable,mean)
write.table(mean_features_by_subject_activity, "./mean_features_by_subject_activity.csv", sep=",", row.names=FALSE)
