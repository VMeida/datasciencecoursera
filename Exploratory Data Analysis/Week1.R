library(datasets)
data(cars)
with(cars, plot(speed, dist))

library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)

library(datasets)
hist(airquality$Ozone)

with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone (ppb)")

par('lty')
par('col')
par('pch')
par('bg')
par('mar')
par('mfrow')

with(airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in New York City")

with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City"))
with(subset(airquality, Month==5), points(Wind, Ozone, col='blue'))
with(subset(airquality, Month!=5), points(Wind, Ozone, col='red'))
legend('topright', pch=1, col=c('blue', 'red'), legend = c('May', 'Not May'))

with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", pch=20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)

par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main="Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1,3), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(airquality, {
  plot(Wind, Ozone, main="Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})

library(datasets)

pdf(file="myplot.pdf")
with(faithful, plot(eruptions, waiting))
title(main="Old Faithful Geyer Data")
dev.off()

dev.cur()
dev.set(5)

windows()
