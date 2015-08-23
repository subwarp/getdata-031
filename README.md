# getdata-031

##Technical Specification


Using the [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), Create a R script called run_analysis.R that does the following:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Strategy
We were given two different data sets with and were asked to merge, process and tidy the dataset and finally producing a new dataset.
My strategy was abstract the code that reads, sanitizes and applies statistics to the datasets..

##Functions

There are a number of helper functions that isolate code for loading, sanitizing, selecting columns based on patterns. The two most interesting functions are LoadAndTidyDataSet() and MakeTidy().

Note: there are comments in the code that identify what part of the Technical Specification is being addressed. Those areas are tagged with the string "As per part".

####LoadAndTidyDataSet()
The LoadAndTidyDataSet() function does much of the heavy lifting. One of its arguments is data.set and it can take either "train" or "test". It will then figure out what files need to be loaded and merged. This simplified things during development since we could work with only the training set during development. Once the code was working end to end, we can call LoadAndTidyDataSet() twice. Once for the training dataset and once for the test dataset. Then we simply rbind the two sets for the complete dataset.

####MakeTidy()
This is the main method and interface to the script. This method is in charge of loading a few generic datasets like the features table and activity labels. It is here where I call LoadAndTidyDataSet() for each training and testing datasets. It rbind's the two datasets and applies the mean function across all variables aggregate by subject id and activity.


## Running
1. Clone this repo.
2. Download dataset from the location provided in the project page.
3. Extract zip archive into folder "UCI HAR Dataset" under the root folder where you cloned this repo.
4. Start R.
5. Set working directory accordingly. Open up run_analysis.R and modify the project.dir variable on line 15 to the location where you cloned this repo.
4. Source("run_analysis.R")
5. Call MakeTidy()
6. Find output file 'tidy_data.txt' in the same directory where run_analysis.R is located. 
