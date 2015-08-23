
## Project Description
Take the [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and perform the following:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Make descriptive activity names for each activity in the dataset
4. Make descriptive variable names. 
5. Generate a tidy data set with the average of each variable for each activity and each subject.


##Study design and data processing

###Collection of the raw data
All data files were part of a zip archive. The canonical source of the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The zip archived contained multiple files. Below is a partial list which includes the files that were referenced or processed for this exercise. 
- README.txt
- features_info.txt: Shows information about the variables used on the feature vector.
- features.txt: List of all features.
- activity_labels.txt: Links the class labels with their activity name.
- train/X_train.txt: Training set.
- train/y_train.txt: Training labels.
- test/X_test.txt: Test set.
- test/y_test.txt: Test labels.
- train/subject_train.txt:
- test/subject_test.txt: Participant identifier.



###Notes on the original (raw) data 
As a whole, the raw data was divided into a test and training set. These two datasets were re-combined again for the purpose of this experiment.

####For each record we received:
 * Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
 * Triaxial Angular velocity from the gyroscope. 
 * A 561-**feature** vector with time and frequency domain variables. 
 * Its activity label. 
 * An identifier of the subject who carried out the experiment.

####Features

The original source of the features processed were originally part of a database of measurements from the **Samsung Galaxy S II** _accelerometer_ and _gyroscope_ 3-axial raw signals tAcc-XYZ and tGyro-XYZ. The signals were then processed and subsequently used to generate statistics.



##Creating the tidy datafile

###Guide to create the tidy data file
1. Download data from the link provided at the project page.
2. Extract the data in the same directory where the run_analysis.R script is located. Make sure to extract the data into a directory named: "UCI HAR Dataset". Alternatively change the script accordingly.
3. Source the R script run_analysis.R
4. Call the function MakeTidy()
5. Locate output file: tidy_data.txt in the same directory where the script run_analysis.R is located.

###Cleaning of the data
The data was loaded from various files into R.
A subset of columns were selected and their names were sanitized and renamed to better meet tidy data guidelines.
Data from the different sources was merged into a data frame.
The mean statistic was applied to the appropriate variables.
A new tidy file was generated.

Check out the [README](./README.md)) for more details.


####Variables

Note: The following feature variables are a subset of the original dataset. We selected only values that measured means and standard deviation. There are two root measurement sources from the Samsung Galaxy S II - the _accelerometer_ and _gyroscope_

As stated earlier, accelerometer measurements have the pattern tAcc-XYZ, where as gyroscope measurements have the pattern tGyro-XYZ. Incidentally, the variables are prefixed with either a 't' or a 'f'. Variables prefixed with 't' are for time domain signals, whereas variables prefixed with 'f' are for frequency domain signals. Detailed information can be found in the raw data features_info.txt file.


Note: feature measurements are the mean values of the derived from variable aggregated by subject id and activity type

