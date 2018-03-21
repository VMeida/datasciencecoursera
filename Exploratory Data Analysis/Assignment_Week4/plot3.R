# This scripts serves only to plot the figures. The exploratory and test pahses are in the Assignment.R 

setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

BC25 <- subset(NEI, fips=='24510')

#   Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999-2008 for Baltimore City? Which have seen increases in
# emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
# answer this question.

library(ggplot2)

png("./Exploratory Data Analysis/Assignment_Week4/plot3.png", width=1000, height=1000)
qplot(type, log10(Emissions), data=BC25, geom=c("boxplot"), facets=type~year, color=type, na.rm=T, main='PM2.5 Emission on Baltimore City by Type')
dev.off()
