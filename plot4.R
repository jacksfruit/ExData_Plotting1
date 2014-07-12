## Project 1: Plot 4

setwd("E:/Coursera_2014/Data_Science_Specialization/04_Exploratory_Data_Analysis/Project-1")

# Donwload and read the data file. 
# When run the 1st time then a new file with the data subset (only Dates 01/02/2007 and 02/02/2007) is created:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("data")) {
    dir.create("data")    
}
filePathZip <- "./data/household_power_consumption.zip"
if (!file.exists(filePathZip)) {
    download.file(fileUrl, destfile = filePathZip)
    unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data/")
}
filePathTxtSub <- "./data/household_power_consumption_sub.txt"
if (!file.exists(filePathTxtSub)) {
    df_data <- read.csv("data/household_power_consumption.txt", sep=";", na.strings="?", colClasses = "character")
    filter_date <- (as.Date(df_data$Date, format="%d/%m/%Y") == as.Date("01/02/2007", format="%d/%m/%Y")) | (as.Date(df_data$Date, format="%d/%m/%Y") == as.Date("02/02/2007", format="%d/%m/%Y"))
    df_datasub <- df_data[filter_date, ]
    write.table(df_datasub, file="./data/household_power_consumption_sub.txt", sep=";", row.names=FALSE, col.names=TRUE, quote=FALSE)
} else {
    df_datasub <- read.csv("data/household_power_consumption_sub.txt", sep=";", na.strings="?", colClasses = "character")    
}


# Convert date from string to object:
df_datasub$Date <- as.Date(df_datasub$Date, format="%d/%m/%Y")


# Plot
if (!file.exists("plots")) {
    dir.create("plots")    
}
class(df_datasub$Global_active_power) <- "numeric"
class(df_datasub$Sub_metering_1) <- "numeric"
class(df_datasub$Sub_metering_2) <- "numeric"
class(df_datasub$Sub_metering_3) <- "numeric"
class(df_datasub$Voltage) <- "numeric"
class(df_datasub$Global_reactive_power) <- "numeric"
v_datetime <- strptime(paste(df_datasub$Date, df_datasub$Time), '%Y-%m-%d %H:%M:%S') ## calculate values for the x-axis (i.e. datetime)

## set column-based multi-frame plot area
par(mfcol = c(2, 2))  

## plot upper left 
plot(v_datetime, df_datasub$Global_active_power, main="", 
     xlab="", ylab="Global Active Power (kilowatts)", type="l")

## plot lower left
plot(v_datetime, df_datasub$Sub_metering_1, main="", 
     xlab="", ylab="Energy sub metering", type="l", col="black")
lines(v_datetime, df_datasub$Sub_metering_2, col="red")
lines(v_datetime, df_datasub$Sub_metering_3, col="blue")
legend("topright", lty=1, lwd=1,  ## the line type ('lty') and width ('lwd') are used here instead of the 'pch'
       col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## plot upper right
plot(v_datetime, df_datasub$Voltage, main="", 
     xlab="datetime", ylab="Voltage", type="l")

## plot lower right
plot(v_datetime, df_datasub$Global_reactive_power, main="", 
     xlab="datetime", ylab="Global_reactive_power", type="l", 
     cex.axis=0.7)  # use 'cex.axis' to rescale the tick labels

dev.copy(png, file="plots/plot4.png")
dev.off()

