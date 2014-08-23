
# Check if the reshape2 package is available
# if not then install it.

if (!require("reshape2")) {
        print("reshape2 package not installed...")
        print("installing now...")
        install.packages("reshape2")
}

require("reshape2")

print("Loading feature and activity metadata...")

# read and store feature labels and activity labels
features = read.table('./features.txt',header=FALSE); 
activity_labels = read.table('./activity_labels.txt',header=FALSE); 

# assign meaningful column names to feature and activity_label data.frames
names(features)<-c("Feature ID", "Feature")
names(activity_labels)<-c("ActivityID", "Activity")
print("Done")

# assess the content of features and activity label data frames
# str(features)
# str(activity_labels)

print("Loading test data...")
# read and store test data (x_test), test subjects (subject_test) and test activity type data (y_test)
x_test = read.table('./test/x_test.txt')
subject_test = read.table('./test/subject_test.txt')
y_test = read.table('./test/y_test.txt')

# Apply actual feature names to x_test columns
names(x_test)<-features$Feature
# Name the subject id column in subject_test
names(subject_test)<-c("SubjectID")
# Name the activity id column in activity data y_test
names(y_test)<-c("Activity")
# Replace the Activity IDs with the descriptive Activity Labels
y_test[,1] = activity_labels[y_test[,1], 2]
# Retain only the mean and standard deviation feature columns
x_test<-x_test[,grep('mean|std',names(x_test))]

print("Done")

print("Loading training data...")
# read and store training data (x_train), training subjects (subject_train) and training activity type data (y_train)
x_train = read.table('./train/x_train.txt')
subject_train = read.table('./train/subject_train.txt')
y_train = read.table('./train/y_train.txt')

# Apply actual feature names to x_train columns
names(x_train)<-features$Feature
# Name the subject id column in subject_train
names(subject_train)<-c("SubjectID")
# Name the activity id column in activity data y_train
names(y_train)<-c("Activity")
# Replace the Activity IDs with the descriptive Activity Labels
y_train[,1] = activity_labels[y_train[,1], 2]

# Retain only the mean and standard deviation feature columns
x_train<-x_train[,grep('mean|std',names(x_train))]

print("Done")

# Remove brackets and dashes from column names in training and test data
names(x_test) <- gsub("\\(|\\)", "", names(x_test))
names(x_test) <- gsub("-", " ", names(x_test))
names(x_train) <- gsub("\\(|\\)", "", names(x_train))
names(x_train) <- gsub("-", " ", names(x_train))

print("Merge training and test data")
# merge the feature, subject and activity columns into single 
# data.frames for training and test
clean_test<-cbind(subject_test, y_test,x_test)
clean_train<-cbind(subject_train, y_train,x_train)

# Combine the training and test datasets
merged_clean_data<-rbind(clean_test,clean_train)


print("Done")

print("Write merged data file")
# Write the clean and merged data to file
write.table(merged_clean_data, "./merged_clean_data.txt", row.names=FALSE)
print("Done")

print("Create Summary Data Set")
# Create a second summary dataset  with the average of each feature for each activity and subject
merged_clean_data_melt <- melt(merged_clean_data,id=c("Activity", "SubjectID"),measure.vars=names(merged_clean_data)[c(-1,-2)])
mean_features_by_subject_activity <- dcast(merged_clean_data_melt,  Activity +SubjectID ~ variable,mean)
# rename the output columns to reflect the fact they are averages by subject and activity 
names(mean_features_by_subject_activity)[c(-1,-2)]<-paste("average(",names(mean_features_by_subject_activity)[c(-1,-2)],")", sep='' )
print("Done")

print("Write the summary data file")
# The summary dataset is written to file
write.table(mean_features_by_subject_activity, "./mean_features_by_subject_activity.txt", row.names=FALSE)
print("Done")
print("Script Complete")


