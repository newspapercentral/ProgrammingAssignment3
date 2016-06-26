README.md

The run_analysis script reads in data from Human Activity Recognition Using Smartphones Dataset, and cleans up the data to make it tidy. For information on the original data set, see https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The data was obtained from here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. I unzipped the dataset and stored it in the directory "UCI HAR Dataset".

To tidy this data, run the "run_analysis.R" script.

I produce two data sets that are stored in the filteredData and meanData variables respectively. The filteredData set contains train and test data sets from the original set combined with the activities performed and the subject IDs. I added the measurement labels and activity and feature labels to make the data more tidy. Each row contains an observation, and each column contains a feature, activity, or subject ID. See the code book for more details. The data is filtered to only include the standard deviation and mean features. To get an unfiltered data set, see the testAndTrainRows data set.

The meanData set takes the average of each variable for each activity and each subject. There is one row for each subject and each column contains the mean of that feature for that subject. Note, this information is meaningless for the activity and subject columns, but it is included for completeness. This data set is stored in "meanFeatureBySubject.txt"