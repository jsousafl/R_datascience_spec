best <- function(state, outcome) {
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
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
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
  
  # Filter hospital names with minimum outcome value
  allmin_names <- outcome_data_state$Hospital.Name[which(outcome_data_state[,col_outcome]==min(outcome_data_state[,col_outcome]))]
  
  # Order by alphabetical
  allmin_names <- allmin_names[order(allmin_names)]
  
  # Return final object
  allmin_names[1]
  }