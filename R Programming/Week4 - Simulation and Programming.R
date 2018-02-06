str(str)
str(lm)
str(ls)
x <- rnorm(100, 2, 4)

str(x)

library(datasets)
head(airquality)
str(airquality)
summary(airquality)
s <- split(airquality, airquality$Month)

str(s)

x <- rnorm(10)
x

x <- rnorm(10, 20, 2)
x
summary(x)

set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1)
rnorm(5)
rpois(10,1)
rpois(10, 2)
rpois(10,20)
ppois(2,2)
ppois(4,2)
ppois(6,2)

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e

summary(y)
plot(x,y)
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e

summary(y)
plot(x,y)
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))

summary(y)
plot(x,y)
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
sample(1:10)
sample(1:10)
sample(1:10, replace=T)
system.time(readLines("http://www.jhsph.edu"))

hilbert <- function(n){
  i <- 1:n
  1/outer(i-1,i,"+")
}

x <- hilbert(1000)
system.time(svd(x))
system.time({
  n<-1000
  r <- numeric(n)
  for (i in 1:n){
    x <- rnorm(n)
    r[i] <- mean(x)
  }
})
Rprof()
x <- hilbert(1000)
system.time(svd(x))

set.seed(1)
rpois(5, 2)
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e

plot(y,x)

library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)
