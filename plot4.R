#script assumes that the data file is placed in the working directory
#png file is placed in the working directory
#run script: source("plot4.R")

load_and_transform_data <- function() {
  
  d1 <- read.csv("household_power_consumption.txt",header=TRUE,sep=";")
  d2 <- subset(d1, Date=="1/2/2007"|Date=="2/2/2007")
 
  d2$Global_active_power<-as.numeric(as.character(d2$Global_active_power))
  d2$Global_reactive_power<-as.numeric(as.character(d2$Global_reactive_power))
  d2$Voltage<-as.numeric(as.character(d2$Voltage))
  
  d2$Sub_metering_1<-as.numeric(as.character(d2$Sub_metering_1))
  d2$Sub_metering_2<-as.numeric(as.character(d2$Sub_metering_2))
  d2$Sub_metering_3<-as.numeric(as.character(d2$Sub_metering_3))
  
  d2$DateTime<-paste(as.character(d2$Date),as.character(d2$Time))
  strptime(d2$DateTime,format="%d/%m/%Y %H:%M:%S")
  d2$DateTime<-strptime(d2$DateTime,format="%d/%m/%Y %H:%M:%S")
  
  return(d2)
  
}

dw1 <- load_and_transform_data()

par(mfrow=c(2,2))

#subplot 1

plot(dw1$DateTime,dw1$Global_active_power,type="n",xlab="",ylab="Global Active Power")
lines(dw1$DateTime,dw1$Global_active_power,type="l")

#subplot 2

plot(dw1$DateTime,dw1$Voltage,type="n",xlab="datetime",ylab="Voltage")
lines(dw1$DateTime,dw1$Voltage,type="l")

#subplot 3

plot(dw1$DateTime,dw1$Sub_metering_1,type="n",xlab="",ylab="Energy submetering")
lines(dw1$DateTime,dw1$Sub_metering_1,type="l",col="black")
lines(dw1$DateTime,dw1$Sub_metering_2,type="l",col="red")
lines(dw1$DateTime,dw1$Sub_metering_3,type="l",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

#subplot 4

plot(dw1$DateTime,dw1$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
lines(dw1$DateTime,dw1$Global_reactive_power,type="l")

dev.copy(png,"plot4.png",width=480, height=480)
dev.off()
