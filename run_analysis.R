##run_analysis.R
##@ LPC
#######################################
##First make sure we are in the UCI HARF Dataset Working Directory 
## For example we should be in a working directory ../UCI HAR Dataset
## something like this should be issued --- setwd("~/Google Drive/Coursera/GettingCleaningData/UCI HAR Dataset")
## Now we are ready to begin
## Let us get the raw headers of features
rawheaders <- read.table("features.txt")
##drop the 1st column as it has just the coded numbers
featureNames <- rawheaders[ ,2]
##Get the activity labels -- we will need this for as we need the activity name not the numbers later
ActLabels <- read.table("activity_labels.txt")
######################################
##Now that the house keeping preparation is over we will first clean up Train and then clean up Test 
##and when all of them are clean we will then merge them
#####
## Let is clean and format what we need for Train
##  Let us put them on a table so we can manipulate them
TrainTable <- read.table("train/X_train.txt")
##  put headers onto the table
names(TrainTable) <- featureNames
##  Filter the headers as we only want the mean and std measurements
TargetTrainTable <- subset(TrainTable, select=grep("*mean*|*std*", featureNames))
## Prepare the train labels
TrainActsRaw <- read.table("train/y_train.txt")
## Now change drop the numbered activity labels and effectively replace it with activity name
TrainActLabels<-subset(merge(TrainActsRaw, ActLabels), select=c(2))
## Put the proper header/column name in  prep for column combining
names(TrainActLabels) <- c("ACTLABEL")
## Prepare the subjects  as above
TrainSubjects  <- read.table("train/subject_train.txt", col.names = c("SUBJECT"))
## Now produce a clean train data set and put it aside for later use
cleanTrain<-cbind(TrainSubjects, TargetTrainTable,TrainActLabels)
#########################################
## At this point we have a clean train and we now do the same for Test
## Everything is the same except we will use the Train data files
TestTable <- read.table("test/X_test.txt")
##  put headers onto the table
names(TestTable) <- featureNames
##  Filter the headers as we only want the mean and std measurements
TargetTestTable <- subset(TestTable, select=grep("*mean*|*std*", featureNames))
## Prepare the test labels
TestActsRaw <- read.table("test/y_test.txt")
## Now change drop the numbered activity labels and effectively replace it with activity name
TestActLabels<-subset(merge(TestActsRaw, ActLabels), select=c(2))
## Put the proper header/column name in  prep for column combining
names(TestActLabels) <- c("ACTLABEL")
## Prepare the subjects  as above
TestSubjects  <- read.table("test/subject_test.txt", col.names = c("SUBJECT"))
## Now produce a clean test data set and put it aside for later use
cleanTest<-cbind(TestSubjects, TargetTestTable,TestActLabels)
########################################
## We merge the cleaned files
mergedCleanFiles<-rbind(cleanTrain, cleanTest)
## We now write this to the disk
write.csv(mergedCleanFiles, "CleanTargetData.csv")

## Now we need to do the averages for the columns
AvDataTemp<-aggregate(mergedCleanFiles[, 2:ncol(mergedCleanFiles) - 1], by=list(SUBJECT=mergedCleanFiles$SUBJECT,ACTLABEL = mergedCleanFiles$ACTLABEL), mean)
##For some reason we have an extra SUBJECT column so we just delete that extra 
AvDataFinal <- subset(AvDataTemp, select=c(1:2,4:82))
## We now write this to the disk and we are done
write.csv(AvDataFinal,"AveragedData.csv")

###########################################
## Here are sample outputs
## 		SUBJECT	ACTLABEL	tBodyAcc-mean()-X	tBodyAcc-mean()-Y	tBodyAcc-mean()-Z	tBodyAcc-std()-X	tBodyAcc-std()-Y	tBodyAcc-std()-Z	etc
##		20		LAYING		0.2682107	-0.01543944	-0.10343206	-0.5465354	-0.2590113	-0.63973017	0.5909750	0.002436483	0.10778972	-0.9580456
