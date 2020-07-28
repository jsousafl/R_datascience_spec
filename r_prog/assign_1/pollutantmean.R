pollutantmean<- function(directory,pollutant,id=1:332) {
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
  #Filter NA cases and return mean
  good_rows <- complete.cases(air_pol_df)
  filtered_airpol_df <-air_pol_df[good_rows,]
  mean(filtered_airpol_df[,pollutant])

}
