
setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

#   Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

plot <- tapply(NEI$Emissions, NEI$year, FUN=sum)
plot

png("./Exploratory Data Analysis/Assignment_Week4/plot1.png", width=480, height=480)
barplot(plot, na.rm=T, xlab='Year', ylab='Emissions', main='PM2.5 Emissions in the US')
dev.off()
