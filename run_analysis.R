##Part 1: Reading in all files from the UCI HAR Dataset 2 folder:

## Please note that I have annotated what each line of code does by documenting with a hash tag after the code.

features <- read.table("./UCI HAR Dataset 2/features.txt", stringsAsFactors = FALSE) #Contains all headers and variable names of the complete data set
X_train <- read.table("./UCI HAR Dataset 2/train/X_train.txt") # Contains the training data set
subject_train<- read.table("./UCI HAR Dataset 2/train/subject_train.txt") # Contains the subject numbers for X_train
y_train <- read.table("./UCI HAR Dataset 2/train/y_train.txt") # Contains the numerical ID of the activity labels for X_train
X_test <- read.table("./UCI HAR Dataset 2/test/X_test.txt") # Contains the test data set
subject_test <- read.table("./UCI HAR Dataset 2/test/subject_test.txt") # Contains the subject numbers for X_test
y_test <- read.table("./UCI HAR Dataset 2/test/y_test.txt") # Contains the numerical ID of the activity labels for X_test
activitylabels <- read.table("./UCI HAR Dataset 2/activity_labels.txt", stringsAsFactors = FALSE) #Contains a key with the character names of the activity labels used in the training and test data sets

## Part 2: Assembling all the parts of the Samsung data together and generating tidy data:

## Please note that I have annotated what each line of code does by documenting with a hash tag after the code.

Final_RAW_1 <- rbind(X_train, X_test)  #Joins the training and the test data set, 1 below the other
Full_subject <- rbind(subject_train, subject_test) # Joins the subject numbers for both training and test data sets
Full_y <- rbind(y_train, y_test) # Joins the numeric activity labels for both training and test data sets
Final_RAW_2 <- cbind(Full_y, Full_subject, Final_RAW_1) # Makes a complete data set of all training and test data, along with subject and activity labels
names(Final_RAW_2) <- c("Activity", "Subject", features[,2]) # Adds the headers to the complete dataset using features.txt and manually including headers for Subject and Activity
names(Final_RAW_2) <- make.names(names(Final_RAW_2)) # Converts all variable names to an R compatible format
FINAL <- Final_RAW_2[1:10299,1:563] # weird thing, on my computer R gets stuck, if I dont do this step to redefine the df
DF_MeanSD <- cbind(FINAL[,1:2],select(FINAL, contains("mean")),select(FINAL, contains("std"))) # Generates a subset containing only columns that have "mean" or "std" in the headers
DF_MeanSD[,1] <- factor(DF_MeanSD[,1], labels = activitylabels[,2]) # converts the Activity column from numeric to Factor class and then assigns the labels using activity_labels.txt
df2 <- group_by(DF_MeanSD, Subject, Activity) # Groups the dataframe by Subject and Activity
df3 <- summarise_each(df2, funs(mean)) # Find the means of the remaining columns while grouped with Subject
View(df3)

