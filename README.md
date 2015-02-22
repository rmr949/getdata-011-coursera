##run_analysis.R

####To run the code
1. Clone the repository
2. Download and extract the data into the repository (do not change the name of the extracted folder)
3. set the working directory to this directory
4. source the 'run_analysis.R' file
5. call the run_analysis() function

####Output
* 'tidy_data.txt' file, in which each row represents the average of each variable for each activity and each subject
* 'tidy_data.txt' has 180 rows (30 subjects X 6 activities)
* Variables are explained in codebook.md

####How the script works
1. Reads the train and test - data, activity and subject values
    * X_train.txt
    * y_train.txt
    * X_test.txt
    * y_test.txt
    * subject_train.txt
    * subject_test.txt
2. Combines the test and train - data, activity and subject values into a single data frame
3. Replaces the activity codes with descriptive activity names using the activity_labels.txt file
4. Replaces the column names with descriptive column names using the features.txt file
5. Calculates the average of each variable for each activity and each subject and appends it to a new data frame
6. Writes the tidy data frame to a txt file