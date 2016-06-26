library("dplyr")
#read in labels
featureLables <- read.table("UCI HAR Dataset/features.txt") #read in column labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt") #map to y*.txt below

#read in train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
#combine into one train dataset
trainActivityNameVector <- cut(trainActivity$V1, br =6 , labels=activityLabels$V2)
train <- mutate(train, activity = trainActivityNameVector)
subject <- trainSubject$V1
train <- cbind(train, subject)

#read in test data
test <- read.table("UCI HAR Dataset/test/X_test.txt") # read in test data set
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
#combine into one trest data set
testActivityNameVector <- cut(testActivity$V1, br =6 , labels=activityLabels$V2)
test <- mutate(test, activity = testActivityNameVector)
subject <- testSubject$V1
test <- cbind(test, subject)
#Tidy

#1- combine rows of test and train into one data set
testAndTrainRows <- rbind(train, test)
#2- add featureLabels as the column labels
colnames(testAndTrainRows) <- featureLables$V2
colnames(testAndTrainRows)[562] <- "activity"
colnames(testAndTrainRows)[563] <- "subject"

#3- filter measurements by text search on "mean|std"
meanStdCols <- grepl("std|mean|activity|subject", names(testAndTrainRows))
filteredData <- testAndTrainRows[,meanStdCols]

#Second Data set
#1- calculate mean for each activity by participant
meanData <- aggregate(filteredData, by=list(testAndTrainRows$subject), FUN=mean)
names(meanData)[1] <- "subjectID"

#Remove temp variables
remove(activityLabels, featureLables, test, testActivity, testSubject, train, trainActivity, trainSubject)

#Write out data
write.table(meanData, file="meanFeatureBySubject.txt", row.names = FALSE)

