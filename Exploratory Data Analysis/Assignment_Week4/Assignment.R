setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

# Exploratory phase
head(NEI)
str(NEI)
summary(NEI)
head(SCC)
str(SCC)
summary(SCC)

unique(NEI$year)
unique(NEI$Pollutant)

## Questions

#   Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

with(NEI, boxplot(log10(Emissions) ~ year, na.rm=T))


#   Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make
# a plot answering this question.

BC25 <- subset(NEI, fips=='24510')

str(BC25)
with(BC25, boxplot(log10(Emissions) ~ year), na.rm=T)

#   Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.
library(ggplot2)

qplot(type, log10(Emissions), data=BC25, geom=c("boxplot"), facets=type~year, color=type, na.rm=T)

#   Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

both <- merge(NEI, SCC, by='SCC')
str(both)
unique(both$SCC.Level.Three)
grep('[Cc]oal',unique(both$SCC.Level.Three),value=T)

coal <- subset(both, grepl('[Cc]oal',both$SCC.Level.Three))

unique(coal$SCC.Level.Three)

qplot(Pollutant, log10(Emissions), data=coal, geom=c("boxplot"), facets=SCC.Level.Three~year, color=SCC.Level.Three, na.rm=T)

ggplot(coal, aes(Pollutant, log10(Emissions))) + geom_boxplot(aes(colour=SCC.Level.Three)) + facet_grid(SCC.Level.Three~year)

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

grep('Vehicle',unique(both$SCC.Level.Three),value=T)
motorVehiclesB <- subset(both, grepl('Vehicle',both$SCC.Level.Three) & fips=='24510')

unique(motorVehiclesB$SCC.Level.Three)
qplot(fips, log10(Emissions), data=motorVehiclesB, geom=c("boxplot"), facets=SCC.Level.Three~year, color=SCC.Level.Three, na.rm=T)

#   Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

motorVehiclesLA <- subset(both, grepl('Vehicle',both$SCC.Level.Three) & fips=='06037')

library(dplyr)

BvsLA <- bind_rows(motorVehiclesB, motorVehiclesLA)

qplot(fips, log10(Emissions), data=BvsLA, geom=c("boxplot"), facets=SCC.Level.Three~year, color=SCC.Level.Three, na.rm=T)
