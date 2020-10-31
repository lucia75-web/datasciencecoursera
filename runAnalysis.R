
#You should create one R script called run_analysis.R that does the following.
#
# - Merges the training and the test sets to create one data set.
# - Extracts only the measurements on the mean and standard deviation for each measurement.
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names.
# - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  library(data.table)
  library(dplyr)

# read data from file
#- 'features_info.txt': Shows information about the variables used on the feature vector.
#- 'features.txt': List of all features. 
#- 'activity_labels.txt': Links the class labels with their activity name. 
#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels. 
#- 'test/X_test.txt': Test set.
#- 'test/y_test.txt': Test labels
#- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  
  setwd("~/Coursera/datasciencecoursera")
  TestLabel      <- read.table("UCI HAR Dataset/test/y_test.txt", comment.char = "", colClasses="numeric")
  TestSet        <- read.table("./UCI HAR Dataset/test/x_test.txt", comment.char = "", colClasses="numeric")
  SubjectTest    <- read.table("./UCI HAR Dataset/test/subject_test.txt", comment.char = "", colClasses="numeric")
  TrainingLabel  <- read.table("./UCI HAR Dataset/train/y_train.txt", comment.char = "", colClasses="numeric")
  TrainignSet    <- read.table("./UCI HAR Dataset/train/x_train.txt", comment.char = "", colClasses="numeric")
  SubjectTrain   <- read.table("./UCI HAR Dataset/train/subject_train.txt", comment.char = "", colClasses="numeric")
  FeatureList    <- read.table("./UCI HAR Dataset/features.txt", sep=" ", comment.char = "", colClasses="character")
  #  FeatureInfo    <- read.table("./UCI HAR Dataset/features_info.txt", sep=" ", comment.char = "", colClasses="character")
  ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
  
# Merges the training and the test sets to create one data set..
  
  Subject <- rbind(SubjectTrain, SubjectTest)
  DataSet <- rbind(TrainignSet, TestSet)
  Label   <- rbind(TrainingLabel, TestLabel)
  
  colnames(DataSet) <- t(FeatureList[2])
  colnames(Label)   <- "Activity"
  colnames(Subject) <- "Subject"
  
  AllData <- cbind(DataSet,Label,Subject)
  
# Extracts only the measurements on the mean and standard deviation for each measurement
  dim <- dim(AllData)
  columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(AllData), ignore.case=TRUE)
  RequiredColumns <- c(columnsWithMeanSTD, dim[2]-1, dim[2])
  ExtractedData <- AllData[,RequiredColumns]
  
#  Uses descriptive activity names to name the activities in the data set.

  ExtractedData$Activity <- as.character(ExtractedData$Activity)
  
  dim <- dim(ActivityLabels)
  for (i in 1:dim[1])
  {
     ExtractedData$Activity[ExtractedData$Activity == i] <- as.character(ActivityLabels[i,dim[2]])
  }

  ExtractedData$Activity <- as.factor(ExtractedData$Activity)
  
#  Appropriately labels the data set with descriptive variable names
  names(ExtractedData)
  names(ExtractedData)<-gsub("Acc", "Accelr", names(ExtractedData))
  names(ExtractedData)<-gsub("Gyro", "Gyroscope", names(ExtractedData))
  names(ExtractedData)<-gsub("Body", "Body", names(ExtractedData))
  names(ExtractedData)<-gsub("Mag", "Magnitude", names(ExtractedData))
  names(ExtractedData)<-gsub("^t", "Time", names(ExtractedData))
  names(ExtractedData)<-gsub("^f", "Frequency", names(ExtractedData))
  names(ExtractedData)<-gsub("tBody", "TimeBody", names(ExtractedData))
  names(ExtractedData)<-gsub("-mean()", "Mean", names(ExtractedData))
  names(ExtractedData)<-gsub("-std()", "STD", names(ExtractedData))
  names(ExtractedData)<-gsub("-freq()", "Frequency", names(ExtractedData))
  names(ExtractedData)<-gsub("angle", "Angle", names(ExtractedData))
  names(ExtractedData)<-gsub("gravity", "Gravity", names(ExtractedData))
  names(ExtractedData)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable
# for each activity and each subject
  ExtractedData <- data.table(ExtractedData)
  TidyData <- aggregate(Label, ExtractedData, mean)
  TidyData <- TidyData[order(TidyData$Subject,TidyData$Activity),]
  write.table(TidyData,file="TidyData", sep = ",",col.names=colnames(TidyData))

 
 
 
 