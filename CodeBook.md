-------------
Code Book
-------------

   This code book will describe the data used in this project, as well as the processing required to create the resulting tidy data set.

----------
Overview
----------

 30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various data about their movements.

 The script generates a combined subset of the original data by extracting the mean and standard deviation features for each of the 33 processed signals, for a total of 66 features (out of the 561 available features from the original feature vector). This combined subset contains 10299 observations of 68 variables, with activity and subject appended to the 66 features.

 The combined subset is further reduced by calculating the mean of the observations by activity and subject pair to generate 180 observations (6 activities * 30 subjects) of the same 68 variables.
  It  is saved as a text file in the current working directory with the name  <strong> tidyDataset.txt <strong>


-------------------------
Explanation of each file
-------------------------

` features.txt: Names of the 561 features.`

` activity_labels.txt: Names and IDs for each of the 6 activities.`

` X_train.txt: 7352 observations of the 561 features, for 21 of the 30 volunteers.`

` subject_train.txt: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in X_train.txt.`

` y_train.txt: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in X_train.txt.`

` X_test.txt: 2947 observations of the 561 features, for 9 of the 30 volunteers.`

` subject_test.txt: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in X_test.txt.`

` y_test.txt: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in X_test.txt.`

More information about the files is available in ` README.txt.`

More information about the features is available in ` features_info.txt.`

-------------------------------
Data files that were not used
--------------------------------

This analysis was performed using only the files above, and did not use the raw signal data. Therefore, the data files in the ` Inertial Signals ` folders were ignored.

------------------
Processing steps
------------------

1.  Gathering/Getting Raw data
---------------------------------

The relevant data files were read into the below data frames, appropriate column headers were added, and the training and test sets were combined into a single data set.


*   ` s_train  `      	data.frame of training Volunteer/Subject ID data  

*   ` s_test  `      		data.frame of test  Volunteer/Subject ID data  

*   ` SubjectID `        	column header for Volunteer ID from 1-30  

*   ` S_merged `   	data.frame of combined training and test data  (10299 obs. of 1 variable)  using  ` rbind() `   




+  `  y_train `      		data.frame of training Activity ID data  

+   ` y_test  `     		data.frame of test  Activity ID data    

+   ` Activity `		column header for  Activity Labels from 1-6    

+   ` Y_merged `   	data.frame of combined training and test data (10299 obs. of 1 variable)   using  ` rbind() `




*   ` X_train `      		data.frame of training sensor data  

*   ` X_test  `      	data.frame of test sensor data  

*   ` X_merged `  	 	data.frame of combined training and test data (10299 obs. of 561 variables)  using  ` rbind() `
  




*  ` C_Merged `    	data.frame of combined training and test data  (10299 obs. of 563 variables)  using  ` cbind() `

*  ` F_features ` 		data.frame of features data (561 obs. of 2 variables)

*  ` A_labels `          	data.frame of activity labels data (6 obs. of 2 variables)




2.  Processing/Transforming
--------------------------

 `  Extraction : `
 
  All feature columns were removed that did not contain the exact string "mean()" or "std()" using ` grep() `.
  So after this transformation, only 66 feature columns (33 for mean and 33 for std) were extracted from the original 561 columns.
  Alongwith these 66 columns we have the SubjectID and Activity columns ie total of 68 columns.

*   ` F_extract ` 	vector containing the indices of the 66 columns with the exact string "mean()" or "std()"

 `   c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542, 543) `


`   Renaming : `
   
  Renamed these 66 columns with descriptive names from the F_features data.frame using  ` colnames() `

`   Replacing : `
 
  Replaced the paranthesis,text string "BodyBody" with "" and "Body" respectively using ` gsub() `

`  Conversion : `
 
  The Activity column was converted from a integer to a factor, using labels describing the activities with the ` factor() `.



3.  First Independent Dataset in wide format 
--------------------------------------------

*  `  T_cleaned `	dataset  obtained by combining the data.frames after all the above transformations (10299 obs. of 68 variables) using  ` cbind() `



4.   Tidying/Cleaning
----------------------

A  2nd independent tidy data set was created containing the "mean of each feature for each subject and each activity" using 
the ` melt()` and `dcast()` from the ` reshape2` package.

 *  ` melted  `	data.frame obtained by melting the T_cleaned dataset  (679734 obs. of 4 variables) using ` melt() `


5.  Second Independent Dataset in wide format
-----------------------------------------------

 *  ` tidy	 `	data.frame with the computed means (180 obs. of 68 variables)  using ` dcast() `
 
Thus, subject #1 has 6 rows in the tidy data set (one row for each activity), and each row contains the mean value for 
each of the 66 features for that subject/activity combination. Since there are 30 subjects, there are a total of 180 rows.

6.  List of all the Variables  present in "tidyDataset" 
-----------------------------------------------------

#####  ID Variables(2 columns)
 
  * ` SubjectID ` - The volunteer ID (1-30)

  * ` Activity  `  - The label of the activity performed when the corresponding measurements were taken (1-6)

  Activity Labels

 *  ` WALKING  ` (value 1)

 *  ` WALKING_UPSTAIRS ` (value 2)  

 * ` WALKING_DOWNSTAIRS` (value 3)  

 * ` SITTING `(value 4)  

 * ` STANDING ` (value 5)  

 * ` LAYING ` (value 6)



