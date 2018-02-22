setwd('D:/Coursera/Getting and Cleaning Data/')

dir()

fileUrl('https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD')
download.file(fileUrl, destfile = './data/cameras.csv', method = 'curl')

cameraData <- read.csv('./data/camera.csv')

names(cameraData)

tolower(names(cameraData))

splitNames = strsplit(names(cameraData),'\\.')
splitNames[[5]]
splitNames[[6]]

myList <- list(letters = c('A','b', 'c'), numbers = 1:3, matrix(1:25, ncol=5))
head(myList)
myList[1]
myList$letters
myList[[1]]
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

reviews <- read.csv('./data/reviews.csv')
solutions <- read.csv('./data/solutions.csv')

name(reviews)

testName <- 'this_is_a_test'
sub('_','',testName)

gsub('_','',testName)

grep('Alameda', cameraData$intersection)
table(grepl('Alameda', cameraData$intersection))
cameraData2 <- cameraData[!grepl('Alameda', cameraData$intersection),]

cameraData2

grep('Alameda', cameraData$intersection, value=TRUE)
grep('JeffStreet', cameraData$intersection)
length(grep('JeffStreet', cameraData$intersection))
library(stringr)
nchar('Jeffrey Leek')
substr('Jeffrey Leek',1,7)
paste('Jeffrey','Leek')
paste0('Jeffrey','Leek')
str_trim('Jeff       ')
d1 = date()
d1
class(d1)
d2=Sys.Date()
d2
class(d2)
format(d2, '%a %b %d')
x = c('1jan1960', '2jan1960','31mar1960','30jul1960')
z = as.Date(x, '%d%b%Y')
z
z[1] - z[2]
as.numeric(z[1]-z[2])
weekdays(d2)
months(d2)
julian(d2)
library(lubridate)
ymd('20140108')
mdy('08/04/2013')
dmy('03-04-2013')
ymd_hms('2011-08-03 10:15:03')
ymd_hms('2011-08-03 10:15:03', tz='Pacific/Auckland')
?Sys.timezone

x = dmy(c('1jan2013', '2jan2013','31mar2013','30jul2013'))
wday(x[1])
wday(x[1],label=TRUE)

## QUIZ
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl1, destfile = './data/ss06hid.csv', method = 'curl')

ssData <- read.csv('./data/ss06hid.csv')

head(ssData)
strsplit(names(ssData),'wgtp')

fileUrl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(fileUrl2, destfile = './data/GDP.csv', method = 'curl')

GDP <- read.csv('./data/GDP.csv')

head(GDP)
as.list(GDP[5:235,5])
mean(gsub(',','',GDP$X.3),na.rm=T)
mean(as.numeric(gsub(',','',GDP$X.3)),na.rm=T)
mean(as.double(gsub(',','',GDP$X.3)[5:194]))
as.list(sapply(GDP$X.3, function(x) gsub(',','',x)))
grep("^United",GDP$X.2)

fileUrl3 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(fileUrl3, destfile = './data/EDSTATS_Country.csv', method = 'curl')

ED <- read.csv('./data/EDSTATS_Country.csv')

head(ED)
 merged <- merge(GDP, ED, by.x='X', by.y='CountryCode')

head(merged)
names(merged)
grep('Fiscal year end: June',merged$Special.Notes)
library(quantmod)

amzn =getSymbols("AMZN", auto.assign=FALSE)
