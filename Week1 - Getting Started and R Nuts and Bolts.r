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
