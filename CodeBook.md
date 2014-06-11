# Codebook for the Tidy Data Set

## The Original Data
The raw data used to produce the tidy data set was represents data collected from accelerometers from Samsung Galaxy smartphones. 

The raw data information found on the [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is: 

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data is avaiable [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Please look at the `README.txt` file in the original data for a detailed description of the contents of the files and meaning of the features (variables).

## The Tidy Data

As required by the course project, the steps needed to generate the tidy data is:

### 1. Merges the training and the test sets to create one data set.

```{r}
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
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
To select the features that has the mean and standard deviation the approach was generate a logical vector where the value is TRUE if the name of the feature has *mean*, *std*, *Class* or *Subject* as substrings. The Class and Subject inclusion is to keep the subject id and class label on the data.

```{r}
colWithMeansOrStdValues <- grep("mean|std|Class|Subject", names(oneDataset))
oneDataset <- oneDataset[,colWithMeansOrStdValues]
```


### 3. Uses descriptive activity names to name the activities in the data set
Use the activity labels inside the `activity_labels.txt` file and merge with the dataset to include a column with human friendly names of the activities.

```{r}
#3.1 Put the activity names on the class labels
activityNames <- read.table(file="./data/raw/activity_labels.txt", header=FALSE)
names(activityNames) <- c("Class_Label", "Class_Name")
oneDataset <- merge(x=oneDataset, y=activityNames, by.x="Class_Label", by.y="Class_Label" )
```


### 4. Appropriately labels the data set with descriptive variable names. 
The step 1.2 already put the features names on the columns of the data. But the names has some special characters (eg. "()") that can make difficult to work with the features names. So some cleaning is made to delete or replace some characters.

```{r}
# remove some special characters from the names of the variables
names(oneDataset) <- gsub(pattern="[()]", replacement="", names(oneDataset))
names(oneDataset) <- gsub(pattern="[-]", replacement="_", names(oneDataset))
```

### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
Do some reshaping to produce the tidy data as required by the project description and save the result on `/data/Tidy_Dataset.txt` file.

```{r}
#5.1 - remove the class_label column
oneDataset <- oneDataset[,!(names(oneDataset) %in% c("Class_Label"))]

meltdataset <- melt(data=oneDataset, id=c("SubjectID", "Class_Name"))
tidyDataset <- dcast(data= meltdataset, SubjectID+Class_Name ~ variable, mean)

# 5.2 Save the tidy dataset
write.table(tidyDataset, file="./data/Tidy_Dataset.txt", row.names=FALSE)
```