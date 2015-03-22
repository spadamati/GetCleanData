## =========================== =================    ===================================================================================
## Getting and Cleaning Data:  Peer Assessment 1 -- Analysis of the UCI HAR "(Human Activity Recognition) Using Smartphones" Dataset
## =========================== =================    ===================================================================================


## ***********************************************************************************************************************

# Task 1: Collect,Work with and Clean the UCI HAR Dataset.
# Task 2: Prepare Tidy Dataset that can be used for later analysis.
# Task 3: Submit the link for Github URL with the repo containing the foll:
#          (1) "README.md" file,
#          (2) "CodeBook.md" file
#          (3) "run_analysis.R" script file 
#          (4) "tidyDataset.txt" file

## ***********************************************************************************************************************

## -------------------------------------------------------------------------------------------------------------------------------
##  Step 1: Instructions for Downloading and Unzipping the dataset file into R
## -------------------------------------------------------------------------------------------------------------------------------

# If the dataset file does not exists, then download and unzip the "UCI HAR Dataset" to your working directory.
# Please follow the below code only if you have not downloaded and unzipped the file to your working directory.
# Otherwise,skip this Step 1 and proceed directly to Step 2.


# library(util)
# if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
#   
#   tmp <- tempfile()#create name for the temporary destination file
#   
#   download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile =tmp,mode ="wb")
#   #Note: use method = "curl" for Mac 
#   
#   file <- unzip(tmp)#extracting the zipped file 
#   
#   unlink(tmp) #delete the tmp file
# }


## -------------------------------------------------------------------------------------------------------------------------------
##   Step 2: Reading the data from the UCI HAR Dataset folder
## -------------------------------------------------------------------------------------------------------------------------------

## -------------------------------------------------------------------------------------------------------------------------------
## Install and load the reshape2 package ..it will be reqd for Question 5
## -------------------------------------------------------------------------------------------------------------------------------    
install.packages("reshape2")
library(reshape2)

## -----------------------------------------------------------------------------
##  Question 1: Merges the training and the test sets to create one data set.
## -----------------------------------------------------------------------------

## --------------------------------------------
## (A) Read/Process the files for "Subjects" 
##     identifies the subject number from 1-30
## ---------------------------------------------

s_train <- read.table( "train/subject_train.txt", sep="",col.names ="SubjectID") 
s_test <- read.table(  "test/subject_test.txt", sep="",col.names="SubjectID") 

# Merge the train and test datasets
S_merged <- rbind(s_train, s_test)


## --------------------------------------------
## (B) Read/Process the files for "Activity"
##    identifies the activity type from 1-6
## --------------------------------------------

y_train <- read.table( "train/y_train.txt", sep="",col.names="Activity") 
y_test <-  read.table( "test/y_test.txt", sep="",col.names="Activity") 

# Merge the train and test datasets
Y_merged <- rbind(y_train, y_test)

## -------------------------------------------------
## (C) Read/Process the files for "Measures"
##     contains the measurements data
## -------------------------------------------------

X_train <- read.table( "train/X_train.txt", sep="") 
X_test <-  read.table( "test/X_test.txt", sep="") 

# Merge the train and test datasets

X_merged <- rbind(X_train, X_test)


## ----------------------------------------------------
## (D) Check the structure of these merged dataframes  
## ----------------------------------------------------


##............
## "S_merged" 
##............

dim(S_merged)
# > dim(S_merged)
# [1] 10299     1

#---dim(s_train) 7352 rows / 1 column 
#---dim(s_test)  2947 rows / 1 column 
#---dim(S_merged) 10299(7352+2947) rows / 1 column 

str(S_merged)
# >     str(S_merged)
# 'data.frame':    10299 obs. of  1 variable:
#  $ SubjectID: int  1 1 1 1 1 1 1 1 1 1 ...

head(S_merged)
# > head(S_merged)
#     SubjectID
# 1         1
# 2         1
# 3         1
# 4         1
# 5         1
# 6         1

##............
## "Y_merged"
##............

dim(Y_merged)
# > dim(Y_merged)
# [1] 10299     1
#---dim(y_train) 7352 rows / 1 column 
#---dim(y_test)  2947 rows / 1 column 
#---dim(_merged) 10299(7352+2947) rows / 1 column 

str(Y_merged)
# > str(Y_merged)
# 'data.frame':    10299 obs. of  1 variable:
#  $ Activity: int  5 5 5 5 5 5 5 5 5 5 ...

head(Y_merged)
# > head(Y_merged)
# Activity
# 1 STANDING
# 2 STANDING
# 3 STANDING
# 4 STANDING
# 5 STANDING
# 6 STANDING

##............
## "X_merged"
##............

