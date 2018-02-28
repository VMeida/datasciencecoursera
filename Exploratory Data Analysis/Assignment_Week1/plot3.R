# Load Libraries
library(lubridate)
library(dplyr)

getwd()

# Loads table within data folder
df_read <- read.table("./Exploratory Data Analysis/Data/household_power_consumption.txt", sep=';', header=TRUE)
df <- tbl_df(df_read)

#Initial exporatory phase

head(df)
str(df)
summary(df)

# Transforming column Date to Date format and filtering the required dates:
df$Datetime <- paste(df$Date, df$Time)
df$Datetime <- dmy_hms(df$Datetime)
df$Date <- dmy(df$Date)
df <- df %>%
    filter(Date >= '2007-02-01', Date <= '2007-02-02')

df$Weekday <- weekdays(df$Datetime)

# Transforming factors to numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Check and tweak plot

with(df, plot(Datetime, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(df, lines(Datetime,Sub_metering_2, col='red'))
with(df, points(Datetime, Sub_metering_3, type='l', col='blue'))
legend('topright', pch='-', col=c('black','blue', 'red'), lwd=1.5, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# Open device, write to it, and close it
png("./Exploratory Data Analysis/Assignment_Week1/plot3.png", width=480, height=480)
with(df, plot(Datetime, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(df, lines(Datetime,Sub_metering_2, col='red'))
with(df, points(Datetime, Sub_metering_3, type='l', col='blue'))
legend('topright', pch='-', col=c('black','blue', 'red'), lwd=1.5, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()
