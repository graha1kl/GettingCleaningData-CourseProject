# Codebook for `tidyDataAverages.txt`

## Original Data

The original data used to generate `tidyDataAverages.txt` was obtained from the UCI Machine Learning Repository and contains data "from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors" (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The original data can be obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

For a full description of the original data set, please refer to the `READMe.txt` and `features_info.txt` files contined within the zipped data set.

## Data Transformations

The tidy data file (`tidyDataAverages.txt`) was generated using the `run_analysis.R` script included in this repository. 

The script makes the following transformations from the original data set:

1. The training and test data sets are merged together to create one data set by first reading in the `subject_test.txt`, `X_test`, `y_test`, `subject_train.txt`, `X_train.txt`, and `y_train.txt` files and then using `cbind` and `rbind` functions to combine them together.

2. The combined data set is subset to retain only the columns that measure mean or standard deviation. This is accomplished by using a regular expression to identify the variables in the `features.txt` file that contain either `-mean()` or `-std()` in their names and using the results to subset the merged data frame. The resulting data set includes 66 "feature variables", (along with two additional columns containing the subject and activity ID codes).
 
3. The ActivityID codes are replaced with the descriptive activity names (`LAYING`, `SITTING`, `STANDING`, `WALKING`, `WALKING_DOWNSTAIRS`, `WALKING_UPSTAIRS`) contained in the `activity_labels.txt` file.
 
4. The data set is labeled with descriptive variable names. The "feature variables" are renamed to adhere to the following conventions:
  * `All lower case when possible` - because the variable names would be unreadable if converted to all lower case, `camlCase` is used as an alternative as is acceptable according to [Google's R Style Guide](http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml).
  * `Descriptive (Diagnosis versus Dx)` - all abreviations (with the exceptions of `StdDev` used for standard deviation and `freq` used for frequency) are converted to full words (i.e. t="Time", Gyro="Gyroscope", Acc="Accelerometer", and Mag="Magnitude).
  * `Not duplicated` - duplicates are not present in the subset of feature variables, so no transformations are required to comply with this rule.
  * `Not have underscores or dots or white spaces` - dashes and parentheses are removed from the feature variable names.

5. An independent tidy data set is created that calculates the average of each variable for each subject and each activity. This is accomplished using the `ddply` function from the `plyr` package which is required in order to successfully run the `run_analysis.R` script.

Please refer to the inline documentation included in `run_analysis.R` for detailed comments describing each step in the transformation.

## Variables

The `tidyDataAverages.txt` data file uses the following variables:

**Column 1:** SubjectID
* A unique identifier assigned to each subject
* Values: integers 1 to 30

**Column 2:** Activity
* A character variable identifying the type of activity measured.
* Values: `LAYING`, `SITTING`, `STANDING`, `WALKING`, `WALKING_DOWNSTAIRS`, `WALKING_UPSTAIRS`

**Columns 3-68:** Feature Variables (see naming conventions below)
* A numerical variable measuring either the average mean or standard deviation by subject and activity
* Values: numerical value of either a) average mean or b) average standard deviation

For columns 3 through 68, variable names are constructed as follows:

```
<measurement><Signal><Source><Jerk><Magnitude><Type><Axis>
```

`measurement` denotes the type of measurement domain signal. Values are `time` or `freq` (frequency).

`Signal` denotes the acceleration signal. Values are `Body` or `Gravity`.

`Source` denotes the measurement source. Values are `Accelerometer` or `Gyroscope`.

`Jerk` is included in variable name only if jerk signals were derived. This variable name component may or may not be present. Value is `Jerk`.

`Magnitude` is included only in variable names where magnitude was calculated. This variable name component may or may not be present. Value is `Magnitude`.

`Type` denotes the type of variable estimated from the measured signals. Values are `Mean` or `StdDev` (standard deviation).

`Axis` denotes the axis of movement on which the measurement was taken. This variable name component may or may not be present. Values are `X`, `Y`, or `Z`.

### Complete List of Descriptive Variable Names:

```
 [1] "SubjectID"                               
 [2] "Activity"                                
 [3] "timeBodyAccelerometerMeanX"              
 [4] "timeBodyAccelerometerMeanY"              
 [5] "timeBodyAccelerometerMeanZ"              
 [6] "timeBodyAccelerometerStdDevX"            
 [7] "timeBodyAccelerometerStdDevY"            
 [8] "timeBodyAccelerometerStdDevZ"            
 [9] "timeGravityAccelerometerMeanX"           
[10] "timeGravityAccelerometerMeanY"           
[11] "timeGravityAccelerometerMeanZ"           
[12] "timeGravityAccelerometerStdDevX"         
[13] "timeGravityAccelerometerStdDevY"         
[14] "timeGravityAccelerometerStdDevZ"         
[15] "timeBodyAccelerometerJerkMeanX"          
[16] "timeBodyAccelerometerJerkMeanY"          
[17] "timeBodyAccelerometerJerkMeanZ"          
[18] "timeBodyAccelerometerJerkStdDevX"        
[19] "timeBodyAccelerometerJerkStdDevY"        
[20] "timeBodyAccelerometerJerkStdDevZ"        
[21] "timeBodyGyroscopeMeanX"                  
[22] "timeBodyGyroscopeMeanY"                  
[23] "timeBodyGyroscopeMeanZ"                  
[24] "timeBodyGyroscopeStdDevX"                
[25] "timeBodyGyroscopeStdDevY"                
[26] "timeBodyGyroscopeStdDevZ"                
[27] "timeBodyGyroscopeJerkMeanX"              
[28] "timeBodyGyroscopeJerkMeanY"              
[29] "timeBodyGyroscopeJerkMeanZ"              
[30] "timeBodyGyroscopeJerkStdDevX"            
[31] "timeBodyGyroscopeJerkStdDevY"            
[32] "timeBodyGyroscopeJerkStdDevZ"            
[33] "timeBodyAccelerometerMagnitudeMean"      
[34] "timeBodyAccelerometerMagnitudeStdDev"    
[35] "timeGravityAccelerometerMagnitudeMean"   
[36] "timeGravityAccelerometerMagnitudeStdDev"                                         
[37] "timeBodyAccelerometerJerkMagnitudeMean"  
[38] "timeBodyAccelerometerJerkMagnitudeStdDev"                                                     
[39] "timeBodyGyroscopeMagnitudeMean"          
[40] "timeBodyGyroscopeMagnitudeStdDev"        
[41] "timeBodyGyroscopeJerkMagnitudeMean"      
[42] "timeBodyGyroscopeJerkMagnitudeStdDev"    
[43] "freqBodyAccelerometerMeanX"              
[44] "freqBodyAccelerometerMeanY"              
[45] "freqBodyAccelerometerMeanZ"              
[46] "freqBodyAccelerometerStdDevX"            
[47] "freqBodyAccelerometerStdDevY"            
[48] "freqBodyAccelerometerStdDevZ"            
[49] "freqBodyAccelerometerJerkMeanX"          
[50] "freqBodyAccelerometerJerkMeanY"          
[51] "freqBodyAccelerometerJerkMeanZ"          
[52] "freqBodyAccelerometerJerkStdDevX"        
[53] "freqBodyAccelerometerJerkStdDevY"        
[54] "freqBodyAccelerometerJerkStdDevZ"        
[55] "freqBodyGyroscopeMeanX"                  
[56] "freqBodyGyroscopeMeanY"                  
[57] "freqBodyGyroscopeMeanZ"                  
[58] "freqBodyGyroscopeStdDevX"                
[59] "freqBodyGyroscopeStdDevY"                
[60] "freqBodyGyroscopeStdDevZ"                
[61] "freqBodyAccelerometerMagnitudeMean"      
[62] "freqBodyAccelerometerMagnitudeStdDev"    
[63] "freqBodyAccelerometerJerkMagnitudeMean"  
[64] "freqBodyAccelerometerJerkMagnitudeStdDev"
[65] "freqBodyGyroscopeMagnitudeMean"          
[66] "freqBodyGyroscopeMagnitudeStdDev"        
[67] "freqBodyGyroscopeJerkMagnitudeMean"      
[68] "freqBodyGyroscopeJerkMagnitudeStdDev"
```
