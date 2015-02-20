##Part 1: Reading in all files from the UCI HAR Dataset 2 folder:

features <- read.table("./UCI HAR Dataset 2/features.txt", stringsAsFactors = FALSE)
X_train <- read.table("./UCI HAR Dataset 2/train/X_train.txt")
subject_train<- read.table("./UCI HAR Dataset 2/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset 2/train/y_train.txt")
X_test <- read.table("./UCI HAR Dataset 2/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset 2/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset 2/test/y_test.txt")
activitylabels <- read.table("./UCI HAR Dataset 2/activity_labels.txt", stringsAsFactors = FALSE)

## Part 2: Assembling all the parts of the Samsung data together and generating tidy data:

Final_RAW_1 <- rbind(X_train, X_test) 
Full_subject <- rbind(subject_train, subject_test)
Full_y <- rbind(y_train, y_test)
Final_RAW_2 <- cbind(Full_y, Full_subject, Final_RAW_1) 
names(Final_RAW_2) <- c("Activity", "Subject", features[,2])
FINAL <- Final_RAW_2[1:10299,1:563] ## weird thing, R gets stuck if i dont do this redefining the same df as another variable 
DF_MeanSD <- cbind(FINAL[,1:2],select(FINAL, contains("mean")),select(FINAL, contains("std")))
DF_MeanSD[,1] <- factor(DF_MeanSD[,1], labels = activitylabels[,2])
df2 <- group_by(DF_MeanSD, Subject, Activity)
df3 <- summarise_each(df2, funs(mean))
View(df3)

