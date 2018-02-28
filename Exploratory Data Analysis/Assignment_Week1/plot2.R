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
# Transforming active date to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

# Check and tweak plot
plot(df$Datetime,df$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowats)')

# Open device, write to it, and close it
png("./Exploratory Data Analysis/Assignment_Week1/plot2.png", width=480, height=480)
plot(df$Datetime,df$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowats)')
dev.off()
