dir <- 'R/R Programming/ProgrammingAssignment3/'

outcomeDF <- read.csv('R Programming/ProgrammingAssignment3/outcome-of-care-measures.csv', colClasses="character")
str(outcomeDF)
outcomeDF[,11] <- as.numeric(outcomeDF[,11])
outcomeDF[,17] <- as.numeric(outcomeDF[,17])
outcomeDF[,23] <- as.numeric(outcomeDF[,23])
outcomeDF[,23] <- outcomeDF[complete.cases(outcomeDF[,23])
min(outcomeDF[,11])
ncol(outcomeDF)

summary(outcomeDF[,11])
## BEST Function


best <- function(state, outcome){
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
  ## Return hospital name in the state with lowest 30-day death rate
   if (outcome == 'heart attack') {
     # define min mortality rate for heart attack
     mmr = min(outcomeDF[,"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"][outcomeDF['State'] == state], na.rm=T)
     hospital <- subset(outcomeDF, State == state & Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == mmr, select=Hospital.Name)
   } else if (outcome == 'heart failure') {
     # define min mortality rate for heart failure
     mmr = min(outcomeDF["Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"][outcomeDF['State'] == state], na.rm=T)
     hospital <- subset(outcomeDF, State == state & Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == mmr, select=Hospital.Name)
   } else {
     # define min mortality rate for pneumonia
     mmr = min(outcomeDF["Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"][outcomeDF['State'] == state], na.rm=T)
     hospital <- subset(outcomeDF, State == state & Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == mmr, select=Hospital.Name)
   }
   # order alphabetically
   hospital<-hospital[order(hospital['Hospital.Name']),]
   hospital[1]
}

best("NY","heart attack")

## RANKHOSPITAL function

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

rankhospital("TX", "heart failure", '4')

rankhospital("MD", "heart attack", 'worst')

rankhospital("MN", "heart attack", 5000)

## RANKALL function

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

head(rankall("heart attack", 20), 10)

tail(rankall("pneumonia", "worst"), 3)

tail(rankall("heart failure"), 10)


# Assignment

best("SC", "heart attack")
best("NY", "pneumonia")

best("AK", "pneumonia")

rankhospital("NC", "heart attack", "worst")

rankhospital("WA", "heart attack", 7)

rankhospital("TX", "pneumonia", 10)

rankhospital("NY", "heart attack", 7)


rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)


rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

rankall("heart failure", 10)

as.character(subset(r, state == "NV")$hospital)
