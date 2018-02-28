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
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Check and tweak plot
par(mfrow=c(2,2))

plot(df$Datetime,df$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowats)')

plot(df$Datetime,df$Voltage, type='l', xlab='datetime', ylab='Voltage')

with(df, plot(Datetime, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(df, lines(Datetime,Sub_metering_2, col='red'))
with(df, points(Datetime, Sub_metering_3, type='l', col='blue'))
legend('topright', pch='-', col=c('black','blue', 'red'), lwd=1.5, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

plot(df$Datetime,df$Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power')

# Open device, write to it, and close it
png("./Exploratory Data Analysis/Assignment_Week1/plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(df$Datetime,df$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowats)')

plot(df$Datetime,df$Voltage, type='l', xlab='datetime', ylab='Voltage')

with(df, plot(Datetime, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(df, lines(Datetime,Sub_metering_2, col='red'))
with(df, points(Datetime, Sub_metering_3, type='l', col='blue'))
legend('topright', pch='-', col=c('black','blue', 'red'), lwd=1.5, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

plot(df$Datetime,df$Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power')

dev.off()
