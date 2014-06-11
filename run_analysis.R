# Script for the Course project of Getting and Cleaning Data Course on Coursera - 04/06/2014

#Required Libraries
library("reshape2")


# 1 Merges the training and the test sets to create one data set.
# 1.1 Load the files
xtrainfile <- read.table(file="./data/raw/train/X_train.txt",header=FALSE)
ytrainfile <- read.table(file="./data/raw/train/Y_train.txt",header=FALSE)
strainfile <- read.table(file="./data/raw/train/subject_train.txt",header=FALSE)

xtestfile  <- read.table(file="./data/raw/test/X_test.txt",header=FALSE)
ytestfile  <- read.table(file="./data/raw/test/Y_test.txt",header=FALSE)
stestfile  <- read.table(file="./data/raw/test/subject_test.txt",header=FALSE)

#1.2 Get and set the names of the features
featuresNames <- read.table(file="./data/raw/features.txt",header=FALSE)
names(xtrainfile) <- featuresNames[,2]
names(xtestfile)  <- featuresNames[,2]
names(ytrainfile) <- "Class_Label"
names(ytestfile)  <- "Class_Label"
names(stestfile)  <- "SubjectID"
names(strainfile) <- "SubjectID"

#1.3 Union of the train and test data
X_data <- rbind(xtrainfile, xtestfile)
Y_data <- rbind(ytrainfile, ytestfile)
S_data <- rbind(strainfile, stestfile)

oneDataset <- cbind(X_data, Y_data, S_data)

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
colWithMeansOrStdValues <- grep("mean|std|Class|Subject", names(oneDataset))
oneDataset <- oneDataset[,colWithMeansOrStdValues]


#3 Uses descriptive activity names to name the activities in the data set
#3.1 Put the activity names on the class labels
activityNames <- read.table(file="./data/raw/activity_labels.txt", header=FALSE)
names(activityNames) <- c("Class_Label", "Class_Name")
oneDataset <- merge(x=oneDataset, y=activityNames, by.x="Class_Label", by.y="Class_Label" )


#4 Appropriately labels the data set with descriptive variable names.
# remove some special characters from the names of the variables
names(oneDataset) <- gsub(pattern="[()]", replacement="", names(oneDataset))
names(oneDataset) <- gsub(pattern="[-]", replacement="_", names(oneDataset))


#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#5.1 - remove the class_label column
oneDataset <- oneDataset[,!(names(oneDataset) %in% c("Class_Label"))]

meltdataset <- melt(data=oneDataset, id=c("SubjectID", "Class_Name"))
tidyDataset <- dcast(data= meltdataset, SubjectID+Class_Name ~ variable, mean)

# 5.2 Save the tidy dataset
write.table(tidyDataset, file="./data/Tidy_Dataset.txt", row.names=FALSE)
