#Load in necessary libraries
library(dplyr)
library(data.table)

#Reads in data from file then subsets data for specified dates
data <- fread("household_power_consumption.txt", 
              na.strings="?",stringsAsFactors = FALSE)

#my_data <- data[data$Date %in% as.Date(c('2012-01-05', '2012-01-09')),]
my_data <- filter(data, grep("^[1,2]/2/2007", Date))

# Convert global active power column, global reactive power colums, 
# Sub_metering columns, and the Voltage column to numeric
my_data$Global_active_power <- as.numeric(as.character(my_data$Global_active_power))

my_data$Global_reactive_power <- as.numeric(as.character(my_data$Global_reactive_power))

my_data$Sub_metering_1 <- as.numeric(as.character(my_data$Sub_metering_1))
my_data$Sub_metering_2 <- as.numeric(as.character(my_data$Sub_metering_2))
my_data$Sub_metering_3 <- as.numeric(as.character(my_data$Sub_metering_3))

my_data$Voltage <- as.numeric(as.character(my_data$Voltage))

#Creates new column that combines date and time data 
my_data$Timestamp <- paste(my_data$Date, my_data$Time)



#saves the created plot to image in .png format
png(filename="plot2.png", width=480, height=480)

# Creates graph of date/time vs global active power data
plot(strptime(my_data$Timestamp, "%d/%m/%Y %H:%M:%S"), 
     my_data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power(kilowatts)")

dev.off()

#The plot is directly saved as 'plot2.png' in the working directory
