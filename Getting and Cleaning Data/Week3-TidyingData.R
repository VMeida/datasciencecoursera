if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=T)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]
data(UCBAdmissions)
DF=as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt
DF
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

s1 <- seq(1,10, by=2)
s1
s2 <- seq(1,10, length=3)
s2
x <- c(1,3,8,25,100)
seq(along = x)
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
restData$zipWrong = ifelse(restData$zipCode < 0, T,F)
table(restData$zipWrong, restData$zipCode <0)
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)
library(Hmisc)

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes","no"), size=10, replace=T)
yesnofact = factor(yesno, levels=c("yes","no"))
relevel(yesnofact, ref="yes")
as.numeric(yesnofact)

library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"),measure.vars=c("mpg","hp"))
head(carMelt, n=3)
tail(carMelt, n=3)
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount = lapply(spIns,sum)
sprCount
unlist(sprCount)
sapply(spIns,sum)
library(plyr)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
spraySums <- ddply(InsectSprays,.(spray),summarize, sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)

library(dplyr)

setwd('./Getting and Cleaning Data')

fileUrl1="https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr-29.csv"
fileUrl2="https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr-29.csv"
download.file(fileUrl1,destfile='./data/reviews.csv', method="curl")
download.file(fileUrl2,destfile='./data/solutions.csv', method="curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")

head(reviews,2)
head(solutions,2)

names(reviews)
names(solutions)

margedData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
head(mergedData)

intersect(names(solutions), names(reviews))

mergedData2 = merge(reviews, solutions, all=TRUE)
head(mergedData2)
df1=data.frame(id=sample(1:10), x=rnorm(10))
df2=data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1,df2), id)

df1=data.frame(id=sample(1:10), x=rnorm(10))
df2=data.frame(id=sample(1:10), y=rnorm(10))
df3=data.frame(id=sample(1:10), z=rnorm(10))
dfList=list(df1,df2,df3)
join_all(dfList)

# QUIZ

## 1

df <- read.csv("./data/Quiz3-1.csv")

head(df)
names(df)
agricultureLogical <- df %>%
                        select(SERIALNO, ACR, AGS) %>%
                          filter(ACR == "3", AGS =="6")


head(agricultureLogical)
which(agricultureLogical)

library(jpeg)

photo <- readJPEG("./data/jeff.jpg", native=TRUE)
photo

quantile(photo, probs=c(0.3, 0.8))

df2 <- read.csv("./data/Quiz3-2.csv")
df3 <- read.csv("./data/Quiz3-3.csv")

head(df2)
summary(df2)
str(df2)
head(df3)
summary(df3)
str(df3)
merged <- merge(df2, df3, by.x='X', by.y="CountryCode", na.rm=T)
head(merged)
summary(merged)
str(merged)
na.rm(merged)
arrange(merged, desc(Gross.domestic.product.2012))


merged %>%
  select(Income.Group, Gross.domestic.product.2012) %>%
    filter(Income.Group == "High income: nonOECD")
      summarize(avg_gpd = mean(Gross.domestic.product.2012, na.rm=T)) %>%
        print

HOECD <- merged %>%
  select(Income.Group, Gross.domestic.product.2012) %>%
    filter(Income.Group == "High income: OECD") %>%
      print()

str(HOECD)
summary(HOECD)

merged$Gross.domestic.product.2012 = as.numeric(merged$Gross.domestic.product.2012)
quant <- quantile(merged$Gross.domestic.product.2012)
table(quantile(merged$Gross.domestic.product.2012), merged$Income.Group)

merged %>%
  select(Income.Group, Gross.domestic.product.2012) %>%
    filter(Income.Group == "Lower middle income") %>%
      print
      summarize(quant = quantile(Gross.domestic.product.2012))
    
