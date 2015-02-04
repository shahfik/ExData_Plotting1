## Download file if data file doesn't exist
setwd("~/Learning/Coursera/04 Exploratory Data Analysis/Project1")
if(!file.exists("./household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./exdata_data_household_power_consumption.zip", mode="wb")
  unzip("./exdata_data_household_power_consumption.zip")
}


## Read file and subset data
library(data.table)
dataset <- fread("household_power_consumption.txt", select=c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
subds <- dataset[dataset$Date=="1/2/2007" | dataset$Date=="2/2/2007"]
rm(dataset)
subds <- subds[,dt:= paste(Date,Time)]
subds$dt <- as.POSIXct(strptime(subds$dt, "%d/%m/%Y %H:%M:%S"))
subds$Sub_metering_1 <- as.numeric(subds$Sub_metering_1)
subds$Sub_metering_2 <- as.numeric(subds$Sub_metering_2)


## Plot
plot(subds$dt,subds$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",cex.axis=0.7,cex.lab=0.7, col='black')
lines(subds$dt,subds$Sub_metering_2,type="l", col='red')
lines(subds$dt,subds$Sub_metering_3,type="l", col='blue')
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, cex=0.7, col=c('black', 'red', 'blue'),xjust=1,text.width = strwidth("Sub_meterin"))

## Output png
dev.copy(png, file = "plot3.png", width=400, height=400)
dev.off()
