# CodeBook

This file describes the original data, the original variables, the process to process and transform the original variables, the resulting variables.

## Original Data

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

_from [the original data location](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)_

The archive contains its own description of variables. For brevity we only refer to the variables we use.
It contains two sets of data: a train set and a test set.
We do not use the Intertial Signals folder inside each set. The data in these folders is not normalized and then has units.
Since we use the the X_test and X_train sets, which contain normalized data, we do not have units except for the angle() variables, for which the unit is radians (rad). The bounds of the variables' values is [-1, 1] as described in the original data code book, which can be found in the README.txt and features_info.txt inside the archive.

## Original Variables

Naming convention:

  - `t` prefix indicates time domain signal
  - `f` prefix indicates frequency domain signal obtained by applying fast fourier transform to the respective time domain signal
  - `Body` indicates the body movement component of the sensor
  - `Gravity` indicates the gravity component of the accelerometer sensor (gyroscopes do not contain this component)
  - `Acc` indicates the acceleremoter sensor
  - `Gyro` indicates the gyroscope sensor
  - `Jerk` indicates Jerk signal for the sensor (description on how they were calculated available in features_info.txt)
  - `Mag` indicates euclidean magnitude for the respesctive signal
  - `mean()` indicates that the variable is the mean() of the signal
  - `std()` indicates that the variable is the std() of the signal
  - `X`, `Y`, and `Z` indicates what is the three dimensional component of the signal
  - `angle()` angle in radians (rad) between two variables
  
The following list is a partial transcript of features.txt. Thus, the original index is kept for reference.

```
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
41 tGravityAcc-mean()-X
42 tGravityAcc-mean()-Y
43 tGravityAcc-mean()-Z
44 tGravityAcc-std()-X
45 tGravityAcc-std()-Y
46 tGravityAcc-std()-Z
81 tBodyAccJerk-mean()-X
82 tBodyAccJerk-mean()-Y
83 tBodyAccJerk-mean()-Z
84 tBodyAccJerk-std()-X
85 tBodyAccJerk-std()-Y
86 tBodyAccJerk-std()-Z
121 tBodyGyro-mean()-X
122 tBodyGyro-mean()-Y
123 tBodyGyro-mean()-Z
124 tBodyGyro-std()-X
125 tBodyGyro-std()-Y
126 tBodyGyro-std()-Z
161 tBodyGyroJerk-mean()-X
162 tBodyGyroJerk-mean()-Y
163 tBodyGyroJerk-mean()-Z
164 tBodyGyroJerk-std()-X
165 tBodyGyroJerk-std()-Y
166 tBodyGyroJerk-std()-Z
201 tBodyAccMag-mean()
202 tBodyAccMag-std()
214 tGravityAccMag-mean()
215 tGravityAccMag-std()
227 tBodyAccJerkMag-mean()
228 tBodyAccJerkMag-std()
240 tBodyGyroMag-mean()
241 tBodyGyroMag-std()
253 tBodyGyroJerkMag-mean()
254 tBodyGyroJerkMag-std()
266 fBodyAcc-mean()-X
267 fBodyAcc-mean()-Y
268 fBodyAcc-mean()-Z
269 fBodyAcc-std()-X
270 fBodyAcc-std()-Y
271 fBodyAcc-std()-Z
294 fBodyAcc-meanFreq()-X
295 fBodyAcc-meanFreq()-Y
296 fBodyAcc-meanFreq()-Z
345 fBodyAccJerk-mean()-X
346 fBodyAccJerk-mean()-Y
347 fBodyAccJerk-mean()-Z
348 fBodyAccJerk-std()-X
349 fBodyAccJerk-std()-Y
350 fBodyAccJerk-std()-Z
373 fBodyAccJerk-meanFreq()-X
374 fBodyAccJerk-meanFreq()-Y
375 fBodyAccJerk-meanFreq()-Z
424 fBodyGyro-mean()-X
425 fBodyGyro-mean()-Y
426 fBodyGyro-mean()-Z
427 fBodyGyro-std()-X
428 fBodyGyro-std()-Y
429 fBodyGyro-std()-Z
452 fBodyGyro-meanFreq()-X
453 fBodyGyro-meanFreq()-Y
454 fBodyGyro-meanFreq()-Z
503 fBodyAccMag-mean()
504 fBodyAccMag-std()
513 fBodyAccMag-meanFreq()
516 fBodyBodyAccJerkMag-mean()
517 fBodyBodyAccJerkMag-std()
526 fBodyBodyAccJerkMag-meanFreq()
529 fBodyBodyGyroMag-mean()
530 fBodyBodyGyroMag-std()
539 fBodyBodyGyroMag-meanFreq()
542 fBodyBodyGyroJerkMag-mean()
543 fBodyBodyGyroJerkMag-std()
552 fBodyBodyGyroJerkMag-meanFreq()
555 angle(tBodyAccMean,gravity)
556 angle(tBodyAccJerkMean),gravityMean)
557 angle(tBodyGyroMean,gravityMean)
558 angle(tBodyGyroJerkMean,gravityMean)
559 angle(X,gravityMean)
560 angle(Y,gravityMean)
561 angle(Z,gravityMean)
```
## Trasnformation Process

### Main Process

The main process is to:

  - download the data (download_data function)
  - load the test set (see Transformation Process section below)
  - load the train set (see Transformation Process section below)
  - merge the two sets
  - summarize the merged set, grouping by subject and activity, using the mean function
  - write the summarized set to summary.csv

### Transformation Process

The transformation process is executed in the load_set function.
The purpose is to produce a data frame that contains only the needed variables:

  - the subject
  - the activity label
  - variables that contain `mean` or `std` in their names
  
Thus, the process:

  1) loads the `activity_labels` (from activity_labels.txt) (a map between an id and an activity name)
  2) loads the `features_labels` (from features.txt) (the list of variables contained in the X_ file)
  3) loads the `subject` (from subject_.txt file) (which tells us that line n of X_ was produced by the subject indicated in line n of subject_ file)
  4) loads the `labels` (from y_.txt file) (which tells us that line n of X_ was labeled with the activity id of line n of y_)
  5) replaces the id of activities by the respective activity name in the `labels`
  6) removes the id of activities from `labels` leaving only the activity name
  7) loads the `features` (from X_.txt file) (using the `features_labels` as column names)
  8) removes any variable from `features` that does not contain `mean` or `std` in its name
  9) merges the `subjects`, `labels`, and `features` tables columns into the `set` table
  10) returns the `set` table

## Resulting Variables

The summary.csv contains the following variables:

  - subject, which contains the id of the subject
  - activity, which contains the name of the activity
  - variables containing the average of the signals extracted in the Transformation Process
