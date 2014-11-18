# Coursera: Getting and Cleaning Data
# Course Project

# Download and unzip the data from this source:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(plyr)

# Step 1: Merge the training and test sets to create one data set

# read in data from test and training files & assign column names to subject and
# activity tables
subjectTest <- read.table("test/subject_test.txt", col.names="SubjectID")
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt", col.names="ActivityID")

subjectTrain <- read.table("train/subject_train.txt", col.names="SubjectID")
xTrain <- read.table("train/X_train.txt")
yTrain <- read.table("train/y_train.txt", col.names="ActivityID")

# combine data into one table
testData <- cbind(subjectTest, yTest, xTest)
trainingData <- cbind(subjectTrain, yTrain, xTrain)
mergedData <- rbind(testData, trainingData)

# Step 2: Extract only the measurements on the mean and standard deviation for 
#         each measurement. 

# read in data from features table
features <- read.table("features.txt", stringsAsFactors=FALSE)

# extract features that measure mean or standard deviation
featuresMeanStd <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# subset mergedData to retain only columns that measure mean or standard deviation
meanStdData <- mergedData[ ,c(1, 2, featuresMeanStd$V1+2)]

# Step 3: Use descriptive activity names to name the activities in the data set

# read in data from activity_labels table
aLabels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)

# replace ActivityIDs with label names
meanStdData$ActivityID <- aLabels[meanStdData$ActivityID, 2]

# Step 4: Appropriately label the data set with descriptive variable names

# create a vector of column/feature names
columnNames <- c("SubjectID", "Activity", featuresMeanStd$V2)

# clean feature names
for (i in 1:length(columnNames)) {
        columnNames[i] <- gsub("-mean\\(\\)", "Mean", columnNames[i])
        columnNames[i] <- gsub("-std\\(\\)", "StdDev", columnNames[i])
        columnNames[i] <- gsub("-X", "X", columnNames[i])
        columnNames[i] <- gsub("-Y", "Y", columnNames[i])
        columnNames[i] <- gsub("-Z", "Z", columnNames[i])
        columnNames[i] <- gsub("BodyBody","Body", columnNames[i])
        columnNames[i] <- gsub("^(t)", "time", columnNames[i])
        columnNames[i] <- gsub("^(f)", "freq", columnNames[i])
        columnNames[i] <- gsub("Gyro", "Gyroscope", columnNames[i])
        columnNames[i] <- gsub("Acc", "Accelerometer", columnNames[i])
        columnNames[i] <- gsub("Mag", "Magnitude", columnNames[i])
}

# apply cleaned names as column headers
colnames(meanStdData) <- columnNames

# Step 5:  Create a second, independent tidy data set with the average of each
#          variable for each activity and each subject

# create table containing averages for each variable by subject and activity
meanStdDataAv <- ddply(meanStdData, c("SubjectID", "Activity"), numcolwise(mean))

# write tidy data to text file
write.table(meanStdDataAv, file="tidyDataAverages.txt", row.name=FALSE)