x <- 1
print(x)
x

msg <- 'hello'
msg
x <- 5
x
print(x)

x <- 1:20
x
print(x)

# Data types - R Objects and Attributes

1
1L # Specifies Integer

Inf
1/Inf
1/0

# Data types - Vectors and Lists

# c = concat

x <- c(0.5,0.6)         ## Numeric
x <- c(TRUE,FALSE)      ## Logical
x <- c(T,F)             ## Logical
x <- c('a', 'b', 'c')   ## Character
x <- 9:29               ## Integer
x <- c(1+0i,2+4i)       ## Complex

x <- vector('numeric', length = 10)
x
y <- c(1.7, 'a')    ## character
y
y <- c(TRUE, 2)   ## numeric
y
y <- c('a', TRUE)   ## character
y

x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
x <- c('a', 'b', 'c')
as.numeric(x)
as.logical(x)
as.complex(x)
x <- list(1,'a', TRUE, 1+4i)
x

# Data types - Matrices

m <- matrix(nrow = 2, ncol = 3)
m

dim(m)

attributes(m)
 m <- matrix(1:6, nrow=2,ncol=3) # Matrices are column-wise
m
m <- 1:10
m

dim(m) <- c(2,5)
m

x <-1:3
y <- 10:12

cbind(x,y)

rbind(x,y)

# Data types - Factors

x <- factor(c('yes','yes','no','yes','no'))
x
table(x)
unclass(x)

attr(x,'levels')
x <- factor(c('yes','yes','no','yes','no'), levels = c('yes','no'))
x

# Data types - Missing values

x <- c(1,2,NA,10,3)
is.na(x)
is.nan(x)

x <- c(1,2,NaN, NA,4)
is.na(x)
is.nan(x)

# Data Types - Data Frames

x <- data.frame(foo=1:4,bar=c(T,T,F,F))
x
nrow(x)
ncol(x)

# Data types - Names Attributes

x <- 1:3
names(x)
names(x) <- c('foo', 'bar', 'norf')
x

x <- list(a=1,b=2,c=3)
x

m <-matrix(1:2, nrow=2, ncol=2)
dimnames(m) <- list(c('a','b'), c('c','d'))
m

# Subsetting

x <- c('a','b', 'c', 'c', 'd', 'a')
x[1]
x[2]
x[1:4]
x[x > 'a']
u <- x > 'a'
u
x[u]

# Subsetting - Lists

x <- list(foo=1:4, bar=0.6)
x[1]
x[[1]]
x$bar
x[["bar"]]
x["bar"]
x <- list(foo=1:4, bar=0.6, baz = 'hello')
x[c(1,3)]
name <- 'foo'
x[[name]]
x$name
x$foo


x <- list(a = list(10,12,14), b=c(3.14, 2.81))
x[[c(1,3)]]
x[[c(2,1)]]

# Subsetting - Matrices

x<-matrix(1:6,2,3)
x
x[1,2]

x[2,1]
x[1,]
x[,2]

x[1,2]
x[1,2, drop=FALSE]
x[1,]
x[1, , drop=F]

# Subsetting - Partial Matching

x <- list(aardvark = 1:5)

x$a

x[["a"]]
x[["a", exact=FALSE]]

# Subsetting - Removing NA Values

x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)
x[!bad]

x <- c(1,2,NA,4,NA,5)
y <- c('a','b',NA,'d',NA,'f')
good <- complete.cases(x,y)
good
x[good]
y[good]
x <- 1:4; y <- 6:9
x+y
x > 2
x >= 2
y == 8
x*y
x/y
x <- matrix(1:4, 2, 2); y <- matrix(rep(10,4),2,2)
x
y
x*y
x/y
x %*% y

# Week 1 Quiz

df <- read.csv('hw1_data.csv')

df
head(df,2)
nrow(df)
tail(df,2)
df[47,]
z <- is.na(df$Ozone)
sum(z)

good <- complete.cases(df)
mean(df$Ozone[good])

good1 <- df$Solar.R[df$Ozone > 31 & df$Temp > 90]
mean(good1[complete.cases(good1)])

mean(df$Temp[df$Month == 6])

max(df$Ozone[df$Month == 5], na.rm = T)
