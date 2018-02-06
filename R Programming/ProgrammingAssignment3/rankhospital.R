rankhospital <- function(state, outcome, num = 'best'){
  ## Read outcome data
  outcomeDF <- read.csv('R Programming/ProgrammingAssignment3/outcome-of-care-measures.csv', colClasses="character")
  outcomeDF[,11] <- as.numeric(outcomeDF[,11])
  outcomeDF[,17] <- as.numeric(outcomeDF[,17])
  outcomeDF[,23] <- as.numeric(outcomeDF[,23])
  ## Check that state and outcome are valid
  if (!(state %in% outcomeDF[["State"]])) {
    stop("Invalid State")
  } else if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
    stop("Invalid Outcome")
  }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (outcome == 'heart attack') {
    # define max mortality rate for heart attack
    hospital <- subset(outcomeDF, State == state, select=c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    hospital<-hospital[order(hospital['Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack'],hospital['Hospital.Name']),]
  } else if (outcome == 'heart failure') {
    # define max mortality rate for heart failure
    hospital <- subset(outcomeDF, State == state, select=c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    hospital<-hospital[order(hospital['Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure'],hospital['Hospital.Name']),]
  } else {
    # define max mortality rate for pneumonia
    hospital <- subset(outcomeDF, State == state, select=c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    hospital<-hospital[order(hospital['Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia'],hospital['Hospital.Name']),]
  }
  # order alphabetically

  hospital <- hospital[complete.cases(hospital[2]),]
  if (num == 'best') {
    hospital <- head(hospital, 1)
  } else if (num == 'worst') {
    hospital <- tail(hospital, 1)
  } else {
    hospital <- hospital[num,]
  }
  hospital
}
