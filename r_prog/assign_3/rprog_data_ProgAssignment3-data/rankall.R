rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that outcome is valid
  all_possible_outcomes <- c("heart attack","heart failure","pneumonia")
  
  if(!is.element(outcome,all_possible_outcomes)) {
    stop("invalid outcome")
  }
  ## For each state, find the hospital of the given rank
  
  #Create empty data frame
  name_state_df<-data.frame(matrix(ncol = 2, nrow = 0))
  options(stringsAsFactors=FALSE)
  
  # Create a vector with the index of the columns of interest
  interest_colnums <- c(11,17,23)
  
  # Use the vectors all_possible_outcomes and interest_colnums
  # in order to select the index that matches with the selected outcome
  col_outcome <- interest_colnums[which(outcome==all_possible_outcomes)]
  
  all_possible_states <- unique(outcome_data$State)
  
  # Transform character data into numeric
  outcome_data[, col_outcome] <- suppressWarnings(as.numeric(outcome_data[, col_outcome]))
  
  for(state_lett in sort(all_possible_states)) {
    
    # Filter original data using state information
    outcome_data_state <- outcome_data[outcome_data$State == state_lett,]
    
    # Exclude the hospitals that do not have data on the outcome
    complete_rows <- complete.cases(outcome_data_state[, col_outcome])
    outcome_data_state <- outcome_data_state[complete_rows,]
    
    # Order filtered data frame using outcome criteria and hospital name
    ord_outcome_data <- outcome_data_state[order(outcome_data_state[,col_outcome],outcome_data_state$Hospital.Name),]

    ## Check that num is valid and find hospital name
    all_possible_num <- c(1:nrow(ord_outcome_data),"best","worst")
    if(!is.element(num,all_possible_num)) {
      hosp_name <- NA
    }
    else {
      rank_ind<-num
      if(num == "best") {
        rank_ind <- 1
      }
      if(num == "worst") {
        rank_ind <- nrow(ord_outcome_data)
      }
      hosp_name <- ord_outcome_data$Hospital.Name[rank_ind]
    }
    name_state_df <- rbind(name_state_df,c(hosp_name,state_lett))
  }
  colnames(name_state_df) <- c("hospital","state")
  rownames(name_state_df) <- name_state_df$state
  ## Return a data frame with the hospital names
  ## and the (abbreviated) state name
  name_state_df
}