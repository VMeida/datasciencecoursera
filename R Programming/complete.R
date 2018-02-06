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
    #  get complete cases
    data <- data[complete.cases(data),]

    # return dataframe with id and frequency of complete cases
    as.data.frame(table(data['ID']))
}
