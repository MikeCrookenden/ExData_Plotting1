library(dplyr)

## read and parse data 
allData <- read.table("household_power_consumption.txt", na.strings="?", stringsAsFactors=FALSE, sep=";", header=TRUE)
allData$Date<-as.Date(allData$Date,"%d/%m/%Y")
interestingdata<-allData %>% 
    subset(Date<=as.Date("2007-02-02","%Y-%m-%d")) %>% 
    subset(Date>=as.Date("2007-02-01","%Y-%m-%d"))
rm(allData)
interestingdata<-mutate(interestingdata,datetime=paste(interestingdata$Date,interestingdata$Time))
interestingdata$datetime<-strptime(interestingdata$datetime,"%Y-%m-%d %H:%M:%S")

## draw Plot 1
par(mfrow = c(1, 1))
png(file="plot1.png",width = 480, height = 480, units = "px")
hist(interestingdata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylim=c(0,1200))
dev.off()

rm(interestingdata)
