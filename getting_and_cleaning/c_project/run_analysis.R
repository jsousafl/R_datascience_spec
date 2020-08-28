run_analysis <- function() {
  
  # 1. Merges the training and the test sets to create one data set
  #Reading the x data
  x_test_data <-read.table("UCI HAR Dataset/test/X_test.txt")
  x_train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
  #Reading the y data
  y_test_data <-read.table("UCI HAR Dataset/test/y_test.txt")
  y_train_data <- read.table("UCI HAR Dataset/train/y_train.txt")
  #Reading subject test data
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  
  #Merge all data into one data set
  testDataSet <- cbind(subject_test,y_test_data,x_test_data)
  trainDataSet <- cbind(subject_train,y_train_data,x_train_data)
  mergedTTDS <- rbind(testDataSet,trainDataSet)
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement
  # Reading features names
  namesFeat <- read.table("UCI HAR Dataset/features.txt")
  
  tomatch <- c("mean\\(\\)","std\\(\\)")
  idmatches <- unique(grep(paste(tomatch,collapse = "|"),namesFeat$V2,ignore.case = TRUE))
  mergedTTDS_filt <- mergedTTDS[,c(1,2,idmatches+2)]
  
  # 3. Uses descriptive activity names to name the activities in the data set
  namesFeat_meanstd<-namesFeat[idmatches,]
  namesFeat_meanstd$V2<-gsub("-","",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("[()]","",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("t(.*)Acc","time_\\1_acceleration_",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("f(.*)Acc","frequency_\\1_acceleration_",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("t(.*)Gyro","time_\\1_angular_velocity_",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("f(.*)Gyro","frequency_\\1_angular_velocity_",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("Jerk","jerk_",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("Mag","magnitude_",namesFeat_meanstd$V2)
  namesFeat_meanstd$V2<-gsub("BodyBody","Body",namesFeat_meanstd$V2)
  
  names(mergedTTDS_filt)<-c("Subject_ID","Activity_Label",namesFeat_meanstd$V2)
  
  # 4. Appropriately labels the data set with descriptive variable names
  levelstr<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
  mergedTTDS_filt$`Activity_Label` <- cut(mergedTTDS_filt$`Activity_Label`,6,labels = levelstr)
  
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  idActivity_summary <- mergedTTDS_filt %>% group_by(Subject_ID,Activity_Label) %>% summarize_all(list(~ mean(., na.rm = TRUE)))
  
  return_list <- list(datasetFilt = mergedTTDS_filt, datasetSumm = idActivity_summary)
  return(return_list)
}