<table>
    <tr>
        <th>Variable</th>
        <th>Type</th>
        <th>Description</th>
        <th>Derived From</th>
    </tr>
    <tr>
        <td>subject.id</td><td>INT</td><td>Subject Identifier</td><td></td>
    </tr>
    <tr>
        <td>activity.label</td>
        <td>FACTOR  w/ 6 levels: LAYING, SITTING,   - STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS</td>
        <td>The activity Label</td>
        <td>n/a</td>
    </tr>

    <tr> <td>tBodyAcc_std_X_Mean</td><td>NUM</td><td>Mean value of tBodyAcc_std_X</td><td>tBodyAcc_std_X</td> </tr>
    <tr> <td>tBodyAcc_std_Y_Mean</td><td>NUM</td><td>Mean value of tBodyAcc_std_Y</td><td>tBodyAcc_std_Y</td> </tr>
    <tr> <td>tBodyAcc_std_Z_Mean</td><td>NUM</td><td>Mean value of tBodyAcc_std_Z</td><td>tBodyAcc_std_Z</td> </tr>
    <tr> <td>tGravityAcc_std_X_Mean</td><td>NUM</td><td>Mean value of tGravityAcc_std_X</td><td>tGravityAcc_std_X</td> </tr>
    <tr> <td>tGravityAcc_std_Y_Mean</td><td>NUM</td><td>Mean value of tGravityAcc_std_Y</td><td>tGravityAcc_std_Y</td> </tr>
    <tr> <td>tGravityAcc_std_Z_Mean</td><td>NUM</td><td>Mean value of tGravityAcc_std_Z</td><td>tGravityAcc_std_Z</td> </tr>
    <tr> <td>tBodyAccJerk_std_X_Mean</td><td>NUM</td><td>Mean value of tBodyAccJerk_std_X</td><td>tBodyAccJerk_std_X</td> </tr>
    <tr> <td>tBodyAccJerk_std_Y_Mean</td><td>NUM</td><td>Mean value of tBodyAccJerk_std_Y</td><td>tBodyAccJerk_std_Y</td> </tr>
    <tr> <td>tBodyAccJerk_std_Z_Mean</td><td>NUM</td><td>Mean value of tBodyAccJerk_std_Z</td><td>tBodyAccJerk_std_Z</td> </tr>
    <tr> <td>tBodyGyro_std_X_Mean</td><td>NUM</td><td>Mean value of tBodyGyro_std_X</td><td>tBodyGyro_std_X</td> </tr>
    <tr> <td>tBodyGyro_std_Y_Mean</td><td>NUM</td><td>Mean value of tBodyGyro_std_Y</td><td>tBodyGyro_std_Y</td> </tr>
    <tr> <td>tBodyGyro_std_Z_Mean</td><td>NUM</td><td>Mean value of tBodyGyro_std_Z</td><td>tBodyGyro_std_Z</td> </tr>
    <tr> <td>tBodyGyroJerk_std_X_Mean</td><td>NUM</td><td>Mean value of tBodyGyroJerk_std_X</td><td>tBodyGyroJerk_std_X</td> </tr>
    <tr> <td>tBodyGyroJerk_std_Y_Mean</td><td>NUM</td><td>Mean value of tBodyGyroJerk_std_Y</td><td>tBodyGyroJerk_std_Y</td> </tr>
    <tr> <td>tBodyGyroJerk_std_Z_Mean</td><td>NUM</td><td>Mean value of tBodyGyroJerk_std_Z</td><td>tBodyGyroJerk_std_Z</td> </tr>
	<tr> <td>tBodyAccMag_mean_Mean</td><td>NUM</td><td>Mean value of tBodyAccMag_mean</td><td>tBodyAccMag_mean</td> </tr>
	<tr> <td>tBodyAccMag_std_Mean</td><td>NUM</td><td>Mean value of tBodyAccMag_std</td><td>tBodyAccMag_std</td> </tr>
	<tr> <td>tGravityAccMag_mean_Mean</td><td>NUM</td><td>Mean value of tGravityAccMag_mean</td><td>tGravityAccMag_mean</td> </tr>
	<tr> <td>tGravityAccMag_std_Mean</td><td>NUM</td><td>Mean value of tGravityAccMag_std</td><td>tGravityAccMag_std</td> </tr>
	<tr> <td>tBodyAccJerkMag_mean_Mean</td><td>NUM</td><td>Mean value of tBodyAccJerkMag_mean</td><td>tBodyAccJerkMag_mean</td> </tr>
	<tr> <td>tBodyAccJerkMag_std_Mean</td><td>NUM</td><td>Mean value of tBodyAccJerkMag_std</td><td>tBodyAccJerkMag_std</td> </tr>
	<tr> <td>tBodyGyroMag_mean_Mean</td><td>NUM</td><td>Mean value of tBodyGyroMag_mean</td><td>tBodyGyroMag_mean</td> </tr>
	<tr> <td>tBodyGyroMag_std_Mean</td><td>NUM</td><td>Mean value of tBodyGyroMag_std</td><td>tBodyGyroMag_std</td> </tr>
	<tr> <td>tBodyGyroJerkMag_mean_Mean</td><td>NUM</td><td>Mean value of tBodyGyroJerkMag_mean</td><td>tBodyGyroJerkMag_mean</td> </tr>
	<tr> <td>tBodyGyroJerkMag_std_Mean</td><td>NUM</td><td>Mean value of tBodyGyroJerkMag_std</td><td>tBodyGyroJerkMag_std</td> </tr>
	<tr> <td>fBodyAcc_std_X_Mean</td><td>NUM</td><td>Mean value of fBodyAcc_std_X</td><td>fBodyAcc_std_X</td> </tr>
	<tr> <td>fBodyAcc_std_Y_Mean</td><td>NUM</td><td>Mean value of fBodyAcc_std_Y</td><td>fBodyAcc_std_Y</td> </tr>
	<tr> <td>fBodyAcc_std_Z_Mean</td><td>NUM</td><td>Mean value of fBodyAcc_std_Z</td><td>fBodyAcc_std_Z</td> </tr>
	<tr> <td>fBodyAccJerk_std_X_Mean</td><td>NUM</td><td>Mean value of fBodyAccJerk_std_X</td><td>fBodyAccJerk_std_X</td> </tr>
	<tr> <td>fBodyAccJerk_std_Y_Mean</td><td>NUM</td><td>Mean value of fBodyAccJerk_std_Y</td><td>fBodyAccJerk_std_Y</td> </tr>
	<tr> <td>fBodyAccJerk_std_Z_Mean</td><td>NUM</td><td>Mean value of fBodyAccJerk_std_Z</td><td>fBodyAccJerk_std_Z</td> </tr>
	<tr> <td>fBodyGyro_std_X_Mean</td><td>NUM</td><td>Mean value of fBodyGyro_std_X</td><td>fBodyGyro_std_X</td> </tr>
	<tr> <td>fBodyGyro_std_Y_Mean</td><td>NUM</td><td>Mean value of fBodyGyro_std_Y</td><td>fBodyGyro_std_Y</td> </tr>
	<tr> <td>fBodyGyro_std_Z</_Meantd><td>NUM</td><td>Mean value of fBodyGyro_std_Z</td><td>fBodyGyro_std_Z</td> </tr>
	<tr> <td>fBodyAccMag_mean<_Mean/td><td>NUM</td><td>Mean value of fBodyAccMag_mean</td><td>fBodyAccMag_mean</td> </tr>
	<tr> <td>fBodyAccMag_std</_Meantd><td>NUM</td><td>Mean value of fBodyAccMag_std</td><td>fBodyAccMag_std</td> </tr>
	<tr> <td>fBodyBodyAccJerkM_Meanag_mean</td><td>NUM</td><td>Mean value of fBodyBodyAccJerkMag_mean</td><td>fBodyBodyAccJerkMag_mean</td> </tr>
	<tr> <td>fBodyBodyAccJerkM_Meanag_std</td><td>NUM</td><td>Mean value of fBodyBodyAccJerkMag_std</td><td>fBodyBodyAccJerkMag_std</td> </tr>
	<tr> <td>fBodyBodyGyroMag__Meanmean</td><td>NUM</td><td>Mean value of fBodyBodyGyroMag_mean</td><td>fBodyBodyGyroMag_mean</td> </tr>
	<tr> <td>fBodyBodyGyroMag__Meanstd</td><td>NUM</td><td>Mean value of fBodyBodyGyroMag_std</td><td>fBodyBodyGyroMag_std</td> </tr>
	<tr> <td>fBodyBodyGyroJerk_MeanMag_mean:</td><td>NUM</td><td>Mean value of fBodyBodyGyroJerkMag_mean:</td><td>fBodyBodyGyroJerkMag_mean:</td> </tr>
	<tr> <td>fBodyBodyGyroJerk_MeanMag_std</td><td>NUM</td><td>Mean value of fBodyBodyGyroJerkMag_std</td><td>fBodyBodyGyroJerkMag_std</td> </tr>
</table>

## Sources

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012)
