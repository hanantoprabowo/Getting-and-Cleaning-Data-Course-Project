# Install plyr if it does not exist
if (!require("plyr")) {
	install.packages("plyr")
}

# Import plyr
require("plyr")

# Download and unzip raw data set (if it does not exist yet)
zipFile <- file.path(".", "getdata_projectfiles_UCI HAR Dataset.zip")
if (!file.exists(zipFile)) {
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zipFile, method = "curl")
	unzip(zipFile, exdir = ".")
}

# Load features data
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("FeatureID", "FeatureName"), colClasses = c("character"))

# Load activity data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityName"))

# Load training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Load test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Merge the training and test data
training_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
merged_data <- rbind(training_data, test_data)

# Create the labels of the merged data
merged_labels <- rbind(rbind(features, c(nrow(features) + 1, "Subject")), c(nrow(features) + 2, "ActivityID"))
names(merged_data) <- merged_labels[,2]

# Extract the measurements on the mean and standard deviation for each measurement.
extracted_merged_data <- merged_data[,grepl("mean\\(\\)|std\\(\\)|Subject|ActivityID", names(merged_data))]

# Use descriptive activity names to name the activities in the data set
extracted_merged_data <- join(extracted_merged_data, activity_labels, by = "ActivityID", match = "first")
extracted_merged_data <- extracted_merged_data[,-1]

# Use clearer names
names(extracted_merged_data) <- gsub('-',".",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('^t',"TimeDomain.",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('^f',"FrequencyDomain.",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('Acc',"Acceleration",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('Gyro',"Gyroscope",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('Mag',"Magnitude",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('mean\\(\\)',"Mean",names(extracted_merged_data))
names(extracted_merged_data) <- gsub('std\\(\\)',"StandardDeviation",names(extracted_merged_data))

# Create a tidy data set with the average of each variable for each activity and each subject.
average_by_activity_subject <- ddply(extracted_merged_data, c("Subject","ActivityName"), numcolwise(mean))
write.table(average_by_activity_subject, file = "average_by_activity_subject.txt", row.name=FALSE)