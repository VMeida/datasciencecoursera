setwd('D:/Coursera/datasciencecoursera/Reproducible Research/Assignment 1')
data <- read.csv('./Data/activity.csv')
head(data)
summary(data)
str(data)

library(plyr)
library(dplyr)
library(tidyr)
# Check the total histogram
hist(data$steps, breaks=15)
# Removing zero values and replotting
nonnull <- data %>%
    filter(steps !=0)
hist(nonnull$steps)
# Grouping by day
steps <- data %>%
    group_by(date) %>%
    summarise_all(sum)
head(steps)
hist(steps$steps, breaks =15)

#Calculate mean and median
medianSteps <- data %>%
    filter(steps != 0) %>%
    group_by(date) %>%
    summarise(sum = sum(steps), mean=mean(steps), median=median(steps))
medianSteps

#See the pattern by interval, day by day
activityPattern <- data %>%
    filter(steps !=0) %>%
    group_by(interval) %>%
    summarise(steps=mean(steps))
activityPattern

plot(activityPattern$interval,activityPattern$steps,type="l",xlab="Interval",ylab="Date")

sum(activityPattern$steps)

#Get the row with max value
activityPattern[which.max(activityPattern$steps),]

# How many NAs are in the dataset?
sum(is.na(data$steps))
sum(is.na(data$steps))/(sum(is.na(data$steps))+sum(!is.na(data$steps)))*100

# Fill data with interval mean values
activityPattern2 <- data %>%
    replace(., is.na(.), 0) %>%
    group_by(interval) %>%
    summarise(steps=mean(steps))
activityPattern2

fullData <- data
fullData <- fullData %>%
    rename(steps.x = steps) %>%
    join(activityPattern2, by="interval") %>%
    mutate(steps.x = ifelse(is.na(steps.x), steps,steps.x)) %>%
    select(steps=steps.x, date, interval)
fullData

sum(is.na(fullData$steps))

# Plots with full table
fullSteps <- fullData %>%
    group_by(date) %>%
    summarise_all(sum)
head(fullSteps)
hist(fullSteps$steps, breaks =15)

# Mean and Median with full data 
fullMedianSteps <- fullData %>%
    filter(steps !=0) %>%
    group_by(date) %>%
    summarise(sum = sum(steps), mean=mean(steps), median=median(steps, na.rm=T))
fullMedianSteps

# Get weekdays

fullData2 <- fullData %>%
    mutate(weekday = weekdays(as.Date(fullData$date))) %>%
    mutate(weekend = ifelse(weekday == "sábado" | weekday =="domingo", 1, 0))
fullData2

fullData2[fullData2$date == "2012-10-06", ]

# Plot time series for weekdays and weekend

weekendPlot <- fullData2 %>%
    filter(weekend==1) %>%
    group_by(interval) %>%
    summarise(steps=mean(steps))
weekendPlot

weekdayPlot <- fullData2 %>%
    filter(weekend==0) %>%
    group_by(interval) %>%
    summarise(steps=mean(steps))
weekdayPlot

par(mfrow = c(2,1))
plot(weekdayPlot$interval,weekdayPlot$steps,type="l",xlab="Interval",ylab="Avg Steps", main = "Weekdays")
plot(weekendPlot$interval,weekendPlot$steps,type="l",xlab="Interval",ylab="Avg Steps", main = "Weekends")


