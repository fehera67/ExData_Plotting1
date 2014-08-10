#script assumes that the data file is placed in the working directory
#png file is placed in the working directory
#this script does not create a plot on the screen because dev.copy messed up the legend   
#source("plot3.R")

load_and_transform_data <- function() {
  
  d1 <- read.csv("household_power_consumption.txt",header=TRUE,sep=";")
  d2 <- subset(d1, Date=="1/2/2007"|Date=="2/2/2007")
 
  d2$Global_active_power<-as.numeric(as.character(d2$Global_active_power))
  d2$Sub_metering_1<-as.numeric(as.character(d2$Sub_metering_1))
  d2$Sub_metering_2<-as.numeric(as.character(d2$Sub_metering_2))
  d2$Sub_metering_3<-as.numeric(as.character(d2$Sub_metering_3))
  
  d2$DateTime<-paste(as.character(d2$Date),as.character(d2$Time))
  strptime(d2$DateTime,format="%d/%m/%Y %H:%M:%S")
  d2$DateTime<-strptime(d2$DateTime,format="%d/%m/%Y %H:%M:%S")
  
  return(d2)
  
}

dw1 <- load_and_transform_data()

png("plot3.png",width=480,height=480)
par(mfrow=c(1,1))

plot(dw1$DateTime,dw1$Sub_metering_1,type="n",xlab="",ylab="Energy submetering")
lines(dw1$DateTime,dw1$Sub_metering_1,type="l",col="black")
lines(dw1$DateTime,dw1$Sub_metering_2,type="l",col="red")
lines(dw1$DateTime,dw1$Sub_metering_3,type="l",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

dev.off()
