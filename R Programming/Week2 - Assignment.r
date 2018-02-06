dir <- 'R Programming/specdata/'

pollutantmean <- function(directory,pollutant,id = 1:332) {
    # load data
    files <- list.files(path=directory, pattern="*.csv", full.name=TRUE)
    data <- data.frame(
        Date = character(),
        sulfate = character(),
        nitrate = character(),
        ID = character()
    )
    for (i in id) {
        df <- read.csv(files[i])
        data <- rbind(df, data)
    }

    # get pollutant data clean NA values
    data <- data[[pollutant]]
    cleaned <- data[complete.cases(data)]
    # get mean value
    mean(cleaned)
}


complete <- function(directory, id=1:332){
    # load data
    files <- list.files(path=directory, pattern="*.csv", full.name=TRUE)
    data <- data.frame(
        Date = character(),
        sulfate = character(),
        nitrate = character(),
        ID = character()
    )
    for (i in id) {
        df <- read.csv(files[i])
        data <- rbind(df, data)
    }
    # get complete cases
    data <- data[complete.cases(data),]

    # return dataframe with id and frequency of complete cases
    as.data.frame(table(data['ID']))
}

corr <- function(directory, threshold = 0){

    # load data
    files <- list.files(path=directory, pattern="*.csv", full.name=TRUE)
    data <- data.frame(
        Date = character(),
        sulfate = character(),
        nitrate = character(),
        ID = character()
    )
    for (i in 1:332) {
        df <- read.csv(files[i])
        data <- rbind(df, data)
    }
    # get complete cases
    data <- data[complete.cases(data),]

    # get complete cases thresholds
    th <- as.data.frame(table(data['ID']))
    th <- as.integer(th[1][th[2] > threshold])

    # filter cases per threshold
    data <- data.frame(
        Date = character(),
        sulfate = character(),
        nitrate = character(),
        ID = character()
    )
    for (i in th) {
        df <- read.csv(files[i])
        data <- rbind(df, data)
    }
    data <- data[complete.cases(data),]

    # make correlations per monitor vector
    vector <- c()
    for (i in th) {
        vector <-c(vector,cor(data['sulfate'][data['ID'] == i], data['nitrate'][data['ID'] == i]))
    }
    vector
}

cr <- corr(dir, 5000)

# QUIZ

pollutantmean(dir, "sulfate", 1:10)

pollutantmean(dir, "nitrate", 70:72)

pollutantmean(dir, "sulfate", 34)

pollutantmean(dir, "nitrate")

cc <- complete(dir, c(6, 10, 20, 34, 100, 200, 310))
print(cc$Freq)

cc <- complete(dir, 54)
print(cc$Freq)

set.seed(42)
cc <- complete(dir, 332:1)
use <- sample(332, 10)
print(cc[use, "Freq"])

cr <- corr(dir)
cr <- sort(cr)
set.seed(868)
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr(dir, 129)
cr <- sort(cr)
n <- length(cr)
set.seed(197)
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr(dir, 2000)
n <- length(cr)
cr <- corr(dir, 1000)
cr <- sort(cr)
print(c(n, round(cr, 4)))
