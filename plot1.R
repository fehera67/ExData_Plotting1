#script assumes that the data file is placed in the working directory
#png file is placed in the working directory
#source("plot1.R")

load_and_transform_data <- function() {
  
  d1 <- read.csv("household_power_consumption.txt",header=TRUE,sep=";")
  d2 <- subset(d1, Date=="1/2/2007"|Date=="2/2/2007")
  d2$Global_active_power<-as.numeric(as.character(d2$Global_active_power))
 
  return(d2)
  
}

dw1 <- load_and_transform_data()

par(mfrow=c(1,1))

hist(dw1$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="Red")
dev.copy(png,"plot1.png",width=480, height=480)
dev.off()