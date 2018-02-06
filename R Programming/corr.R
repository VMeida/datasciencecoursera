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
