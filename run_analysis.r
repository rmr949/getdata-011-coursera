run-analysis = function() {

#Reads the train and test - data, activity and subject values
train_data = read.table("UCI HAR Dataset/train/X_train.txt")
train_labels = read.table("UCI HAR Dataset/train/y_train.txt")
test_data = read.table("UCI HAR Dataset/test/X_test.txt")
test_labels = read.table("UCI HAR Dataset/test/y_test.txt")
train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")
test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")

#Combines the test and train - data, activity and subject values into a single data frame
combined_data = rbind(train_data, test_data)
combined_labels = rbind(train_labels, test_labels)
combined_subject = rbind(train_subject, test_subject)

combined_raw_data = cbind(combined_subject, combined_labels, combined_data)

#Replaces the activity codes with descriptive activity names using the activity_labels.txt file
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt")

raw_labels = combined_raw_data[,2]
i = 1
for(label in raw_labels) {
  raw_labels[i] = toString(activity_labels[as.integer(label),2])
  i = i+1
}
combined_raw_data[,2] =  raw_labels

#Replaces the column names with descriptive column names using the features.txt file
descriptive_col_names = read.table("UCI HAR Dataset/features.txt")

colnames(combined_raw_data)[1] = "Subject"
colnames(combined_raw_data)[2] = "Activity"
i=3
for(name in descriptive_col_names[,2]) {
  colnames(combined_raw_data)[i] = name
  i=i+1
}

ncols = c(1:ncol(combined_raw_data))
for(col in ncols) {
  if(col != 2) {
    combined_raw_data[,col] = as.numeric(as.character(combined_raw_data[,col]))
  }
}

#Calculates the average of each variable for each activity and each subject and appends it to a new data frame
tidy_data = combined_raw_data[1,]
subjects = c(1:30)
for(subject in subjects) {
  subset_subject = combined_raw_data[combined_raw_data$Subject == subject,]
  for(activity in activity_labels[,2]){
    subset_subject_activity = subset_subject[subset_subject$Activity == activity,]
    subset_subject_activity = sapply(subset_subject_activity,mean)
    subset_subject_activity$Subject = subject
    subset_subject_activity$Activity = activity
    tidy_data[nrow(tidy_data)+1,] = subset_subject_activity
  }
}

#Writes the tidy data frame to a txt file
write.table(tidy_data[2:nrow(tidy_data),],"tidy_data.txt",col.names=FALSE)

}