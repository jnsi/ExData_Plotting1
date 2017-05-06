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

#Plot1
#Open the device
png("./data/plot1.png", width=480, height=480)

#Plot 1 : Create histogram for Global Active Power
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Close the device
dev.off()


