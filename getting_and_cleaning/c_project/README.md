# DATA ANALYSIS PROCESS – 2020 SAMSUNG DATA ANALYSIS (GETTING AND CLEANING DATA COURSERA – JOÃO VITOR SOUSA FLORIANO)

### ORIGINAL DATASET DESCRIPTION/CONTEXT

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

### ANALYSIS DATASET DESCRIPTION

The data described above was used at the final project in the course Getting and Cleaning Data with the goal of: **create a tidy data set with the average of each variable (containing the measurements on the mean and standard deviation for each inertial measure) for each activity and each subject**.

The following steps were used in order to process the Samsung data into the output dataset:


1. The .txt files containing the train and test data inside the UCI HAR Dataset folder are open and read with the help of the read.table function;
2. All the data is merged into a unique data frame with the help of the cbind and rbind functions;
3. The extraction of the measurements only on the mean and standard deviation features is made with the help of Regular Expressions:
       
    a) Features names are read with read.table
    
    b) The index of the columns containing the strings “mean()” and “std()” are found with the grep function
    
    c) The original merged dataset is filtered with column indexing
           
4. The files features_info.txt and features.txt inside the UCI HAR Dataset folder were analysed in order to understand the meaning of each one of the columns in the filtered dataset. This being said, those features were better desribed with the help of Regular Expression and the gsub command. (PS: Line 37 “BodyBody” only exists with the folder version given in the link course – the data in the dataset site has different and updated names)
5. The activities numbers are replaced by their names with the help of the cut() function
6. Finally, the functions group_by and summarize of the dplyr package are used in order to creates a second, independent tidy data set with the average of each variable for each activity and each subject
