#####Assignment#####
###You should create one R script called run_analysis.R that does the following.
#1) Merges the training and the test sets to create one data set.
#2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#3) Uses descriptive activity names to name the activities in the data set
#4) Appropriately labels the data set with descriptive variable names. 
#5) From the data set in step 4, creates a second, independent tidy data set with the average of
#   each variable for each activity and each subject.

#####Set the working directory (relevant to my directory file)#####
if (!file.exists("C:/Users/Brad/Documents/RCoursera/GettingData/PROJECT")) {
  dir.create("C:/Users/Brad/Documents/RCoursera/GettingData/PROJECT", recursive = TRUE)
}
if (getwd() != "C:/Users/Brad/Documents/RCoursera/GettingData/PROJECT") {
  setwd("C:/Users/Brad/Documents/RCoursera/GettingData/PROJECT")
}

#####Getting and Preprocessing#####
####Get Data####
today <- as.Date(Sys.time())
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "UCI HAR Dataset.zip")
har <- unzip("UCI HAR Dataset.zip")

####Preprocess Data####
###Train Data###
##Train data with 7352 obs. of  561 variables (foundation of the train dataframe)
train_main <- read.table("UCI HAR Dataset/train/X_train.txt")
##Train activity labels describing which of six activities for each observation with
# 7352 obs. of  1 variable.
##Can be appended to "train_main" with cbind.
##To satisfy assignment condition #3, integer values in "train_act" will need to be converted to
# corresponding character values from "activity_labels.txt".
train_act <- read.table("UCI HAR Dataset/train/y_train.txt")
##Subject ID variable: each row corresponds to an observation in the train data (train_main),
# identifying by number which of 30 subjects corresponds to that observation.
# 7352 obs. of  1 variable.
##Can be appended to "train_main" with cbind.
train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")

###Test data###
##Test data with 2947 obs. of  561 variables (foundation of the test dataframe)
test_main <- read.table("UCI HAR Dataset/test/X_test.txt")
##Test activity labels describing which of six activities for each observation with
# 2947 obs. of  1 variable.
##Can be appended to "test_main" with cbind.
##To satisfy assignment condition #3, integer values in "test_act" will need to be converted to
# corresponding character values from "activity_labels.txt".
test_act <- read.table("UCI HAR Dataset/test/y_test.txt")
##Subject ID variable: each row corresponds to an observation in the test data (test_main),
# identifying by number which of 30 subjects corresponds to that observation.
# 2947 obs. of  1 variable.
##Can be appended to "test_main" with cbind.
test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")

###Support data applicable to train and test data###
##Features or measurements for each observation (561 x 2).
##There are 561 different features, which are descriptive names corresponding to the 561 variables
# in the train ("train_main") as well as test ("test_main") data.
##Can be extracted and placed as variable names for "*_main" to satisfy assignment condition #4.
features <- read.table("UCI HAR Dataset/features.txt")
##Descriptive activities (six types) which correspond to the numbers listed in
# "train_act" and "test_act".
##To satisfy assignment condition #3, the activities herein can be supplemented for corresponding
# integer values in "train_act" and "test_act".
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

####Process the data to satisfy the assignment conditions####
#1) Merge the training and the test sets to create one data set.
##Bind activity and subject vectors to main dataframes
train_fin <- cbind(as.vector(train_subj), as.vector(train_act), train_main)
test_fin <- cbind(as.vector(test_subj), as.vector(test_act), test_main)
##Bind "test_fin" to "train_fin".
samsung <- rbind(train_fin, test_fin)

#2) Extracts only the measurements on the mean and standard deviation for each measurement.
##Extract only the measurements on the mean and standard deviation for each measurement
selected <- grep("mean|std", features$V2)
##After some analysis of the variables which have the words "mean" and "std" in them, there is a
# group of variables which measure "mean frequencies" for corresponding directions (x, y, z).
# There are not measurements for the standard deviation of frequencies.  Since the assignment
# calls for "extracting only the measurements on the mean and standard deviation for each
# measurement," it is decided to exclude mean frequencies, which are really
# calculations rather than measurements and which do not have a corresponding standard deviation.
exclude <- grep("Freq", features$V2)
refined <- setdiff(selected, exclude) 
samsung <- cbind(samsung[,1:2], samsung[,refined+2])

#3) Use descriptive activity names to name the activities in the data set
##Replace activity integer labels with descriptive activity names
samsung[,2] <- as.character(samsung[,2])
for(i in 1:nrow(samsung)){
  for(j in 1:nrow(activities)){
    if(samsung[i,2] == as.character(activities$V1[j])){
      samsung[i,2] <- as.character(activities$V2[j])
    }
  }
}

#4) Appropriately label the data set with descriptive variable names.
##After the scripts in this section are run, the "samsung" data.frame will satisfy all assignment
# requirements 1 - 4.
nams <- as.character(features$V2[refined])
nams <- c("subject", "activity", nams)
names(samsung) <- nams

####Tests to see if data is as it should be- comparing raw data to refined data####
##Tests below are comparisons of random blocks of refined data to corresponding raw data.
##All tests are supportive.  #'s placed in front of lines to suppress output.
#qual1 <- train_main[1:10,refined]
#qual2 <- samsung[1:10,3:ncol(samsung)]
#qual1 == qual2
##Round 2
#qual3 <- test_main[2560:2570,refined]
#mn <- nrow(train_main) + 2560
#mx <- nrow(train_main) + 2570
#qual4 <- samsung[mn:mx,3:ncol(samsung)]
#qual3 == qual4

#5) From the data set in step 4, create a second, independent tidy data set with the average of
#   each variable for each activity and each subject.
##The following steps in this section will create a data.frame called "tidy_data" which will
# satisfy all assignment conditions 1 - 5.
tidy <- aggregate(samsung[,3:ncol(samsung)],
                  by = list("subject" = factor(samsung$subject),
                            "activity" = factor(samsung$activity)), mean)
tidy_data <- with(tidy, tidy[order(subject, activity),])

##Write to text file relevant to my personal directory.
write.table(tidy_data,
            file = "C:/Users/Brad/Documents/RCoursera/GettingData/PROJECT/tidy_data.txt",
            row.names = FALSE)

