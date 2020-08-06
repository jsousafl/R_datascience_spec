rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  all_possible_states <- unique(outcome_data$State)
  all_possible_outcomes <- c("heart attack","heart failure","pneumonia")
  
  if(!(is.element(state,all_possible_states))) {
    stop("invalid state")
  }
  if(!is.element(outcome,all_possible_outcomes)) {
    stop("invalid outcome")
  }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  # Create a vector with the index of the columns of interest
  interest_colnums <- c(11,17,23)
  
  # Use the vectors all_possible_outcomes and interest_colnums
  # in order to select the index that matches with the selected outcome
  col_outcome <- interest_colnums[which(outcome==all_possible_outcomes)]
  
  # Filter original data using state information
  outcome_data_state <- outcome_data[outcome_data$State == state,]
  
  # Transform character data into numeric
  outcome_data_state[, col_outcome] <- suppressWarnings(as.numeric(outcome_data_state[, col_outcome]))
  
  # Exclude the hospitals that do not have data on the outcome
  complete_rows <- complete.cases(outcome_data_state[, col_outcome])
  outcome_data_state <- outcome_data_state[complete_rows,]
  
  # Order filtered data frame using outcome criteria and hospital name
  ord_outcome_data <- outcome_data_state[order(outcome_data_state[,col_outcome],outcome_data_state$Hospital.Name),]
  
  ## Check that num is valid
  all_possible_num <- c(1:nrow(ord_outcome_data),"best","worst")
  if(!is.element(num,all_possible_num)) {
    return(NA)
  }
  rank_ind<-num
  if(num == "best") {
    rank_ind <- 1
  }
  if(num == "worst") {
    rank_ind <- nrow(ord_outcome_data)
  }
  ord_outcome_data$Hospital.Name[rank_ind]
}