# R Codebook
## Raw Data
We used the UCI HAR dataset [(link)](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), which is a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The dataset was downloaded as a zip file, notably containing the following text files.
- X_train.txt - 
- X_test.txt
- y_train.txt
- y_test.txt
- subject_train.txt
- subject_test.txt

The features in X_train, X_test are described by the authors of the UCI HAR dataset as follows:
>"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag"

For each of these 11 signals, in the X-Y-Z directions, I utilized the mean and std measurements (33 each, for a total of 66 measurements). There were 7352 and 2947 observations in the X training and test sets respectively.

The Y training and txt files corresponded to the activity performed while the X text files' measurements were taken (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying).

The subject txt files identified the human subject for each measured observation and label.

## Data Cleaning
I started by extracting the names of the variables from features.txt, using grepl() in order to create a logical array to filter the variables corresponding to the mean and std of each signal measurement.

Next, I gathered the training and test X data. I filtered out the non-relevant columns, then added a column identifying whether the observation belonged to the training or test set. After combinining the X data tables, I renamed the columns to the respective mean and std measurements. I

Similarly, I condensed the labeled Y data and subject information into one table each, for all observations.

I then combined the X, Y, and subject information tables into one compact data frame. 

Using this combined table, I grouped the data across activity and subject. Using dplyr's summarize() function, I determined the average mean and std for all measured values for each activity and subject pairing.

This summarized table was also saved as a dataframe.