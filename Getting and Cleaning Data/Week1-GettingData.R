getwd()
dir()
setwd('./Getting and Cleaning Data')

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = './data/camera.csv')
list.files('./data')

dateDownloaded <- date()
dateDownloaded

cameraData <- read.table("./data/camera.csv")
cameraData <- read.table("./data/camera.csv", sep=',', header=TRUE)
head(cameraData)
cameraData <- read.csv("./data/camera.csv", header=TRUE)

head(cameraData)
if(!file.exists("data")){dir.create('data')}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile='./data/camera.xlsx')

library(XML)
fileUrl <- 'http://data.baltimorecity.gov/api/views/dz54-2aru/rows.xml?accessType=DOWNLOAD'
download.file(fileUrl, destfile='./data/camera.xml')
doc <- xmlTreeParse(fileUrl, useInternalNodes=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]

xmlSApply(rootNode, xmlValue)
xmlSApply(rootNode,"/row/street", xmlValue)

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=T)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']",xmlValue)

scores
teams

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)
library(data.table)

DF = data.frame(x=rnorm(9), y=rep(c('a','b','c'), each=3),z=rnorm(9))
head(DF,3)

DT = data.table(x=rnorm(9), y=rep(c('a','b','c'), each=3),z=rnorm(9))
head(DT,3)
tables()
DT[2,]
DT[DT$y=='a',]
DT[,c(2,3)]
DT[,list(mean(x),sum(z))]
DT[,table(y)]

DT[,w:=z^2]
DT

DT2 <- DT
DT[, y:=2]
head(DT, n=3)
head(DT2, n=3)
DT[,m:={tmp <- (x+z); log2(tmp+5)}]
DT

DT[,a:=x>0]
DT
DT[,b:=mean(x+w), by=a]
DT
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[,.N, by=x]
DT <- data.table(x=rep(c('a','b','c'), each=100), y=rnorm(300))
setkey(DT,x)
DT['a']

DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a','b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)
DT1
DT2

big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep='\t', quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep='\t'))

# Quiz

dir()

setwd('./Getting and Cleaning Data')

dt <- read.csv('./data/quiz1.csv')

q1 <- subset(dt, VAL >= 24, select='VAL')

q1

nrow(q1)

summary(dt['FES'])

library(xlsx)

q3 <- read.xlsx('./data/quiz1.xlsx',1, header=TRUE)
q3[18:23,7:15]

fileUrl <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(fileUrl, useInternalNodes=TRUE)
q4 <- xmlRoot(doc)
names(q4[[1]])


zips <- as.data.frame(xpathSApply(q4, '//zipcode', xmlValue))
sum(zips == 21231, na.rm=T)


DT = fread('./data/quiz1-2.csv')

system.time(mean(DT$pwgtp15,by=DT$SEX))
mean(DT$pwgtp15,by=DT$SEX)
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
tapply(DT$pwgtp15,DT$SEX,mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
sapply(split(DT$pwgtp15,DT$SEX),mean)

system.time(DT[,mean(pwgtp15),by=SEX])
