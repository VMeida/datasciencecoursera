# If Statements

if(x>3) {
    y <- 10
} else {
    y <- 0
}

y <- if(x > 3){
    10
} else {
    0
}

# For loops
for (i in 1:10) {
    print(i)
}

x <- c('a','b','c','d')

for (i in 1:4){
    print(x[i])
}

for (i in seq_along(x)) {
    print(x[i])
}

for (letter in x) {
    print(letter)
}

for (i in 1:4) print (x[i])

x <- matrix(1:6, 2,3)

for (i in seq_len(nrow(x))) {
    for (j in seq_len(ncol(x))) {
        print(x[i,j])
    }
}

# While loops

count <- 0
while(count < 10) {
    print(count)
    count <- count+1
}

z <- 5

while (z >= 3 && z <=10) {
    print(z)
    coin <- rbinom(1,1,0.5)

    if (coin ==1) { ## random walk
        z <- z+1
    } else {
        z <- z-1
    }
}

# Repeat, Next, Break

xo <- 1
tol <- 1e-8

repeat {
    x1 <- computeEstimate()

    if(abs(x1-x0) < tol) {
        break
    } else {
        x0 <- x1
    }
}

for (i in 1:100) {
    if(i <= 20) {
        ## Skip the first 20 iterations
        next
    }
    print(i)
}

# Functions

add2 <- function(x,y) {
    x+y
}

add2(2,4)

above10 <- function(x){
    use <- x > 10
    x[use]
}

above <- function(x, n =10) {
    use <- x > n
    x[use]
}

x <- 1:20

above(x)

columnmean <- function(y, removeNA=TRUE) {
    nc <- ncol(y)
    means <- numeric(nc)
    for (i in 1:nc){
        means[i] <- mean(y[,i], na.rm = removeNA)
    }
    mean
}

columnmean(x)

mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm=FALSE)
sd(na.rm = FALSE, x= mydata)
sd(na.rm = FALSE, mydata)
args(lm)

lm(data=mydata, y~x, model=FALSE, 1:100)
lm(y~x, mydata,  1:100, model=FALSE)

f <- function(a,b) {
    a^2
}

f(2)

f <- function(a,b) {
    print(a)
    print(b)
}

f(45)

myplot <- function(x,y,type = 'l',...) {
    plot(x,y, type = type,...)
}

mean

args(paste)
args(cat)
paste('a','b', sep=':')
paste('a','b',se=':')

# Symbol Binding

lm <- function(x) {x * x}

search()

f <- function(x,y) {
    x^2 +y /z
}

make.power <- function(n) {
    pow <- function(x) {
        x ^ n
    }
    pow
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)
 ls(environment(cube))
get('n',environment(cube))
get('n',environment(square))

y <- 10
 f <- function(x) {
     y <- 2
     y ^ 2 + g(x)
 }

 g <- function(x){
     x*y
 }

f(10)
g(10)
f(10)

g <- function(x) {
    a <- 3
    x+a+y
}

g(2)

y <-3
g(2)

# Dates
x <- as.Date('1970-01-01')
x
unclass(x)
unclass(as.Date('1970-01-02'))

x <- Sys.time()
x
p <- as.POSIXlt(x)
names(unclass(p))
p$sec
p$isdst
p$zone
p$gmtoff
unclass(x)
p <- as.POSIXlt(x)
p
p$sec

datestring <- c('January 10, 2012 10:40', 'December 9, 2011 9:10')
x <- strptime(datestring, '%B %d, %Y %H:%M')
x

x<-1:10
if(x>5){
    x<-0

}
f <- function(x){
    g <- function(y){
        y+z
    }
    z <-4
    x+g(x)
}
z<-10
f(3)
