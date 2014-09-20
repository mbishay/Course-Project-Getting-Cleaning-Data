Human Activity Recognition Using Smartphones Dataset

The data in CourseProject.txt comes from a subset of the data collected by Reyes-Ortiz, 
Anguita, Ghio, and Oneto in Spain in December 2012. 

They conducted experiments with 30 participants, each wearing a Samsung Galaxy S II 
smartphone on their waists while performing six activities.  As the participants performed 
these activities, accelerometer and gyroscope measurements were recorded and 
processed.  For more information on the exact measurements, see the README and the 
Features_Info files in the original UCI HAR Dataset folder.

=========================================================
In this dataset, only the measurements related to mean or standard deviation were 
included, and the data was reformatted to make it tidy and easy to read.

There are nine variables in this dataset:

Subject Number: This variable indicates the original subject number from the original 
dataset.  Values range from 1 to 30 representing the 30 participants.

Activity: This variable indicates the activity performed while the data was gathered.  
Values include: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
SITTING, STANDING, LAYING

Domain: This variable indicates the domain of the signal.  There are two possible values 
Time (collected from the Time domain) and FastFourierTransform (values that had been 
transformed using an FFT transformation).

Device: This variable indicates the device within the phone used to collect the 
information.  Options include: Accelerometer and Gyroscope.

AccelerationSignal: The acceleration signal was separated into two components, and 
this variable tells you which type of signal was recorded.  The options are Body and 
Gravity.

Measurement: This variable indicates the measurement that was taken from the original 
database.  While the original database contained many variables, only those related to 
Mean and StandardDeviation are included in this dataset, so the two potential values of 
this variable are Mean and StandardDeviation.

Axis:  This variable indicates which of the 3-axis signals were involved in the 
measurement.  Possible values are X, Y, and Z.  Some measures are unrelated to an axis 
and have missing values for this variable.

Other:  This variable is a bit of a "catch all".  Some variables in the original dataset 
contained additional descriptions that were not captured in the variables between Domain 
and Axis.  Those additional descriptions are stored in this variable for future reference.  
Most rows are blank for this variable.

MeanValue:  This variable stores the mean value that was calculated from the original 
data over all observations of this particular participant doing this particular activity in the 
measurement indicated by the combination of variables from Domain to Other.

