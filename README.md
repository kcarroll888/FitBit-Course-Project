
This repo contains my code and documentation for the course project for the Getting & Cleaning Data module of the John Hopkins Bloomberg Data Science MOOC.

---

###Contents

---

`README.md` - This file explaining the repo contents

`run_analysis.R` - R code which reads the data from the source and unzips it to the local directory.  It then performs the steps as set out in the assignment  

1. Merges the training and the test sets to create one data set  
2. Extracts only the measurements on the mean and standard deviation for each measurement  
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

`CodeBook.md` - Explains the variables, data and transformations carried out in the R code

###R Script - Steps Taken & Why

---  
The R code which transforms the data is held in the file `run_analysis.R`  

The steps this R code takes to transform the original data are as follows;

__DOWNLOAD DATA__  

* Check if the data is available locally by checking if the unzipped folder `UCI HAR Dataset` already exists  
* If it doesn't exist it is downloaded from (<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>) and unzipped  
* For future reference writes a timestamp file to unzipped directory for when the data was downloaded called `Download Date.txt`

__1. MERGING THE TRAIN & TEST DATA SETS__  
The measurement data was split by the researchers into two files `x_train` and `x_test`. The code reads them into two separate dataframes and combines them into a single dataframe using the `rbind()` function.  The order which they're combined is;  

1. Training Data 2. Test Data  

__2. EXTRACT ONLY MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT__  
The R code reads in the `features.txt` file in order to assign meaningful feature names to the merged feature data of the previous step. `stringsAsFactors=FALSE` option is set to FALSE since do not want resulting strings to be factors types.

**These meaningful feature names are required in step 4 but are useful here as they describe the features which are "means" and those that are "std" (standard deviations).**

The feature names are assigned to the merged dataframe using `setnames()`. Note that when the file is read there are two variables in the resulting dataframe, a row index variable (not needed) and the variable names.  Only the variable names are selected using `varNames[,2]`.

The `grep()` function is used twice on the merged dataframe from step 1. First to return vectors which show the column numbers of all column names containing the word `mean` then to search columns for the word `std`.  

Looking at the `features.txt` file manually the feature names looked as though all mentions of `mean` and `std` in the feature names were lower case, but to be sure the search is not case sensitive.

These two resulting filter vectors are combined and applied to the merged data set to produce a data set which contains only the features containing the words `mean` or `std`.  The result is stored in dataframe called `stdMeanDf`.

__3. MATCH THE ACTIVITY TO THE ACTION ON EACH ROW OF DATA__  
The assignment asked for a descriptive name for the activities (currently a number from 1 through to 6) and fortunately this was provided by the researchers in the `activity_label.txt` file.

The numbers corresponded to activities as below;  

1 = Walking  
2 = Walking Upstairs  
3 = Walking Downstairs  
4 = Sitting  
5 = Standing  
6 = Laying  

Before these labels could be applied the numeric activity information was read into two data frames from `y_train.txt` and `y_test.txt` files.  These files were combined to a single activity data frame.

The numbers in the merged activity data frame were then replaced by the more interpretable descriptions. The final activity data frame is added as a column (at the start) to the `stdMeanDf`.

The volunteers who carried out the tests (from which the measurements are derived) is read in from the files `y_train` and `y_test` and combined (in the same order as the test data).

These two files are merged and then also added to the `stdMeanDf` as a column.

The result in `stdMeanDf` with the following columns;  

* `Subject` - The number from 1 to 30 of the volunteer from which the row of measurements were taken  
* `Activity` - The activity the volunteer carried out. One of six of "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing" and "Laying"  
* 86 other features from the measurements which have in their description either the word `mean` or the word `std`  

__4. APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES__  
Appropriate label names were assigned to the data frame in step 2.

__5. CREATE AN INDEPENDENT DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT__  
At this stage the R code has created a single data frame `stdMeanDf` with 10299 observations of 88 variables.

Using the `summarise_each()` function in the dplyr package to applt the `mean()` function to each row of the `stdMeanDf` generates a tidy dataframecalled `tidyDf`.

Tidy being defined as each variable measured (average of each feature) is in a seperate column and each observation of that variable being on a different row.

The final step is to write the dataframe to the current working directory as a file called `tidydata.txt`.

This can be read back into R using `x <- read.table("tidydata.txt", header=TRUE, stringsAsFactors=FALSE)`