#####  Feature Variables (66 columns)

  Codes

          (1)  `t`     	: denotes time  

          (2)  `f`      : denotes frequency  

          (3)  `Acc`  : denotes Accelerometer  

          (4) `mean` : Mean value  

          (5) `std`   	: Standard deviation  

          (6) `Mag `  : Magnitude  

          (7) `Gyro `	: Gyroscope  

          (8) `X`     	: X direction  

          (9) `Y`     	: Y direction  

          (10) `Z`   	: Z direction


 *  ` tBodyAcc-mean-X `(column 1)

 *   ` tBodyAcc-mean-Y ` (column 2)

 *  `  tBodyAcc-mean-Z ` (column 3)

 *   ` tBodyAcc-std-X `(column 4)

 *   ` tBodyAcc-std-Y ` (column 5)

 *   ` tBodyAcc-std-Z `(column 6)

 *   ` tGravityAcc-mean-X `(column 41)

 *   ` tGravityAcc-mean-Y `(column 42)

 *   ` tGravityAcc-mean-Z` (column 43)

 *  `  tGravityAcc-std-X `(column 44)

 *   ` tGravityAcc-std-Y `(column 45)

 *   ` tGravityAcc-std-Z `(column 46)

 *  ` tBodyAccJerk-mean-X `(column 81)

 *   ` tBodyAccJerk-mean-Y ` (column 82)

 *  ` tBodyAccJerk-mean-Z `(column 83)

 *   ` tBodyAccJerk-std-X `(column 84)

 *   ` tBodyAccJerk-std-Y `(column 85)

 *  ` tBodyAccJerk-std-Z `(column 86)

 *   ` tBodyGyro-mean-X ` (column 121)

 *   ` tBodyGyro-mean-Y ` (column 122)

 *  ` tBodyGyro-mean-Z `(column 123)

 *   ` tBodyGyro-std-X` (column 124)

 *   ` tBodyGyro-std-Y `(column 125)

 *   ` tBodyGyro-std-Z `(column 126)

 *   ` tBodyGyroJerk-mean-X` (column 161)

 *   ` tBodyGyroJerk-mean-Y `(column 162)

 *   ` tBodyGyroJerk-mean-Z` (column 163)

 *   ` tBodyGyroJerk-std-X `(column 164)

 *   ` tBodyGyroJerk-std-Y `(column 165)

 *   ` tBodyGyroJerk-std-Z` (column 166)

 *   ` tBodyAccMag-mean` (column 201)

 *   ` tBodyAccMag-std` (column 202)

 *   ` tGravityAccMag-mean `(column 214)

 *   ` tGravityAccMag-std `(column 215)

 *   ` tBodyAccJerkMag-mean` (column 227)

 *   ` tBodyAccJerkMag-std` (column 228)

 *   ` tBodyGyroMag-mean` (column 240)

 *   ` tBodyGyroMag-std `(column 241)

 *   ` tBodyGyroJerkMag-mean `(column 253)

 *   ` tBodyGyroJerkMag-std ` (column 254)

 *   ` fBodyAcc-mean-X `(column 266)

 *  ` fBodyAcc-mean-Y `(column 267)

 *  ` fBodyAcc-mean-Z `(column 268)

 *   ` fBodyAcc-std-X `(column 269)

 *  `  fBodyAcc-std-Y` (column 270)

 *   `  fBodyAcc-std-Z` (column 271)

 *  ` fBodyAccJerk-mean-X ` (column 345)

 *   `  fBodyAccJerk-mean-Y `(column 346)

 *   ` fBodyAccJerk-mean-Z `(column 347)

 *   `  fBodyAccJerk-std-X` (column 348)

 *   `fBodyAccJerk-std-Y ` (column 349)

 *  ` fBodyAccJerk-std-Z `(column 350)

 *   ` fBodyGyro-mean-X `(column 424)

 *  ` fBodyGyro-mean-Y `(column 425)

 *  `  fBodyGyro-mean-Z `(column 426)

 *  `  fBodyGyro-std-X` (column 427)

 *  ` fBodyGyro-std-Y` (column 428)

 *  ` fBodyGyro-std-Z `(column 429)

 *   ` fBodyAccMag-mean` (column 503)

 *  ` fBodyAccMag-std `(column 504)

 *  ` fBodyAccJerkMag-mean ` (column 516)

 *   ` fBodyAccJerkMag-std ` (column 517)

 *   `  fBodyGyroMag-mean `(column 529)

 *  `  fBodyGyroMag-std `(column 530)

 *   ` fBodyGyroJerkMag-mean` (column 542)

 *   `fBodyGyroJerkMag-std `(column 543)




7. Writing the output to a  text file
------------------------------------

The tidy data set was written into  a "tidyDataset.txt" file separated by tabs.

*  ` tidyDataset.txt `   text file containing the computed means data from the 2nd tidy dataset in wide format
                                (180 obs. of 68 variables) using
                                `  write.file("tidyDataset.txt",sep = "\t",row.name = FALSE) `


8. References
--------------

*  ` Tidy Data  by Hadley Wickham` http://vita.had.co.nz/papers/tidy-data.pdf

* ` Link to HAR original paper ` http://www.icephd.org/sites/default/files/IWAAL2012.pdf

*  ` Course Project FAQ  by David Hood,CTA` https://class.coursera.org/getdata-012/forum/thread?thread_id=9

* ` Tidy Data and the Assignment  by David Hood,CTA`: https://class.coursera.org/getdata-012/forum/thread?thread_id=234
