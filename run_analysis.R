## This script works based on methods available in dplyr and R base packages.
## Following are the actions performed by this script:
##    1. Extracts only the measurements on the mean and standard deviation for each measurement.
##    2. Uses descriptive activity names to name the activities in the data set
##    3. Appropriately labels the data set with descriptive activity names.
##    4. Merges the training and the test sets to create one data set.
##    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Checking whether dplyr package is installed and available on the system or not
# Installing and loading the dplyr package, if not available in workspace
if (!require("dplyr")){
  install.packages("dplyr")
}

# In order to execute this script "UCI HAR Dataset" directory should be placed in present working directory
if (!file.exists("UCI HAR Dataset")){
  stop("\"UCI HAR Dataset\" directory not found in present working directory")
}

# Extracting feature names from features data set
feature_names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, colClasses = c("integer","character"))[,2]
# Extracting activity names from activity labels data set
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, colClasses = c("integer","character"))[,2]

# Extracting the values of every feature from test data set
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
# Setting the variable/Column names of test feature data frame
names(x_test) <- feature_names

# Extracting the values of every feature from training data set
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
# Setting the variable/Column names of train feature data frame
names(x_train) <- feature_names

# Removing the duplicate variables/columns in feature data frame from test data set
x_test <- x_test[,!duplicated(colnames(x_test))]

# Removing the duplicate variables/columns in feature data frame from training data set
x_train <- x_train[,!duplicated(colnames(x_train))]

# Extract only the measurements on the mean and standard deviation for each measurement from test data set
x_test = select(x_test,matches(".*-mean.*|.*-std.*"))

# Extract only the measurements on the mean and standard deviation for each measurement from training data set
x_train = select(x_train,matches(".*-mean.*|.*-std.*"))

# Extracting the activities performed from test data set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

# Extracting the activities performed from training data set
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Mutating a dataframe with activity names in test data set
y_test[,2] = activity_names[y_test[,1]]
# Setting the variable/Column names of test activity data frame
names(y_test) = c("activity_id", "activity_name")

# Mutating a dataframe with activity names in training data set
y_train[,2] = activity_names[y_train[,1]]
# Setting the variable/Column names of train activity data frame
names(y_train) = c("activity_id", "activity_name")

# Extracting the subject who performed the activity for each window sample of test data set
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
# Setting the variable/Column names of subject data frame
names(subject_test) = "subject_id"

# Extracting the subject who performed the activity for each window sample of training data set
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
# Setting the variable/Column names of subject data frame
names(subject_train) = "subject_id"

# Column binding the test data sets
test_data <- cbind(subject_test, y_test, x_test)

# Column binding the training data sets
train_data <- cbind(subject_train, y_train, x_train)

# Row binding/Merging the testing and training data sets
raw_data <- rbind(test_data,train_data)

# Preparing the tidy dataset with average of each variable for each activity and each subject
tidy_data <- raw_data %>%
  group_by(subject_id,activity_name) %>%
  summarize_each(funs(mean),-(subject_id:activity_name)) %>%
  arrange(subject_id,activity_name)

# Writing the tidy data set to file
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)
