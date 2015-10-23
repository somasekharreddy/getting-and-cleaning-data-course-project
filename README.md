# Getting and Cleaning Data

## Course Project
This script is to prepare an independent tidy data set with average of each variable for each activity and each subject by processing the ```Human Activity Recognition Using Smartphones Dataset```

### Following are the steps involved in preparing the tidy data set 

1. Extracts only the measurements on the mean and standard deviation for each measurement.
2. Uses descriptive activity names to name the activities in the data set
3. Appropriately labels the data set with descriptive activity names.
4. Merges the training and the test sets to create one data set.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Download the data available at following link ```https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip```.
2. Extract the zip file into a R working directory on your local drive. Once the zip file is extracted, You will have a ```UCI HAR Dataset``` folder.
3. Place the ```run_analysis.R``` script in R working directory, where the ```UCI HAR Dataset folder``` is also available.
4. Open R Console or RStudio.
5. Execute ```source("run_analysis.R")``` on R Console or RStudio; It will generate a new file tidy_data.txt in your working directory.

## Dependencies

```run_analysis.R``` script depends on ```dplyr``` package, which will be installed automatically if not available in your local machine.