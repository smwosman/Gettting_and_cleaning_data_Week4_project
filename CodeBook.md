This code book describes the data & variables used in this project, along with the processing steps used to create the resulting tidy data set.


1. The compressed dataset was downloaded from the URL (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extracted into a particular directory.
2. The directory listing was generated and only the relevant files listing was kept.
3. The relevant data files were read into data frames dynamically using "for" loop.
4. The training and test datasets were combined into a single dataset.
5. Only the mean() and std() feature columns preserved in the merged data set using subsetting.
6. Appropriate column headers were added.
7. A tidy dataset was created containing the mean of each feature for each of the subject and each of the activity resulting in 180 rows (6 rows for each of the 30 subjects). 
8. The tidy dataset was written to a TXT file.


Details of each data file

a. features.txt: Names of the 561 features.
b. activity_labels.txt: Activity name and IDs for each of the 6 activities.
c. subject_train.txt: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in x_train.txt.
d. x_train.txt: 7352 observations of the 561 variables.
e. y_train.txt: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in x_train.txt.
f. subject_test.txt: A vector of 2947 integers, denoting the ID of the subject related to each of the observations in x_test.txt.
g. x_test.txt: 2947 observations of the 561 variables.
h. y_test.txt: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in x_test.txt.

i. All data files in the folder "Inertial Signals" were ignored.
