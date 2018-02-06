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
