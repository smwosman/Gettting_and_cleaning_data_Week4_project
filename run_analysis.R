setwd("D:/_My Robi Docs/Documents/Personal/Coursera/Getting and Cleaning Data/Project/Gettting_and_cleaning_data_Week4_project")
trace(utils:::unpackPkgZip,edit = T)

# library loaded
library(dplyr)
library(data.table)
library(RCurl)
library(reshape2)


# setting up the directories, path & variables 
downloadFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "./data"

if(!file.exists(dataDir)){ dir.create(dataDir)}

myZipFilePath <- file.path(dataDir,"myData.zip")
myTidyDataFilePath <- file.path(dataDir,"tidy_data.txt")

# download the .zip files but check only if it not exists
if(!file.exists(myZipFilePath)){ 
	myBinData <- getBinaryURL(downloadFileURL, ssl.verifypeer=FALSE, followlocation=TRUE)
	fileHandle <- file(myZipFilePath, open="wb")
	writeBin(myBinData, fileHandle)
	close(fileHandle)
	rm(myBinData)
}

# unzip the files
extractedZipPath <- file.path(dataDir, "UCI HAR Dataset")
if(!file.exists(extractedZipPath) || debug){
	unzip(myZipFilePath, exdir=dataDir, overwrite=TRUE)
}

# get the list of files and directories
dirList <- list.files(extractedZipPath, recursive=TRUE)


# load all the train, test, activity & features .txt files into memory excluding the 'Inertial Signals' folders
sanitizedDirList <- dirList[!grepl("Inertial|README", dirList)]

for(dataFile in sanitizedDirList[grepl("test|train",sanitizedDirList)] ){
	# generate parameters based on filesc
	paramName <- paste0("", tolower(sub("^.*/([^\\.]+).*$","\\1",dataFile, perl=TRUE)))
	txtFile <- file.path(extractedZipPath, dataFile)
	tableData <- read.table(txtFile)
	assign(paramName, tableData)
	rm(tableData)
}


# below variables are dynamically generated (you can ls() and check)
# subject_test, # subject_train, # x_test, # x_train, # y_test, # y_train, # activity_labels.txt, # features.txt

features <- features.txt
activity_labels <- activity_labels.txt

rm(features.txt)
rm(activity_labels.txt)


# Assignment/Project:

# Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subMerged <- rbind(subject_train, subject_test)

# Extracts only the measurements on the mean and standard deviation for each measurement
featuresMeanSTD <- features[grep("mean|std",features[,2]),]
X <- X[,featuresMeanSTD[,1]]

# Uses descriptive activity names to name the activities in the data set
colnames(Y) <- "label"
Y$activity <- factor(Y$label, labels = as.character(activity_labels[,2]))
activity <- Y$activity

# Appropriately labels the data set with descriptive variable names
colnames(X) <- features[featuresMeanSTD[,1],2]

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(subMerged) <- "subject"
mergedData <- cbind(X, activity, subMerged)
temp <- group_by(mergedData,activity, subject)
tidy_data <- summarize_all(temp,funs(mean))

# write final tidy data
write.table(tidy_data, file = myTidyDataFilePath, row.names = FALSE, col.names = TRUE, quote = FALSE)

