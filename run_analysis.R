# Getting and cleaning data course project
library(dplyr)
library(logging)
basicConfig(level = 'DEBUG')
setLevel('DEBUG')

# Setup
project.dir <- "~/src/jhu-data-science-course/get-clean-data"
setwd(project.dir)
source("../common/myutils.R")

# Handy paths
data.dir <- file.path(project.dir, "UCI HAR Dataset" )
data.train.dir <- file.path(data.dir, "train")
data.test.dir <- file.path(data.dir, "test")

DownloadDataset <- function(force = FALSE) {
  # Downloads and unzips dataset if not already downloaded.
  # Attempt to be idempotent. force  = TRUE will remove any traces of previous
  # downloads. then it will download and extract again.
  
  zip.file <- file.path(project.dir, sprintf("%s.zip", basename(data.dir)))
  data.url <- sprintf("https://d396qusza40orc.cloudfront.net/%s",
                      "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

  if (FALSE == force) {
    if (dir.exists(data.dir)) {
      stop(sprintf("Data dir: %s exists. %s",
                   "Remove it first or use force = TRUE", data.dir))
    }
  } else {
    loginfo("Warning, force parameter set to TRUE")
    myutils.FileRemoveIfExists(data.dir)
    myutils.FileRemoveIfExists(zip.file)
  }

  myutils.DownloadIfNeeded(data.url, 
                           destdir = project.dir, 
                           destfile = zip.file)  
  myutils.DownloadIfNeeded(zip.file)    
}

SanitizeFeatureLabel <- function(label) {
  # Part 4 of assignment: Appropriately labels the data set with
  # escriptive variable names.
  #
  # Function sanitizes Column Names. Column names as they
  # are, have multiple issues that violate tidy data rules
  
  label <- gsub("\\,", "_and_", # comma separating function params
                gsub("\\)", "", 
                     gsub("\\(", "_of_", # open paren as in function of
                          gsub("-", "_", # dash to underscore
                               gsub("\\(\\)|\\)", "", label) # remove parens
                          )
                     )
                )
  )
  label
}

GetDesiredColumnsIndexNameMap <- function(features.table) {
  # As per part 2 of assignment: Extracts only the measurements on
  # the mean and standard deviation for each measurement. 
  #
  # Takes the features table and extracts only the column names required
  # for the experiment. ie. columns meassuring means and sd's
  
  mean.std.index <- grep("_mean$|_std", features.table$feature, value = FALSE)
  mean.std.label <- features.table$feature[mean.std.index]
  mean.std.features <- data.frame(index = mean.std.index, 
                                  label = mean.std.label)
  mean.std.features
}

LoadXData <- function(file.name, ...) {
  # Load experiment X data. 
  # Returns a data.frame of Dim (2947x561) - for X_test.txt

  x <- read.csv(file.name,
                stringsAsFactors = FALSE, header = FALSE, 
                sep="", ...)
  tbl_df(x)
}

LoadYData <- function(file.name, ...) {
  # Loads experiment y data.  
  # The data is a vector with the id's for the activities performed.
  # There are 6 activities - WALKING, WALKING UPSTAIRS, etc.
  # Returns a data.frame of Dim (2947x1)

  read.csv(file.name,
           header = FALSE, col.names = c("activity.id"), 
           sep=" ", ...)
}

LoadSubjectsTable <- function(file.name, ...) {
  # Loads subjects data. 
  # A vector with an identifier of the participant associated
  # with X file measurements. 
  # Returns a data.frame of Dim (2947x1)

  read.csv(file.name,
           header = FALSE, col.names = c("subject.id"), 
           sep=" ", ...) 
}

LoadActivityLableTable <- function(...) {
  # Loads activity dataset. 
  # Returns a data.frame of Dim (6x2)
  logdebug("Running LoadActivityLableTable")
  activities <- read.csv(file.path(data.dir, "activity_labels.txt"),
                         header = FALSE, sep=" ",
                         col.names = c("activity.id", "activity.label"), ...)
  activities
}


LoadFeaturesTable <- function(...) {
  # Loads features.txt. A table that maps of feature id's to their names.
  # Sanitizes the table by cleaning up labels names.
  # Removes columns not require by spec.
  # Returns a data.frame of Dim (561x2)
  features.table <-  read.csv(file.path(data.dir, "features.txt"),
                              header = FALSE, 
                              col.names = c("id", "feature"), sep=" ", ...) 
  features.table <- mutate(features.table, 
                           feature = SanitizeFeatureLabel(feature))
}

LoadAndTidyDataSet <- function(data.set, 
                               features.table, 
                               activity.labels, ...) {
  # This function is the workhorse of the project.
  # @input: data.set - X_test or X_train
  #         features.table  - The features table data
  #         activity.labels - The activity labels data
  # @return: A tidy dataset with desired columns and labels.
  #
  # It does the following
  #  1. Loads X_data
  #  2. Selects desired columns
  #  2. Loads y_data
  #  4. Adds a column of activity labels to corresponding activity id
  #  3. Loads subjects table
  #  4. Sanitizes variable names (Col names)
  #  5. Loads and merges subject ids
  

  # Validate
  valid.data.sets <- c("test", "train") 
  if (!data.set %in% valid.data.sets) {
    stop(sprintf("Valid datasets are: %s", valid.data.sets))
  }

  data.dir = get(sprintf("data.%s.dir", data.set))  # Eval data.dir

  # Load X data set
  X_data <- LoadXData(file.path(data.dir, 
                                sprintf("X_%s.txt", data.set)), 
                      ...)
  
  # Select only columns that measure means and standard deviation 
  mean.std.features <- GetDesiredColumnsIndexNameMap(features.table)
  X_data <- select(X_data, mean.std.features$index)  # Select desired cols
  colnames(X_data) <- mean.std.features$label        # Apply labels to columns
  
  # Load y data set
  y_data <- LoadYData(file.path(data.dir,
                                sprintf("y_%s.txt", data.set)),
                      ...)

  # As per part 3 of the assignment: Uses descriptive activity names to
  # name the activities in the data set
  #
  # Add the activity label to the activity id vector. Will use the 'merge' 
  # function to join the two data sets. To deal with the 'merge' function
  # sideafecting row order, we will Add a numeric column with a unique
  # identifier of wach row. Basically, we add an index column.
  y_data <- cbind(index = 1:nrow(y_data), y_data)  # Add index column
  y_data <- merge(y_data, activity.labels,  # Do merge
                  by.x = "activity.id", by.y = "activity.id")
  y_data <- arrange(y_data, index)  # Re-order by original index
  y_data <- select(y_data, -index)  # Remove index column

  # Now that our y data is in good state, we cbind it to our X data.
  X_data <- cbind(y_data, X_data)

  # Load subjects table
  subjects.table <- LoadSubjectsTable(file.path(data.dir,
                                                sprintf("subject_%s.txt", 
                                                        data.set)),
                                      ...)
  # Add subject id column to the mix
  X_data <- cbind(subjects.table, X_data)
}


#### Main

# Prep some data
features.table <- LoadFeaturesTable()
activity.labels <- LoadActivityLableTable()

# Load data sets
X_test <- LoadAndTidyDataSet("test", 
                              features.table, 
                              activity.labels)

X_train <- LoadAndTidyDataSet("train", 
                              features.table, 
                              activity.labels)

# As per part 1 of the assignment: Merges the training and the test
# sets to create one data set.
X <- rbind(X_test, X_train)
X <- select(X, -activity.id)

# As per part 5 of the assignment: 
tidy <- arrange(aggregate(. ~ subject.id + activity.label,
                          data=X, FUN=mean, na.rm=TRUE), subject.id)

# Generate a file with tidy data
write.table(tidy, file="tidy_data.txt", row.name=FALSE)