## Download file if data file doesn't exist
setwd("~/Learning/Coursera/04 Exploratory Data Analysis/Project1")
if(!file.exists("./household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./exdata_data_household_power_consumption.zip", mode="wb")
  unzip("./exdata_data_household_power_consumption.zip")
}


## Read file and subset data
library(data.table)
dataset <- fread("household_power_consumption.txt", select=c("Date","Global_active_power"))
subds <- dataset[dataset$Date=="1/2/2007" | dataset$Date=="2/2/2007"]
rm(dataset)
subds$Global_active_power <- as.numeric(subds$Global_active_power)


## Plot
hist(subds$Global_active_power, col='red', main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200), xlim=c(0,6), cex.axis=0.8, xaxt='n')
axis(1,at=c(0,2,4,6),cex.axis=0.8)

## Output png
dev.copy(png, file = "plot1.png", width=400, height=400)
dev.off()
