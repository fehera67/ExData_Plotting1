#script assumes that the data file is placed in the working directory
#png file is placed in the working directory
#source("plot2.R")

load_and_transform_data <- function() {
  
  d1 <- read.csv("household_power_consumption.txt",header=TRUE,sep=";")
  d2 <- subset(d1, Date=="1/2/2007"|Date=="2/2/2007")
  d2$Global_active_power<-as.numeric(as.character(d2$Global_active_power))
  
  d2$DateTime<-paste(as.character(d2$Date),as.character(d2$Time))
  strptime(d2$DateTime,format="%d/%m/%Y %H:%M:%S")
  d2$DateTime<-strptime(d2$DateTime,format="%d/%m/%Y %H:%M:%S")
  
  return(d2)
  
}

dw1 <- load_and_transform_data()

par(mfrow=c(1,1))

plot(dw1$DateTime,dw1$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)")
lines(dw1$DateTime,dw1$Global_active_power,type="l")
dev.copy(png,"plot2.png",width=480, height=480)
dev.off()