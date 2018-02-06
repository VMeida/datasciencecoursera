dir <- 'R/R Programming/ProgrammingAssignment3/'

best <- function(state, outcome){
  ## Read outcome data
  outcomeDF <- read.csv('R/R Programming/ProgrammingAssignment3/outcome-of-care-measures.csv', colClasses="character")
  outcomeDF[,11] <- as.numeric(outcomeDF[,11])
  outcomeDF[,17] <- as.numeric(outcomeDF[,17])
  outcomeDF[,23] <- as.numeric(outcomeDF[,23])
  ## Check that state and outcome are valid
  if (!(state %in% outcomeDF[["State"]])) {
    stop("Invalid State")
  } else if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
    stop("Invalid Outcome")
  }
  ## Return hospital name in the state with lowest 30-day death rate
   if (outcome == 'heart attack') {
     # define max mortality rate for heart attack
     ha <- subset(outcomeDF, State == state, select=Hospital.Name)
     mmr = min(as.numeric(outcomeDF[,"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"])[outcomeDF['State'] == state], na.rm=T)
     hospital <- subset(outcomeDF, State == state & Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == mmr, select=Hospital.Name)
   } else if (outcome == 'heart failure') {
     # define max mortality rate for heart failure
     mmr = min(outcomeDF["Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"][outcomeDF['State'] == state], na.rm=T)
     hospital <- subset(outcomeDF, State == state & Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == mmr, select=Hospital.Name)
   } else {
     # define max mortality rate for pneumonia
     mmr = min(outcomeDF["Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"][outcomeDF['State'] == state], na.rm=T)
     hospital <- subset(outcomeDF, State == state & Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == mmr, select=Hospital.Name)
   }
   # order alphabetically
   hospital<-hospital[order(hospital['Hospital.Name']),]
   hospital[1]
}
