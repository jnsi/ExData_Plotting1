# Set the work directory
WD <- getwd()
if (!is.null(WD)) setwd(WD)

#Download and unzip data
if(!file.exists('data')) dir.create('data')

fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile = './data/household_power_consumption.zip')
unzip('./data/household_power_consumption.zip', exdir = './data')
# load library
library(dplyr)
library(data.table)

#Read data and subset on date
files <- file('./data/household_power_consumption.txt') 
data <- read.table(files, header=TRUE, sep=';', stringsAsFactors=FALSE, dec=".", na.strings = '?')
FiltredData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

##Explore the subsetted data
#str(FiltredData)
#head(FiltredData,10)
#tail(FiltredData,10)
#dim(FiltredData)


# Convert Date and time to specific format
datetime <- strptime(paste(FiltredData$Date, FiltredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
# class(datetime) POSIXit

# Plot 4 : a plot with 4 graphs 

# Open device
png("./data/plot4.png", width = 480, height = 480)

#Create a plot of date/time vs global active power data
Sys.setlocale(category = "LC_ALL", locale = "english")
par(mfrow = c(2, 2))
plot(datetime, FiltredData$Global_active_power , type="l", xlab="", ylab="Global Active Power", cex=0.2)

#Create the first graph in column 2 : graph on date/time v Voltage
plot(datetime, FiltredData$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Create 2nd graph in column 1 : a plot of date/time v Sub metering 1 data
plot(datetime, FiltredData$Sub_metering_1 , type="l", ylab="Energy Submetering", xlab="")

##Adds line graph for date/time v Sub metering 2 data in red
lines(datetime, FiltredData$Sub_metering_2, type="l", col="red")


##Adds line graph for date/time v Sub metering 2 data in blue
lines(datetime, FiltredData$Sub_metering_3, type="l", col="blue")

#Adds legend to graph
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))


#Create the second graph in column 2 for datetime v global reactive power
plot(datetime, FiltredData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


#close device
dev.off()

