# Codebook for `tidyDataAverages.txt`

## Original Data

The original data used to generate `tidyDataAverages.txt` was obtained from the UCI Machine Learning Repository and contains data "from the recordings of 30 subjects 

performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors" (http://archive.ics.uci.edu/ml/datasets/Human+Activity

+Recognition+Using+Smartphones).

The original data can be obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

For a full description of the original data set, please refer to the `READMe.txt` and `features_info.txt` files contined within the zipped data set.

## Data Transformations

The tidy data file (`tidyDataAverages.txt`) was generated using the `run_analysis.R` script included in this repository. 

The script makes the following transformations from the original data set:

1. The training and test data sets are merged together to create one data set by first reading in the `subject_test.txt`, `X_test`, `y_test`, `subject_train.txt`, `X_train.txt`, and `y_train.txt` files and then using `cbind` and `rbind` functions to combine them together.

2. The combined data set is subset to retain only the columns that measure mean or standard deviation. This is accomplished by using a regular expression to identify the variables in the `features.txt` file that contain either `-mean()` or `=std()` in their names and using the results to subset the merged data frame. The resulting data set includes 66 "feature variables", (along with two additional columns containing the subject and activity ID codes).
 
3. The ActivityID codes are replaced with the descriptive activity names (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`,  `SITTING`, `STANDING`, `LAYING`) contained in the `activity_labels.txt` file.
 
4. The data set was labeled with descriptive variable names. The "feature variables" were renamed and adhere to the following conventions:
..* `All lower case when possible` - because the variable names would be unreadable if converted to all lower case, `camlCase` was used as an alternative as is acceptable according to [Google's R Style Guide](http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml).
..* `Descriptive (Diagnosis versus Dx)` - all abreviations (with the acceptions of `StdDev` used for standard deviation and `freq` used for frequency) were converted to full words (i.e. t="Time", Gyro="Gyroscope", Acc="Accelerometer", and Mag="Magnitude).
..* `Not duplicated` - duplicates were not present in the subset of feature variables, so not transformations were required to comply with this rule.
..* `Not have underscores or dots or white spaces` - dashes and parentheses are removed from the feature variable names.

5. An independent tidy data set is created that calculates the average of each variable for each subject and each activity. This is accomplished using the ddply function from the plyr package which is required in order to successfully run the `run_analysis.R` script.

Please refer to the inline documentation included in `run_analysis.R` for detailed comments describing each step in the transformation.

## Variables