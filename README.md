# Get-Clean-Data-Project 

This project is the Coursera/JHU Data Science course "Getting and Cleaning Data"
# week 4/ course end project
# Data imported from provided data set and found here
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Data read into Rstudio Verison 1.1.383 // Windows 10_ 64 bit
#
#Assignment required a merge of two data sets (test and train).  
Then extract only those variables concerning mean and standard deviation.
Add descriptive activity and variable names.
Finally, create a second, independent tidy data set with the average for each subject/activity.
# R script can be found in repo file: "run_analysis.R"

All files were read into Rstudio
6 files read into R using read.table (header=FALSE) as follows:
Subject codes of test and training sets (file "subject_...")
Activity codes of test and training sets (file "y_ ...")
data from test and training sets. (file "X_ ...")

Each data frame was examined using exploratory data analysis i.e.
Used dim(), head/tail(), summary(), str().  In some cases (the y_ and subject_ files) the unique() function clarified that the table repeated values for the subject(subject_)  or  activity(y_ file).
There were 30 subjects (21 in training, 9 in test) and 6 activities (1 Walking, 2 Walking Upstairs, 3 Walking downstairs, 4 Sitting, 5 Standing, 6 Laying).
The X_ files contained the bulk of the data. both the X_test and X_train read in as df with 561 cols.
Therefore, conclusion that the columns represented the variable measurements identified by the "features" text file which listed 561 feature variables and described further in "features_info" file.
This feature variable information was read into an R data frame.

Data manipulation and analysis
Feature variable df contained an index(col1) and description(col2).  Created vector called feature which was extracted from column 2.  It was 561 long, contained variable character descriptions.
Activity labels (character descriptions) were read in from the "activity_labels.txt" file.
Starting with the "test" data frame, I column binded twice, adding columns for activity and then subject.
The result was a 2946x563 data frame called "dftest2".
Same procedure for "train" data. Resulting df "dftrain2".
Both df had rows(2946) by subj/activity and cols(563): subject, activity, variable/features (last 561).
For both df I assigned column names: subject, activity, then feature vector.  note: featue vector matched remaining cols.
Combined these two df's using rbind.
Resulted in "df_combined"   dim 10299x563

Extracting applicable portions of df:
Assignment required extract of feature measurements relating to mean and/or std deviation.
Used grep to extract col indices for “mean”, then “std”.  Combined these two vectors, adding in cols 1 & 2 for the subject & activity columns.  Then sorted (in order).  Result was a vector “indcombined” which contained all indices necessary.
Subsetting “df_combined” using the “indcombined” indices provided a df with columns of subj,activity, and remaining vars with mean and/or std dev. Dim 10299 x 81
Activity column was adjusted, replacing codes (1:6) with character id’s (Walking, Sitting, ..)

Final Step: Create Independent data set with average of each variable, for each subject/activity.
Using “plyr” package, applied aggregate function to subject + activity, calling for the mean.
Result was a df “Inddata” of Dim 180 x 92.  (made sense, 30 subjects x 6 activities = 180)




