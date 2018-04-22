
setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

#   Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make
# a plot answering this question.

BC25 <- subset(NEI, fips=='24510')
plot <- tapply(BC25$Emissions, BC25$year, FUN=sum)

png("./Exploratory Data Analysis/Assignment_Week4/plot2.png", width=480, height=480)
barplot(plot, na.rm=T, xlab='Year', ylab='Emissions', main='PM2.5 Emissions in Baltimore')
dev.off()
