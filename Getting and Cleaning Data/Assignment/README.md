# Assignment for Getting and Cleaning Data - Week 4

## Steps of the assignment:

The run_analysis.R does the following:

1 - Merges the training and the test sets to create one data set.
2 - Extracts only the measurements on the mean and standard deviation for each measurement.
3 - Uses descriptive activity names to name the activities in the data set
4 - Appropriately labels the data set with descriptive variable names.
5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Not necessarily in the order.
Step 4 is done on data load.
Then steps 1 and 3, and finally 2, 4 again for better understanding and 5.
Every step is explained within the code.

## About the data:

The data was initially taken from the link as a .zip file:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The .zip file contained:

a README.txt explaining the files inside the .zip files,
a features_info.txt explaining how the test was performed,
a features.txt with 561 names of every feature measured in the test,
an activity_labels.txt with the names of the 6 acitivities performed.

two folders: test and train containing the data from the test.

in the train folder:

a subject_train.txt with 7352 rows of 30 subjects IDs
a X_train.txt with 7352 rows and 561 columns containing the test results
a y_train.txt with 7352 rows of the 6 activities
a Inertial Signal folder with data not used in this assignment

in the test folder:

a subject_test.txt with 2947 rows of 30 subjects IDs
a X_test.txt with 2947 rows and 561 columns containing the test results
a y_test.txt with 2947 rows of the 6 activities
a Inertial Signal folder with data not used in this assignment

## Functions used:

setwd() - for setting the work directory
read.table() - for reading data
unique() - for discovering the unique values in a column
head() - for overviewing the dataset
str() and - for visualizing the big picture of the data frame
cbind() - for joining columns (subject and activity) together
rbind() - for joining rows from different data frames
gsub() - for replacing `str` data
colnames() - for replacing columns names
grep() - for find `str` data
names() - to discover all columns names
write.table() - for outputting the data

{dplyr} package:
tbl_df() - for a batter data frame format
group_by() - for grouping data by subject and activity
summarize_all() - for calculating the mean of every feature
