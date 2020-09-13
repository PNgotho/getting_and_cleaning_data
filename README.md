# getting_and_cleaning_data
This repo is for my project on Getting and Cleaning Data

Data sources used were downloaded from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The zip file was unzipped on local PC and all content placed in the Data folder of the repo. Some of the files are large and could cause challenge on commiting to repo.
To try out the code on this repo you may need to download your own copy of the zip file and unzip it in your PC incase the data set in the repo is corrupted due to the size.

To understand the source data sets review the README.md file located in the Data folder of this repo.

The following are the instructions given for this project which is the basis of work done in this repo.

Create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Below is an outline of the processes I did to achieve the above instructions.

	1. Merges the training and the test sets to create one data set.
		a. Data files used are:
			i. Data folder
				1) Features.txt
				2) Activity_labels.txt
			ii. Data\Test folder
				1) Subject_test.txt
				2) y_test.txt
				3) X_test.txt
			iii. Data\Train folder
				1) Subject_train.txt
				2) y_train.txt
				3) X_train.txt
			
		b. Process
			i. Create tidy test data
				1) Create new dataframe using X_test.txt data (use read.fwf since the 561 columns in the txt file are fixed width)
				2) Set the 561 column names to descriptions in features.txt
				3) Column bind y_test, subject_test as a new columns on the above dataframe
				4) Create a new column named data_set and value is "test" in subject_test vector and column bind this to above dataframe
			ii. Create tidy train data
				1) Create new dataframe using X_train.txt data (use read.fwf since the 561 columns in the txt file are fixed width)
				2) Set the 561 column names to descriptions in features.txt
				3) Column bind y_train, subject_train as a new columns on the above dataframe
				4) Create a new column named data_set and value is "train" in subject_test vector and column bind this to above dataframe
			iii. Create the final merged data set
				1) Merge the tidy test and tidy train data
				
	2. Extracts only the measurements on the mean and standard deviation for each measurement.
		a. Update the merged dataframe to exclude all columns in the measure columns that do not contain the words "mean" or "std".
    b. Convert the merged dataframe into a table dataframe that is easier to manipulate.
    
  3. Uses descriptive activity names to name the activities in the data set
		a. Merge activity_labels to the merged data set using activity_code as the key

	4. Appropriately labels the data set with descriptive variable names.
		a. ensured that at each stage above, the columns are labeled with a descriptive name

	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
		a. Create a new data table that summarizes the variables based on a group_by on activity and subject variables.
		
		
