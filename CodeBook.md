#Code Book
##Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#Attribute Information
For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

##Data Transformation
1. Merges the training and the test data sets to create one data set
**Subject** (`UCI HAR Dataset/train/subject_train.txt`, `UCI HAR Dataset/test/subject_test.txt`), **Activity** (`UCI HAR Dataset/train/y_train.txt`, `UCI HAR Dataset/test/y_test.txt`), **Training and test data sets** (`UCI HAR Dataset/trainX_train.txt`, `UCI HAR Dataset/test/X_test.txt`) are merged to create a single data set. Measurements are labelled with the names defined in `UCI HAR Dataset/features.txt`.
2. Extracts only the measurements on the mean and standard deviation for each measurement
Only the values of the measurements on the mean (measurement with labels that contain "mean") and standard deviation (measurement with labels that contain "std") are selected / extracted for further processing.
3. Uses descriptive activity names to name the activities in the data set
Add the column **ActivityName** to the intermediate data set. The column **ActivityID** is used to look up the **ActivityName** in `UCI HAR Dataset/activity_labels.txt`.
4. Appropriately labels the data set with descriptive variable names
The selected measurements are labelled appropriately, e.g. FrequencyDomain instead of f, TimeDomain instead of t, StandardDeviation instead of std, etc. 
5. Creates a tidy data set with the average of each variable for each activity and each subject
The tidy data set contains 180 observations with 68 variables divided in:
- **Subject** (as numeric)
- **ActivityName**: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING (as factor)
- 66 measurements on the mean and standard deviation (as numeric)
