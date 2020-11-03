## Getting and Cleaning Data - peer assessment project

## About R script
 File with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work)

 - Merges the training and the test sets to create one data set.
 - Extracts only the measurements on the mean and standard deviation for each measurement.
 - Uses descriptive activity names to name the activities in the data set
 - Appropriately labels the data set with descriptive variable names.
 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity  
   and each subject.

## About variables:
### TrainignSet, TrainingLabel, TestSet, TestLabel, SubjectTrain and SubjectTest 
contain the data from the downloaded files.
### Subject, DataSet and AllData 
cointain merge the previous datasets to further analysis
### columnsWithMeanSTD 
contains only the data with mean and standard deviation measurements 
### ExtractedData 
contains the data set with descriptive variable names
### TidyData 
is the new set data with the average of each variable for each activity and each subject
 