## Project 1: Plot 1

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


# Convert date and time columns from strings to date/time objects:
df_datasub$Date <- as.Date(df_datasub$Date, format="%d/%m/%Y")
df_datasub$Time <- format(df_datasub$Time, format="%H:%M:%S")
df_datasub$Time <- strptime(df_datasub$Time, format="%H:%M:%S")


# Plot
if (!file.exists("plots")) {
    dir.create("plots")    
}
class(df_datasub$Global_active_power) <- "numeric"
hist(df_datasub$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png, file="plots/plot1.png")
dev.off()