dim(X_merged)
# > dim(X_merged)
# [1] 10299     561
#---dim(x_train) 7352 rows / 561 column 
#---dim(x_test)  2947 rows / 561 column 
#---dim(X_merged)10299(7352+2947) rows / 561 column 

str(X_merged)
# > str(X_merged)
# 'data.frame':    10299 obs. of  561 variables:
# $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
# $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
# $ V6  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
# $ V7  : num  -0.995 -0.999 -0.997 -0.997 -0.998 ...
# $ V8  : num  -0.983 -0.975 -0.964 -0.983 -0.98 ...
# $ V9  : num  -0.924 -0.958 -0.977 -0.989 -0.99 ...
# $ V10 : num  -0.935 -0.943 -0.939 -0.939 -0.942 ..

head(X_merged)

## -----------------------------------------------------------------------------
## (E) Finally,combine the merged_datasets(S_,Y_,X_) together into a single dataset
## -----------------------------------------------------------------------------

C_Merged <- cbind(S_merged, Y_merged, X_merged)



## -----------------------------------------------------------
## (F) Check the structure of the combined merged dataframe  
## ----------------------------------------------------------

dim(C_Merged) # 10299 rows/563 cols
# > dim(C_Merged) 
# [1] 10299   563

str(C_Merged) 
# > str(C_Merged)
# 'data.frame':    10299 obs. of  563 variables:
#     $ SubjectID: int  1 1 1 1 1 1 1 1 1 1 ...
# $ Activity : int  5 5 5 5 5 5 5 5 5 5 ...
# $ V1       : num  0.289 0.278 0.28 0.279 0.277 ...
# $ V2       : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ V3       : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ V4       : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ V5       : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...

head(C_Merged)



##------------------------------------------------------------------------------
## 
## Note: This "C_Merged" dataset needs more processing ie cleaning up since cols 
## names(V1....V561) are not descriptive and intutive. 
##
##------------------------------------------------------------------------------

## -----------------------------------------------------------------------------
##  Question 2: Extracts only the measurements on the mean and standard 
##               deviation for each measurement.
## -----------------------------------------------------------------------------

## -------------------------------------------------
## (A) Read the file for "features" 
## -------------------------------------------------

F_features <- read.table("features.txt")

## -------------------------------------------------
## (B) Check the structure of the dataframe 
## -------------------------------------------------

dim(F_features) #561 rows/2 cols
# > dim(F_features)
# [1] 561   2

str(F_features) 
# > str(F_features)
# 'data.frame':    561 obs. of  2 variables:
# $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
# $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 
# 243 244 245 250 251 252 237 238 239 240 ...

head(F_features)
# > head(F_features)
#   V1      V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y
# 3  3 tBodyAcc-mean()-Z
# 4  4  tBodyAcc-std()-X
# 5  5  tBodyAcc-std()-Y
# 6  6  tBodyAcc-std()-Z

## -------------------------------------------------
## (C) Extract the features that contain: 
##    (1) -mean()-X; -mean()-Y; -mean()-Z; -mean();
##    (2) -std()-X; -std()-Y; -std()-Z; -std() 
## -------------------------------------------------

F_extract  <- grep("-mean\\(\\)|-std\\(\\)", F_features[, 2])

# F_extract gives the indices for  66 cols after transformation. 
# We have (33 cols for mean and 33 cols  for std)
# [1]   1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86 121 122 123 124
#[23] 125 126 161 162 163 164 165 166 201 202 214 215 227 228 240 241 253 254 266 267 268 269
#[45] 270 271 345 346 347 348 349 350 424 425 426 427 428 429 503 504 516 517 529 530 542 543
 

##------------------------------------------------------------------------------
## (D) Removing the unnecessary cols,keep only the cols having mean, std, 
##     SubjectID and Activity
## -----------------------------------------------------------------------------

X_merged <- X_merged[,F_extract]


## -----------------------------------------------------------------------------
## (E) Check the structure of the dataframe after the transformation process
## -----------------------------------------------------------------------------

dim(X_merged)
# > dim(X_merged)
# [1] 10299    66

head(X_merged)


## -----------------------------------------------------------------------------
## (F) Rename these 66 col names to be more descriptive
## -----------------------------------------------------------------------------

colnames(X_merged) <- F_features[F_extract, 2]

#> colnames(X_merged) just a portion of it

#[1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z" 
#[64] "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"

## -----------------------------------------------------------------------------
## (G) Replace the paranthesis,text "BodyBody" in these 66 col names 
## -----------------------------------------------------------------------------

colnames(X_merged) <- gsub("\\(|\\)", "", colnames(X_merged))
colnames(X_merged) <- gsub("BodyBody", "Body", colnames(X_merged))

