## Getting and Cleaning Data   
 
## Peer Assessment - Analysis of the UCI HAR "(Human Activity Recognition) Using Smartphones" Dataset
----------------------------------------------------------------------------------------------

   This repo explains about how the analysis of the UCI HAR Dataset was performed to convert from a raw to a tidy dataset form.  


---------------- 
Introduction
----------------

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy Smartphone. 


---------------
Purpose
---------------

The purpose of this Course Project is to demonstrate your ability to collect, work with, and clean a data set ie in other words,to read in the "Human Activity Recognition Using Smartphones" data set, perform an analysis on the data set, and output a clean tidy data set.

The final goal is to prepare this tidy data that can be used for later analysis.


------------------------
Dataset : "UCI HAR"
------------------------

  	A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

	Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


----------------------------------------
Instructions for Performing the Analysis
----------------------------------------

Create a R script that does the following

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


-----------------------------------------------
Steps for how to run the "run_analysis.R" script
-----------------------------------------------
  

1. Download the zip file from the foll URL : "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "

2. Unzip the file into a folder on your local drive,for eg: 

   ` "C:/Users/yourname/Desktop/" `


3. Save "run_analysis.R" script file in your current working directory like:

   ` "C:/Users/yourname/Desktop/G/UCI HAR Dataset/" `

4. Move ALL of the following files to the SAME DIRECTORY as the R script:

	features.txt  
	activity_labels.txt  
	subject_train.txt  
	subject_test.txt  
	X_train.txt  
	X_test.txt  
	y_train.txt  
	y_test.txt  

5.  Install and load the required  "reshape2 package" from CRAN.
      
   `install.packages("reshape2")`  
   `library(reshape2)`
    

6.  In RStudio or R Console,type the foll at the command prompt,to run the R script(run_analysis.R) file: 

       `setwd("C:/Users/yourname/Desktop/G/UCI HAR Dataset/")`    
       `source("run_analysis.R")`

7.  In RStudio or R Console,to view the output of the R script [tidyDataset.txt](https://github.com/spadamati/GetCleanData/blob/master/tidyDataset.txt),type the foll commands:

      ` tidy <- read.table("tidyDataset.txt",header=TRUE)`   
      ` dim(tidy)`  
       `View(tidy)`

 It is 180x68 because there are 30 subjects and 6 activities,ie "for each activity and each subject" means 30 * 6 = 180 rows.
There are 68 columns ie 66  for different measures ie. means and standard deviations and  2 more columns,one each for the "SubjectID" and "Activity".


-----------------
CodeBook
-----------------

 The "CodeBook.md" describes about the variables,the data,the transformations/processing and the cleanup that was done on the dataset to get the final tidy dataset "tidyDataset.txt" which can be used for further analysis.  
 You can read more about it in [CodeBook.md](https://github.com/spadamati/GetCleanData/blob/master/CodeBook.md)


