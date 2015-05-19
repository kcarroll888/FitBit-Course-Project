Code Book for Course Assignment
---

### Original Dataset  

---

Link to the original data set is
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The files & folders used by the R code once they're unzipped are  

* `UCI HAR Dataset` - the root folder  
* `train` - folder containing observations and measurements of training set  
* `test` - folder containing observations and measurements of test set  
* `README.txt` - explains how the original data was collected and detailed meaning of each file  
* `features_info.txt` - describes 
* `activity_labels.txt` - descriptions of the activities undertaken by volunteers  
* `features.txt` - list of each feature name measured/derived from the research  
* `X_train.txt` / `X_test.txt` - measurements file for training & test sets  
* `y_train.txt` / `y_test.txt` - activity file for training & test sets
* `subject_train.txt` / `subject_test.txt` - the volunteers code who recorded that row of features

---  

### Tidyied Dataset Vectors  

---  

`Subject` - A number from 1 to 30 identifying the volunteer who carried out that particular row of measured data  

`Activity` - Which of the 6 activities the volunteer was carrying out.  1 = Walking, 2 = Walking Upstairs, 3 = Walking Downstairs, 4 = Sitting, 5 = Standing, 6 = Laying  

Next follows 86 features where the R script has taken the average value of the observations for this 'Subject' doing this 'Activity'. These feature names were given by the original reseachers and are explained in their `features_info.txt` file.  

As a summary.  Features starting with; 

't' - measure denote time signals
'f' - measure frequency signals
'BodyAcc' - acceleration measurements from the accelerometer
'GyroAcc' - acceleration measurements from the gyroscope


Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)