# colnames(X_merged)
#[1] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z" 
#[64] "fBodyGyroMag-std"      "fBodyGyroJerkMag-mean" "fBodyGyroJerkMag-std"

X_merged

## -----------------------------------------------------------------------------
## (H) Check the structure of the X_merged dataframe after the processing is done.
## -----------------------------------------------------------------------------

dim(X_merged)
# > dim(X_merged)
# [1] 10299    66

str(X_merged)
# > str(X_merged)
# 'data.frame':    10299 obs. of  66 variables:
# $ tBodyAcc-mean-X       : num  0.289 0.278 0.28 0.279 0.277 ...
# $ tBodyAcc-mean-Y       : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ tBodyAcc-mean-Z       : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...

head(X_merged)

## -------------------------------------------------------------------------------------------------------------------------------
##  Question 3: Uses descriptive activity names to name the activities in the data set.
## -------------------------------------------------------------------------------------------------------------------------------

## -------------------------------------------------
## (A) Read/Process the file for "activitylabels" 
## -------------------------------------------------

A_labels <- read.table("activity_labels.txt")

## ----------------------------------------------------
## (B) Check the structure of the "A_labels" dataframe  
## ----------------------------------------------------

dim(A_labels) # 6 rows/2 cols
# > dim(A_labels)
# [1] 6 2

str(A_labels)
# > str(A_labels)
# 'data.frame':    6 obs. of  2 variables:
# $ V1: int  1 2 3 4 5 6
# $ V2: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1

head(A_labels)
# > head(A_labels)
#   V1       V2
# 1  1            WALKING
# 2  2   WALKING_UPSTAIRS
# 3  3 WALKING_DOWNSTAIRS
# 4  4            SITTING
# 5  5           STANDING
# 6  6             LAYING
 

## -------------------------------------------------
## (C) Converting from integer to factor type
## -------------------------------------------------

Y_merged$Activity <- factor(Y_merged$Activity, labels = A_labels$V2)

# > head(Y_merged$Activity)
# [1] STANDING STANDING STANDING STANDING STANDING STANDING
# Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING

#dim(Y_merged) # 10299 obs/1 var
# > dim(Y_merged)
# [1] 10299     1

#head(Y_merged)
# > head(Y_merged)
#   Activity
# 1 STANDING
# 2 STANDING
# 3 STANDING
# 4 STANDING
# 5 STANDING
# 6 STANDING


## -------------------------------------------------------------------------------------------------------------------------------
##  Question 4: Appropriately labels the data set with descriptive variable names.
## -------------------------------------------------------------------------------------------------------------------------------

names(S_merged) 
# > names(S_merged)
# [1] "SubjectID"

names(Y_merged)
# > names(Y_merged)
# [1] "Activity"

names(X_merged)
# > names(X_merged)
#[1] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z" 
#[64] "fBodyGyroMag-std"      "fBodyGyroJerkMag-mean" "fBodyGyroJerkMag-std"


## -----------------------------------------------------------------------------
## (A) Time to join these processed datasets into a single combined dataset.
##     Our 1st Cleaned and Processed Dataset w/10299 rows n 68 cols
## -----------------------------------------------------------------------------

T_cleaned <- cbind(S_merged, Y_merged, X_merged)

## -----------------------------------------------------
## (B) Check the structure of the cleaned dataframe  
## -----------------------------------------------------

dim(T_cleaned)
# > dim(T_cleaned)
# [1] 10299    68

