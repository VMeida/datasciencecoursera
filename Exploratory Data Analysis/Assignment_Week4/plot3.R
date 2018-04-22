
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
ggplot(data=BC25, aes(y=Emissions, x=year)) + geom_bar(stat = 'sum', aes(fill=year)) + facet_grid(~type) + ggtitle('PM25 Emmision in Baltimore per type')
dev.off()
