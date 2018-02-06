rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeDF <- read.csv('R Programming/ProgrammingAssignment3/outcome-of-care-measures.csv', colClasses="character")
  outcomeDF[,11] <- as.numeric(outcomeDF[,11])
  outcomeDF[,17] <- as.numeric(outcomeDF[,17])
  outcomeDF[,23] <- as.numeric(outcomeDF[,23])
  ## Check that state and outcome are valid
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) {
    stop("Invalid Outcome")
  }
  ## For each state, find the hospital of the given rank
  if (outcome == 'heart attack') {
    # define max mortality rate for heart attack
    hospital <- subset(outcomeDF, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,State))
  } else if (outcome == 'heart failure') {
    # define max mortality rate for heart failure
    hospital <- subset(outcomeDF, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,State))
  } else {
    # define max mortality rate for pneumonia
    hospital <- subset(outcomeDF, select=c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,State))
  }
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  hospital<-hospital[order(hospital[3],hospital[2],hospital[1]),]

  if (num == 'best') {
    hospital$rank <- unlist(with(hospital,tapply(hospital[[2]], hospital['State'], function (x) rank(x,ties.method= "first"))))
    hospital<-hospital[order(hospital[3],hospital[2],hospital[1]),]
    hospital <- hospital[hospital$rank == 1,]
  } else if (num == 'worst') {
    hospital$rank <- ave(-hospital[,2], hospital$State, FUN=rank)
    hospital<-hospital[order(hospital[3],hospital[2],hospital[1]),]
    hospital <- hospital[hospital$rank == 1,]
  } else {
    hospital$rank <- unlist(with(hospital,tapply(hospital[[2]], hospital['State'], function (x) rank(x,ties.method= "first"))))
    hospital<-hospital[order(hospital[3],hospital[2],hospital[1]),]
    hospital <- hospital[hospital$rank == num,]
  }
  hospital
}
