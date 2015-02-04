## Download file if data file doesn't exist
setwd("~/Learning/Coursera/04 Exploratory Data Analysis/Project1")
if(!file.exists("./household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./exdata_data_household_power_consumption.zip", mode="wb")
  unzip("./exdata_data_household_power_consumption.zip")
}


## Read file and subset data
library(data.table)
dataset <- fread("household_power_consumption.txt", select=c("Date","Time","Global_active_power"))
subds <- dataset[dataset$Date=="1/2/2007" | dataset$Date=="2/2/2007"]
rm(dataset)
subds <- subds[,dt:= paste(Date,Time)]
subds$dt <- as.POSIXct(strptime(subds$dt, "%d/%m/%Y %H:%M:%S"))
subds$Date <- as.Date(subds$Date, format="%d/%m/%Y")
subds$Global_active_power <- as.numeric(subds$Global_active_power)


## Plot
plot(subds$dt,subds$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",cex=0.8)


## Output png
dev.copy(png, file = "plot2.png", width=400, height=400)
dev.off()
