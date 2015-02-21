## Course Project: Getting and Cleaning Data

Data from  Reyes-Ortiz et al. entitled "Human Activity Recognition Using Smartphones Dataset"  was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The file UCI HAR Dataset 2 was unzipped into my working directory. This dataset contains smartphone recordings from 30 subjects, each of whom conducted 6 different movement tasks (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). Linear acceleration and angular velocity in multiple dimensions were recorded while performing tasks and a side set of different measurements were calculated. Two datasets were provided one from a training group of subjects and another from the testing group of subjects. 

For this Course Project, Training and Test dataset were merged together and properly annotated with variable names, subject names and activity labels. This assembled dataframe was then subsetted to isolate only variables/columns that contained the words "mean" or "std" in the variable name. The subsetted dataframe was then grouped by Subject and Activity. The script `run_analysis.R` was written to complete all of these tasks and to output a dataframe (df3), which displays the tidy dataframe. The script is divided into two parts: Part 1 reads in all relevant .txt files from within UCI HAR Dataset 2 and Part 2 assembles it together to make a dataframe (Final_RAW_2) and then cleans it up to generate a tidy dataframe (df3). The output of the script opens up the Viewer in R to look at the tidy dataframe df3. 

####Part 1: Reading in all files from the UCI HAR Dataset 2 folder:

- Each relevant .txt file was read into R and assigned a variable. Names of variables were chosen to match the names of the .txt files. Data included the training data set, the test data set and the respective subject, activity labels and headers (variables) of the training and test data. 

####Part 2: Assembling all the parts of the Samsung data together and generating tidy data:

- This part of the code starts by putting together the original data files like legos using a series of rbind and cbind operations    

- A first version of the entire dataset is created and defined as Final_RAW_2    

- Then the headers were assigned to FINAL_RAW_2 using the variable names provided. Two additional names were added for "Subject" and "Activity"  

- Weird thing, on my computer R gets stuck at this point, if I dont do this step to redefine FINAL_RAW_2 as a new dataframe FINAL. Not sure why?  

- Then FINAL is subsetted using contains () to select only the columns which contain "mean" or "std" in their header and assigned to DFmeanSD.  

- The Activity column of DFmeanSD is numeric. This is changed to a factor with labels. The provided file activity_labels.txt is used to define factor labels  

- Then the dataframe DF_MeanSD is grouped by Subject and then Activity and assigned to df2  

- Means are then calculated using summarise_each for all columns for df2 and assigned to df3.  

- df3 is the final tidy data set  

- View is used for easy visualization of df3  