str(T_cleaned)
# > str(T_cleaned)
# 'data.frame':    10299 obs. of  68 variables:
# $ SubjectID                : int  1 1 1 1 1 1 1 1 1 1 ...
# $ Activity                 : Factor w/ 6 levels "WALKING","WALKING UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ tBodyAcc-mean-X          : num  0.289 0.278 0.28 0.279 0.277 ...
# $ tBodyAcc-mean-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ tBodyAcc-mean-Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ tBodyAcc-std-X           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ tBodyAcc-std-Y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
# $ tBodyAcc-std-Z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
# $ tGravityAcc-mean-X       : num  0.963 0.967 0.967 0.968 0.968 ...
# $ tGravityAcc-mean-Y       : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
# $ tGravityAcc-mean-Z       : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
# $ tGravityAcc-std-X        : num  -0.985 -0.997 -1 -0.997 -0.998 ...
# $ tGravityAcc-std-Y        : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
# $ tGravityAcc-std-Z        : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
# $ tBodyAccJerk-mean-X      : num  0.078 0.074 0.0736 0.0773 0.0734 ...
# $ tBodyAccJerk-mean-Y      : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
# $ tBodyAccJerk-mean-Z      : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
# $ tBodyAccJerk-std-X       : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
# $ tBodyAccJerk-std-Y       : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
# $ tBodyAccJerk-std-Z       : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
# $ tBodyGyro-mean-X         : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
# $ tBodyGyro-mean-Y         : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
# $ tBodyGyro-mean-Z         : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
# $ tBodyGyro-std-X          : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
# $ tBodyGyro-std-Y          : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
# $ tBodyGyro-std-Z          : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
# $ tBodyGyroJerk-mean-X     : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
# $ tBodyGyroJerk-mean-Y     : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
# $ tBodyGyroJerk-mean-Z     : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
# $ tBodyGyroJerk-std-X      : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
# $ tBodyGyroJerk-std-Y      : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
# $ tBodyGyroJerk-std-Z      : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
# $ tBodyAccMag-mean         : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
# $ tBodyAccMag-std          : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
# $ tGravityAccMag-mean      : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
# $ tGravityAccMag-std       : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
# $ tBodyAccJerkMag-mean     : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
# $ tBodyAccJerkMag-std      : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
# $ tBodyGyroMag-mean        : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
# $ tBodyGyroMag-std         : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
# $ tBodyGyroJerkMag-mean    : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
# $ tBodyGyroJerkMag-std     : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
# $ fBodyAcc-mean-X          : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
# $ fBodyAcc-mean-Y          : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
# $ fBodyAcc-mean-Z          : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
# $ fBodyAcc-std-X           : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
# $ fBodyAcc-std-Y           : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
# $ fBodyAcc-std-Z           : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
# $ fBodyAccJerk-mean-X      : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
# $ fBodyAccJerk-mean-Y      : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
# $ fBodyAccJerk-mean-Z      : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
# $ fBodyAccJerk-std-X       : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
# $ fBodyAccJerk-std-Y       : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
# $ fBodyAccJerk-std-Z       : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
# $ fBodyGyro-mean-X         : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
# $ fBodyGyro-mean-Y         : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
# $ fBodyGyro-mean-Z         : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
# $ fBodyGyro-std-X          : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
# $ fBodyGyro-std-Y          : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
# $ fBodyGyro-std-Z          : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
# $ fBodyAccMag-mean         : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
# $ fBodyAccMag-std          : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
# $ fBodyAccJerkMag-mean : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
# $ fBodyAccJerkMag-std  : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
# $ fBodyGyroMag-mean    : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
# $ fBodyGyroMag-std     : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
# $ fBodyGyroJerkMag-mean: num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
# $ fBodyGyroJerkMag-std : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...


head(T_cleaned)

## -----------------------------------------------------------------------------
## (D) Writing the result of the 1st independent dataset to the file
## -----------------------------------------------------------------------------

write.table(T_cleaned, "tidy_cleaned.csv",sep=",",row.name= FALSE) 

## -------------------------------------------------------------------------------------------------------------------------------
##  Question 5: Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
## -------------------------------------------------------------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## (A) Reshape the data :Compute the means, grouped by activity per each subject
## ----------------------------------------------------------------------------- 

melted <- melt(T_cleaned, id=c("SubjectID","Activity"))


## -----------------------------------------------------
## (A) Check the structure of the melted dataframe  
## -----------------------------------------------------
dim(melted)
# > dim(melted)
# [1] 679734      4

str(melted)
# > str(melted)
# 'data.frame':    679734 obs. of  4 variables:
# $ SubjectID: int  1 1 1 1 1 1 1 1 1 1 ...
# $ Activity : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ variable : Factor w/ 66 levels "tBodyAcc-mean-X",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ value    : num  0.289 0.278 0.28 0.279 0.277 ...

head(melted)



tidy <- dcast(melted, SubjectID+Activity ~ variable, mean) 


## -----------------------------------------------------
## (B) Check the structure of the final tidy dataframe  
## -----------------------------------------------------
dim(tidy)
# > dim(tidy)
# [1] 180  68

str(tidy)
# > str(tidy)
# 'data.frame':    180 obs. of  68 variables:
# $ SubjectID           : int  1 1 1 1 1 1 2 2 2 2 ...
# $ Activity            : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
# $ tBodyAcc-mean-X       : num  0.277 0.255 0.289 0.261 0.279 ...
# $ tBodyAcc-mean-Y       : num  -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...
# $ tBodyAcc-mean-Z       : num  -0.1111 -0.0973 -0.1076 -0.1045 -0.1106 ...


head(tidy)

## -----------------------------------------------------------------------------
## (B) Writing the result of the 2nd independent dataset to the file
## -----------------------------------------------------------------------------

write.table(tidy, file = "tidyDataset.txt",sep = "\t " ,row.name=FALSE) 




##==========================================================================================
