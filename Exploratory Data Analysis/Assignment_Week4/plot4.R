
setwd('D:/Coursera/datasciencecoursera')

NEI <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/Assignment_Week4/Data/Source_Classification_Code.rds")

library(ggplot2)
#   Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-2008?

both <- merge(NEI, SCC, by='SCC')

# Check where coal combustion-related are
unique(both$SCC.Level.Three)

# Testing grep filter
grep('[Cc]oal',unique(both$SCC.Level.Three),value=T)

coal <- subset(both, grepl('[Cc]oal',both$SCC.Level.Three))

#Check if grep filter worked
unique(coal$SCC.Level.Three)


png("./Exploratory Data Analysis/Assignment_Week4/plot4.png", width=2000, height=1000)
ggplot(coal, aes(year, Emissions)) + geom_bar(stat = 'sum',aes(fill=year)) + facet_grid(~SCC.Level.Three) + ggtitle('Coal Emissions by Year in the US')
dev.off()
