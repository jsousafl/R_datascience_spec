source("complete.R")
corr<-function(directory,threshold = 0) {
  #Use complete function in order to filter ids
  #that are greater than the threshold
  nobs_df<-complete(directory)
  filtered_nobs_df<-nobs_df[nobs_df$nobs>threshold,]
  if(nrow(filtered_nobs_df)==0) {
    return(numeric())
  }
  #Getting monitors that passed the threshold filter
  id = filtered_nobs_df[,"ids"]
  #Generate filename in the right format 
  ids_filenames<-paste(directory,"/",formatC(id,width = 3,flag="0"),".csv",sep = "")
  
  #Setup column classes to improve read.csv speed
  colCl <- c("Date","numeric","numeric","numeric")
  
  #Create empty data frame
  air_pol_df<-data.frame()
  
  #Iterate for all ids
  for(file in ids_filenames) {
    #Bind new data to data frame
    air_pol_df<-rbind(air_pol_df,read.csv(file,colClasses = colCl,comment.char = ""))
  }
  #Filter NA cases 
  good_rows <- complete.cases(air_pol_df)
  filtered_airpol_df <-air_pol_df[good_rows,]
  
  cor_vec <- numeric()
  for(i in id) {
    x<-filtered_airpol_df[filtered_airpol_df$ID==i,"sulfate"]
    y<-filtered_airpol_df[filtered_airpol_df$ID==i,"nitrate"]
    cor_vec <- c(cor_vec,cor(x,y))
  }
  cor_vec
}