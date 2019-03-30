
The purpose of this project is to download data, clean the data, combine necessary data and generate a simple output of the tidy dataset.

This project includes four files README.md, CodeBook.md, run_analysis.R, tidy_data.txt

Followings are done:

1. Download the dataset to the working directory and extracted using the .R script.
2. Only the necessary dataset was loaded into the memory: X_train.txt, X_test.txt, Y_train.txt, Y_test.txt, subject_train.txt, subject_test.txt, features.txt, activity_labels.txt. 
3. Merged the X_train and X_test.txt.
4. Merged the Y_train and Y_test.txt.
5. Merged the subject_train and subject_test.
6. Extracted only the measurements on the "mean" and "standard deviation" for each measurement using regular expression.
7. Used descriptive activity names to name the activities in the dataset.
8. Appropriately labeled the dataset with descriptive variable names.
9. Created a second, independent tidy data set with the average of each variable for each activity and each subject.
