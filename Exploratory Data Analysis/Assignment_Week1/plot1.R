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

# Transforming column Date to Date format and filtering the required dates:
df$Date <- dmy(df$Date)
df <- df %>%
        filter(Date >= '2007-02-01', Date <= '2007-02-02')

# Transforming active date to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

# Check and tweak plot
hist(df$Global_active_power, c='red', xlab='Global Active Power (kilowatts)', main='Global Active Power')

# Open device, write to it, and close it
png("./Exploratory Data Analysis/Assignment_Week1/plot1.png", width=480, height=480)
hist(df$Global_active_power, c='red', xlab='Global Active Power (kilowatts)', main='Global Active Power')
dev.off()
