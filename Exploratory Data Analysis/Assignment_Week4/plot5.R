
setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

library(ggplot2)
both <- merge(NEI, SCC, by='SCC')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Testing grep filter
grep('Vehicle',unique(both$SCC.Level.Three),value=T)

motorVehiclesB <- subset(both, grepl('Vehicle',both$SCC.Level.Three) & fips=='24510')

#Check if grep filter worked
unique(motorVehiclesB$SCC.Level.Three)

png("./Exploratory Data Analysis/Assignment_Week4/plot5.png", width=2000, height=1000)
ggplot(motorVehiclesB, aes(year, Emissions)) + geom_bar(stat = 'sum',aes(fill=year)) + facet_grid(~SCC.Level.Three) + ggtitle('Motor Vehicle Emissions by Year in Baltimore City')
dev.off()
