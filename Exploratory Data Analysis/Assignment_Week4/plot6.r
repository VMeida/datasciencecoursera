
setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

library(ggplot2)
both <- merge(NEI, SCC, by='SCC')

grep('Vehicle',unique(both$SCC.Level.Three),value=T)

motorVehiclesB <- subset(both, grepl('Vehicle',both$SCC.Level.Three) & fips=='24510')

#   Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

motorVehiclesLA <- subset(both, grepl('Vehicle',both$SCC.Level.Three) & fips=='06037')

library(dplyr)

BvsLA <- bind_rows(motorVehiclesB, motorVehiclesLA)

png("./Exploratory Data Analysis/Assignment_Week4/plot6.png", width=2000, height=1000)
ggplot(BvsLA, aes(year, Emissions)) + geom_bar(stat = 'sum',aes(fill=year)) + facet_grid(fips~SCC.Level.Three) + ggtitle('Motor Vehicles Emissions Comparison between Baltimore City and LA')
dev.off()
