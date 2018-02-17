library(RMySQL)

ucscDb <- dbConnect(MySQL(),user='genome', host='genome-mysql.cse.ucsc.edu')
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb)
hg19 = dbConnect(MySQL(),user='genome', db='hg19', host='genome-mysql.cse.ucsc.edu')

allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
dbListFields(hg19,'affyU133Plus2')
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, 'affyU133Plus2')
head(affyData)


query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)

affyMisSmall <- fetch(query, n=10)
affyMisSmall


dbClearResult(query)
dbDisconnect(hg19)


library(rhdf5)

created = h5createFile("example.h5")
created

created = h5createGroup('example.h5', 'foo')
created = h5createGroup('example.h5', 'bar')
created = h5createGroup('example.h5', 'foo/foobaa')
h5ls('example.h5')
A=matrix(1:10,nr=5,nc=2)
h5write(A, 'example.h5', 'foo/A')
B=array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(B,'scale') <- "liter"
h5write(B,'example.h5','foo/foobaa/B')
h5ls('example.h5')
df = data.frame(1L:5L, seq(0,1, length.out=5), c("ab",'cde','fghi','a','s'), stringAsFactors=FALSE)
h5write(df, 'example.h5','df')
h5ls('example.h5')

readA = h5read('example.h5','foo/A')
readB = h5read('example.h5','foo/foobaa/B')
readdf = h5read('example.h5','df')

readA
readB
readdf
h5write(c(12,13,14), "example.h5","foo/A", index=list(1:3,1))
h5read("example.h5","foo/A")

con = url('https://scholar.google.com/citations?user=HI-I6C0AAAAJ')
htmlCode = readLines(con)
close(con)
htmlCode
library(XML)
url <- 'http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en'
html <- htmlTreeParse(url, useInternalNodes=T)

library(httr)
html2=GET(url)
content2 = content(html2, as='text')
parsedHtml = htmlParse(content2,asText=T)
xpathSApply(parsedHtml, "//title", xmlValue)
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2

names(pg2)
google = handle("http://google.com")
pg1= GET(handle=google, path='/')
pg2= GET(handle=google, path='search')
pg1
pg2
library(jsonlite)

myapp = oauth_app("twitter", key="znSNhIkFOf2vBWnh95ILXUJBd", secret="rWZWUIw3dfUgq5H6YFf0sKHD5Bi58q9ScbNFakfNGdmc7D7k6l")
sig= sign_oauth1.0(myapp, token='961718004718489601-yeQsagqeKePp0lYI9KAZqI1SNovy8ki', token_secret="lifT7LOXgpznHBaD2zbk8PxhHDlcJ8HeALQUApx7flkSn")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json1
json2

# Quiz

## 1

oauth_endpoints("github")

myapp <- oauth_app("github",
  key = "d07a5a3795afcfb18665",
  secret = "44ce56ceca5d78956135aad9f2494915196b4ac9")

myapp

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

## 2

## 4

url <- 'http://biostat.jhsph.edu/~jleek/contact.html'
html <- GET(url)
html
content = content(html, as='text')
parsedHtml = htmlParse(content,asText=T)

xpathSApply(parsedHtml, "//title", xmlValue)

parsedHtml

html2 <- readLines(url)

nchar(html2[10])
nchar(html2[20])
nchar(html2[30])
nchar(html2[100])

url2 <- 'http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for'

html3 <- readLines(url2)
readHTMLTable(html3)

html4 <- GET(url2)

content2 = content(html4, as='text')
parsedHtml2 = htmlParse(content2,asText=T)
read.table(xpathSApply(parsedHtml2, "//body", xmlValue), sep='\n')
library('rvest')
my_df <- as.data.frame(read_html(url) %>% html_table(fill=TRUE))
my_df
