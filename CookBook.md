This is my cookbook
===================
The R Program
-------------
The R script should be placed directly under the "UCI HAR DATASET"
The it should be run with that as the working directory as the R script will get the input files from subdirectories underneath it
For the first requirement of combining, we first prepare Train datasets and then prepare the Test datasets. Then we merge them with the Train data on top and the Test data at the bottom.
The output of the script are two files, one is the clean data and the other has the averages as required.

Input Files
-----------
The input files are as it is either in the train or test subdirectories as theyu currently exist now.
Output Files
------------
"CleanTarget.csv" is the file that has the right columns of means and stds and combines the train and test data together. Here are the column names as they appear
 "SUBJECT","tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y","tBodyAcc-std()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z" ... etc. The last column is "ACTLABEL".
The "SUBJECT" column contains the person's id and the "ACTLABEL" contains activity performed by the person and this is in words, not numbers. The middle column names in betweem these two columns are specified in the assignment as given- please see the "features.txt" file to get more information. Note we were asked to only take columns which are either mean or std variables.

"AveragedData.txt" is the file containing the averages of the above column names but it is now shown as "SUBJECT", "ACTLABEL", followed by the column names of means and stds, but the values are now averages for a given "SUBJECT" and his/her "ACTLABEL" activity.

Transformations
---------------
1. First we prepare separately the train and test files but before we do we first gather the feature names as column names, and load activity labels.
2. Now we deal with Train data, put their features and then filter only mean and std data
3. We tack on the SUBJECT and ACTIVITY labels, put them aside.
4. Do steps 2-3 but this time for Test data, when done put them aside.
5. Merge now the clean Train data in step 4 with the Test cleaned data in step 5 then output this file as "CleanTarget.csv".
6. Lastly we do the averaging per column from data found in step 5. Do a bit of clean up and then output this file as the "AveragedData.txt"

See the comments found in run_analysis.R for actual commands for the above.
