Code Book for Course Assignment
---

### Original Dataset  

---

Link to the original data set is
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The files & folders of the raw (after unzipping) data used by the R code are  

* `UCI HAR Dataset` - the root folder  
* `train` - folder containing observations and measurements of training set  
* `test` - folder containing observations and measurements of test set  
* `README.txt` - explains how the original data was collected and detailed meaning of each file  
* `features_info.txt` - describes how the features were named
* `activity_labels.txt` - descriptions of the activities undertaken by volunteers  
* `features.txt` - list of each feature name measured/derived from the research  
* `X_train.txt` / `X_test.txt` - measurements file for training & test sets  
* `y_train.txt` / `y_test.txt` - activity file for training & test sets
* `subject_train.txt` / `subject_test.txt` - the volunteers code who recorded that row of features

---  

### Tidied Dataset Vectors  

---  

`Subject` - A number from 1 to 30 identifying the volunteer who carried out that particular row of measured data  

`Activity` - Which of the 6 activities the volunteer was carrying out.  1 = Walking, 2 = Walking Upstairs, 3 = Walking Downstairs, 4 = Sitting, 5 = Standing, 6 = Laying  

The 86 features that follow in the tidy data frame are mean values my R script has taken of all the original measurements for each 'Subject' doing this 'Activity'.

These feature names were given by the original reseachers and are explained in their `features_info.txt` file.  

Below is a summary of how to interpret the names of these additional features;  

Raw signals from the measuring equipment started with;  

'tAcc' - accelerometer 3-axial (x or y or z) raw signal  
'tGyro' - gyroscope 3-axial (x or y or z) raw signal  

All other features starting with;  

't' - measurements denoting time domain signals  
'f' - measurements denoting frequency domain signals (derived)  

Features containing the following words;  

'BodyAcc' - body acceleration signal, derived from the raw acceleration measurements  
'BodyAccJerk' - body linear acceleration, derived in time  
'BodyGyroJerk' - body linear angular velocity, derived in time  
'GravityAcc' - gravity acceleration signal, derived from the raw acceleration measurements  
'Mag' - magnitude of a signal, calculated using the Euclidean norm  

For all of the signals captured above the following additional calculations were peformed to increase the number of features;  

mean() - Mean value  
std() - Standard deviation  
angle() - Angle between two vectors.  Tidy data set only collects features of the original dataset where one or both the angles contains the word 'mean' or 'std'

Features ending with;  
'X' - measurements related to x-axis  
'Y' - measurements related to y-axis  
'Z' - measurements related to z-axis  