## -------- CLEANING & GETTING DATA COURSE ASSIGNMENT ---------

## R code to;
##   1. Merge the training and test sets
##   2. Extract only the mean & std dev measurements
##   3. Names activities in data set using descriptive nameS
##   4. Labels the merged data set with descriptive names
##   5. Creates the average of each of these named variables
##      in a seperate, tidy, data set

## ---------------------- LOAD LIBRARIES ----------------------
library(data.table)
library(dplyr)

## ------------------ DOWNLOAD DATA & UNZIP -------------------

## Navigate manually using setwd() to the required directory 
## to hold the data before running code below

## Check data doesn't already exist & download if it doesn't
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("UCI HAR Dataset")) {
    ## Don't have the file so download. It is a zip file 
    ## so need to downlaod the zip file, then unzip it
    download.file(fileURL,"zipfile", method="curl", quiet=TRUE)
    unzip("zipfile", overwrite=TRUE)
    
    ## Remove the zipfile
    file.remove("zipfile")
    
    ## Record date file downloaded in the new directory
    dateDownloaded <- date()
    write(dateDownloaded, file="UCI HAR Dataset/Download Date.txt")
}

## File URL no longer needed so remove
rm(fileURL)

## -------------- READ IN TRAIN & TEST TEXT FILES -------------
## --------------- & THE SUBJECT FILES FOR BOTH ---------------
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
testData <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)

## --------- MERGE TRAIN, TEST & SUBJECT TEXT FILES -----------

## Put results into a new data frame by appending rows
mergeData <- rbind(trainData,testData)

## Remove train & test data from memory
rm(trainData, testData)

## ----- EXTRACT ONLY MEAN & STD DEV FOR EACH MEASUREMENT -----
## ------ WHICH ALSO COMPLETES STEP 4, LABEL THE COLUMNS ------
## ------------- WITH DESCRIPTIVE VARIABLE NAMES --------------

## Get the variable names from the features.txt file
varNames <- read.table("UCI HAR Dataset/features.txt", header=FALSE,
                       stringsAsFactors=FALSE)

## Assign the variable names to the merged data frame
setnames(mergeData, colnames(mergeData), varNames[,2])

## Use grep function to give index positions of all columns
## containing "mean" and "std".  Then join the two index vectors
## and filter the mergeData by this filter
meanFil <- grep("mean", colnames(mergeData), ignore.case=TRUE, value=FALSE)
stdFil <- grep("std", colnames(mergeData), ignore.case=TRUE, value=FALSE)
filter <- c(meanFil, stdFil)
stdMeanDf <- mergeData[,filter]

## remove vectors no longer needed
rm(meanFil, stdFil, filter, mergeData, varNames)

## -------- MATCH ACTIVITY TO EACH ROW OF MERGED DATA ---------
## ------ USE DESCRIPTIVE NAMES TO NAME THE ACTIVITIES --------

## Read in the activities from y_train and x_train files
actTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE,
                       stringsAsFactors=FALSE)
actTest <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE,
                      stringsAsFactors=FALSE)

## Combine the Activity first
Activity <- rbind(actTrain, actTest)

## Now turn these numbers into descriptions
## These are from activity_labels.txt
Activity[Activity==1] <- "Walking"
Activity[Activity==2] <- "Walking Upstairs"
Activity[Activity==3] <- "Walking Downstairs"
Activity[Activity==4] <- "Sitting"
Activity[Activity==5] <- "Standing"
Activity[Activity==6] <- "Laying"

## Now add this as a column to the merged data
stdMeanDf <- cbind(Activity, stdMeanDf)
setnames(stdMeanDf, 1,"Activity")

## And add the Subject column
subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt",
                       header=FALSE)
subTest <- read.table("UCI HAR Dataset/test/subject_test.txt",
                      header=FALSE)

mergeSub <- rbind(subTrain, subTest)
stdMeanDf <- cbind(mergeSub, stdMeanDf)
setnames(stdMeanDf, 1, "Subject")

## Remove vectors no longer needed
rm(actTrain, actTest, Activity, mergeSub,  subTest, subTrain)

## ----- CREATE THE AVERAGE OF EACH OF THESE VARIABLES -----
## ------------- IN A SEPERATE TIDY DATA FRAME -------------

## Use the chain method %>% to group by 
## Subject and ActivityExtract the mean for each feature
tidyDf <- stdMeanDf %>%
            tbl_df %>%
                group_by(Subject, Activity) %>%
                    summarise_each(funs(mean))

## Remove the stdMeanDf as no longer needed
rm(stdMeanDf)

## tbl <- tbl_df(stdMeanDf)
## by_Grp <- group_by(tbl, Subject, Activity)
## grouped by Subject by Activity
## tidyDf <- summarise_each(by_Grp, funs(mean))

## ---------- WRITE THE TIDY DF TO A TEXT FILE ------------

write.table(tidyDf, "tidydata.txt", row.name=FALSE)

## Can be read back in using
## x<-read.table("tidydata.txt",header=TRUE, stringsAsFactors=FALSE)