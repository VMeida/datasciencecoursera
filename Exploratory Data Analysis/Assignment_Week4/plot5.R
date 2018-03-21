# This scripts serves only to plot the figures. The exploratory and test pahses are in the Assignment.R 

setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

both <- merge(NEI, SCC, by='SCC')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Testing grep filter
grep('Vehicle',unique(both$SCC.Level.Three),value=T)

motorVehiclesB <- subset(both, grepl('Vehicle',both$SCC.Level.Three) & fips=='24510')

#Check if grep filter worked
unique(motorVehiclesB$SCC.Level.Three)

png("./Exploratory Data Analysis/Assignment_Week4/plot5.png", width=1000, height=1000)
qplot(fips, log10(Emissions), data=motorVehiclesB, geom=c("boxplot"), facets=SCC.Level.Three~year, color=SCC.Level.Three, na.rm=T, main='Motor Vehicle Emissions by Year in Baltimore City')
dev.off()
