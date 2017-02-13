library(dplyr)

## read and parse data (same for all plots)
allData <- read.table("household_power_consumption.txt", na.strings="?", stringsAsFactors=FALSE, sep=";", header=TRUE)
allData$Date<-as.Date(allData$Date,"%d/%m/%Y")
interestingdata<-allData %>% 
    subset(Date<=as.Date("2007-02-02","%Y-%m-%d")) %>% 
    subset(Date>=as.Date("2007-02-01","%Y-%m-%d"))
rm(allData)
interestingdata<-mutate(interestingdata,datetime=paste(interestingdata$Date,interestingdata$Time))
interestingdata$datetime<-strptime(interestingdata$datetime,"%Y-%m-%d %H:%M:%S")

## draw Plot 4 - four subplots
png(file="plot4.png",width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))

##Subplot 1 = old plot2 (almost)
with(interestingdata,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

##Subplot 2 = old plot3 (almost)
with(interestingdata,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black"))
lines(interestingdata$datetime,interestingdata$Sub_metering_2,type="l",col="red")
lines(interestingdata$datetime,interestingdata$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1,bty="n")

##Subplot 3 - Voltage
with(interestingdata,plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))

##Subplot 4 - Reactive power
with(interestingdata,plot(datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))

dev.off()

rm(interestingdata)
