Course-Project-Getting-Cleaning-Data
=============================================================

This file explains the script run_analysis.R that was created for simplifying and tidying the data from Human Activity Recognition Using Smartphones study by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto.

The original data is available from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In order for the script to work properly, the file should be separately downloaded and unzipped.  The unzipped file will contain a directory called “UCI HAR Dataset”. You can store this directory wherever you want on your computer.  However, you should not move or restructure the contents in any way.

Once in R, you should set your working directory to be in the UCI HAR Dataset folder.  The run_analysis.R script can be run from there.  This one script will do all work to complete all five steps of the tasks of cleaning and subsetting the data.

Step 1:  The script first reads in the training datasets: subject_train.txt, X_train.txt, and Y_train.txt and combines them into one dataset that starts with the subject number and then contains then continues with the other variables that were collected.  It then repeats the same process for the testing datasets (subject_test.txt, X_test.txt, and Y_test.txt) to create one testing database.  It then combines the training and testing databases into one unified database called “fulldata”.  Along the way, it deletes temporary files that are no longer needed.  It also creates a variable called “Condition” to store information on how the information was collected (either from training sessions or testing sessions) in case that distinction is needed later.  Lastly, this section of script labels the variable names in the new “fulldata” dataframe.

Step 2:  This part of the script looks through the variable names looking for names that contain “mean” or “std” in them as the assignment dictates.  It then creates a new dataframe called “shorterdata” that contains only the SubjectNumber (column 1), the variables that contain the key words, and the last the two columns of the fulldata dataframe that contain the activity code (for walking, going upstairs, etc.) and the test condition (training versus testing).

Step 3: Reads the names of the activities from the activity_lables.txt file and uses those names to change the codes in activity variable (column 82) from numbers to meaningful labels.

Step 4: Cleans up the variable names.  First, it creates a temporary vector with the current labels of the variables.  It then proceeds to clean up these current labels using a number of different commands.  It removes parentheses from the variable names since those interfere with many functions.  Next, it expands the names of several abbreviations to make them more meaningful (e.g., “tBody” becomes “TimeBody to indicate the time domain, “Acc” becomes “Accelerometer”, etc.).  Lastly, it removes the “-“ character which also interferes with some functions.   When the “currentlabels” vector is clean, it reassigns these labels to the variable names in the “shorterdata” dataframe.

Step 5: Creates a new, tidy dataframe that contains the mean of each variable for each activity for each person.  The script does this cleaning, by first loading a couple of library packages and initializing a new dataframe called “newdata” which will contain the new clean data.  It then goes through each participant (subject numbers 1 to 30) calculates the mean for each of their activities and adds that data as a row in the newdata dataframe.

It then creates a long form database by “melting” the data, keeping the SubjectNumber and Activity in-tact as the first two columns, and then having the complex variable name and mean in columns 3 and 4.  It then labels the names of the variables in columns 3 and 4 for easier reference.

Once this dataframe is formed, it goes to the next level of cleaning up the data by trying to simplify the complex variable names.  Since all the variables are either from the Time or Fast Fourier domain, it separates this distinction into a new column and shortens the name of the original complex variable name.

It then does the same thing with the Accelerometer versus Gyroscope distinction.  It separates this distinction into a new variable called “Device” and shortens the original variable once again.

Then, again it separates Body from Gravity into the variable “AccelerationSignal”, Mean from StandardDeviation in the variable “Measurement”, and it separates X, Y, and Z into an Axis variable where appropriate.  There are some missing values for variable names that don’t contain an axis.

Once these new variables are formed, there is very little “leftover” in the original Variable name.  That which is left is kept in that variable and it is renamed “Other”

The variables are then reordered into a more logical progression and the finale dataframe “newdata” is saved as a text file called “CourseProject.txt”

============================================================
For more information on the original dataset, see

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

And 

Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

