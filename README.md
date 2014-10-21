GettingDataProject
==================

Getting and Cleaning Data Project which combines and aggregates data from Human Activity Recognition Using Smartphone Dataset.

****README for data set "tidy_data.txt"****

****Brief summary description of "tidy_data.txt"****
"tidy_data.txt" is a data set which is derived from "Human Activity Recognition Using Smartphones
 Dataset" by Jorge L. Reyes-Ortiz, et al., downloaded from <https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.[1]

"tidy_data.txt" is written to satisfy the requirements of a project with the following conditions:
  You should create one R script called run_analysis.R that does the following. 
  1) Merges the training and the test sets to create one data set.
  2) Extracts only the measurements on the mean and standard deviation for each measurement. 
  3) Uses descriptive activity names to name the activities in the data set
  4) Appropriately labels the data set with descriptive variable names. 
  5) From the data set in step 4, creates a second, independent tidy data set with the average of
     each variable for each activity and each subject.

For more details on the project assignment, see below under heading "Project details."

"tidy_data.txt" extracts and uses data from "features.txt", "activity_labels.txt", "X_train.txt",
"y_train.txt", "subject_train.txt", "X_test.txt", "y_test.txt", and "subject_test.txt".

There are 66 measurements of means and corresponding standard deviations selected from the 561 features or variables from the raw data (variables in the raw data files "X_train.txt" and "X_test.txt" and listed by name in corresponding order in the raw data file "features.txt") "tidy_data.txt" simply extracts only those 66 variables which are means and corresponding standard deviations of measurements taken.  "tidy_data" then takes aggregate means of those 66 variables by subject and activity type.  Each observation of tidy data is a vector of the means of the 66 variables extracted from the raw data, by subject and activity.  The first two variables in "tidy_data.txt" are "subject" and "activity" in order.  The final 66 variables are the aggregate means previously explained.  There are 30 individual subjects and six activity types, so there are (30 * 6) = 180 total observations.

----Technical file info----
Observations: 180
Variables: 68
Structure: 180 rows of observations by 68 column/variables.
Data details: each of tidy_data[1:180,3:68] is an aggregate mean of the corresonding variable from
the raw data by subject and activity.  Read above under the summary heading for further explanation.
Note that the variables 3:68 correspond to the following "features" or variables from the raw data set: 

1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86 121 122 123 124 125 126 161
162 163 164 165 166 201 202 214 215 227 228 240 241 253 254 266 267 268 269 270 271 345 346 347 348
349 350 424 425 426 427 428 429 503 504 516 517 529 530 542 543

----Further explanation----
"tidy_data.txt" is created with the script "run_analysis.R"  which is close to self-contained with code and description.  All description precedes code and follows '#' signs according to rank (heading, subheading, continued line, etc.)

For further details of the structure and contents of "tidy_data.txt", see "tidy_data_code_book.txt".

----Project details----
"tidy_data.txt" and the corresponding script "run_analysis.R" are meant to satisfy the project requirement for the course, Getting and Cleaning Data by Jeff Leek, PhD, Brian Caffo, PhD, and Roger D. Peng, PhD of Johns Hopkins School of Public Health via Coursera, offered October 6 through November 3 of 2014.
Course link: <https://www.coursera.org/course/getdata>
Data link: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

----Citations----
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
<https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
