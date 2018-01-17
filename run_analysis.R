setwd("C:/Users/ctmun/OneDrive/Desktop/GClnDataProj")
## All files were read into Rstudio
## each data frame was examined using exploratory data analysis i.e.
## used dim(), head/tail(), summary(), str().  In some cases (the y_ and subject_ files) the unique() function clarified
## that the table repeated values for the subject(subject_)  or  activity(y_ file)
## the X_ files contained the bulk of the data. both the X_test and X_train contained df with 561 cols.
## therefore, conclusion that the columns represented the variable measurements identified by the "features" text file
## which listed 561 featue variables and described further in "features_info" file


df_subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
df_actytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
df_datatest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
df_subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
df_actytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
df_datatrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
## df above contain subject, activity, and data for the test and train datasets

df_featurevar <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
## second column of df_featuevar contains character description of measured vars
## now assign those vars as character vector
feature <- as.character(df_featurevar[,2])

df_actlabel <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
## df_actlabel contains the 6 activities measured (Walking, sitting, etc) with their numerical equivalent

dftest1 <- cbind(df_actytest, df_datatest)
# add column for activity
##  dim(dftest1)  2946  562   check appropriate dims
dftest2 <- cbind(df_subjtest, dftest1)  ## add column for subject
##  dim(dftest2)  2947  563
##  Assign col names
colnames(dftest2)  <- c("subject", "activity", feature)

## Now dftest2 is a data frame containing test subject measurements: col1 (subject id#) col2 (activity id#) 
##          cols3:563 (feature var msrmts)

dftrain1 <- cbind(df_actytrain, df_datatrain)  ## add col for activity
##  dim(dftrain1)   7352  562
dftrain2 <- cbind(df_subjtrain, dftrain1)   ## add column for subject
##  dim(dftrain2)   7351   563
##  Assign colnames
colnames(dftrain2)  <- c("subject", "activity", feature)
#### Now dftrain2 is a data frame containing training subject measurements: col1 (subject id#) col2 (activity id#) 
##                cols3:563 (feature var msrmts)

## Now combine the test and training df
df_combined <- rbind(dftest2, dftrain2)
## dim(df_combined)   10299  563

## Extract only Variables with mean/std data
## first extract indices of the feature variables which contain mean or std
ind <- grep("mean", df_featurevar[,2], value=FALSE)
ind2 <- grep("std", df_featurevar[,2], value=FALSE)
indcomb <- as.vector(rbind(ind, ind2))
indcomb2 <- sort(indcomb)  ## indcomb2 is now a vector of column indices containing mean or std (in order)

## extract mean/std columns using indices in indcomb2
Extractdf <- df_combined[,indcomb2]

## Replace col 2 activity codes with character descriptions
Extractdf$activity <- gsub("1", "Walking", Extractdf$activity)
Extractdf$activity <- gsub("2", "Walking_Upstrs", Extractdf$activity)
Extractdf$activity <- gsub("3", "Walking_Dnstrs", Extractdf$activity)
Extractdf$activity <- gsub("4", "Sitting", Extractdf$activity)
Extractdf$activity <- gsub("5", "Standing", Extractdf$activity)
Extractdf$activity <- gsub("6", "Laying", Extractdf$activity)
##  unique(Extractdf$activity) [1] "Standing"   "Sitting"    "Laying"     "Walking"    "Walking_Dnstrs" "Walking_Upstrs"

## Finally, step 5. create Indep tidy data set with avg vars of each activity for each subject
library(plyr)
Inddata <- aggregate(. ~subject + activity, Extractdf, mean)
## dim(Inddata) 180  92
## This makes sense 30 subjects x 6 activities = 180. 92 extracted column vars
## further looks at Inddata confirmed proper structure and analysis
