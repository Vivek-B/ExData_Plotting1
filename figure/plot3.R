#The working directory should contain the file 'household_power_consumption'
#Install the 'dplyr' package if not installed already
#Load in necessary libraries
library(dplyr)
library(data.table)

#Reads in data from file then subsets data for specified dates
data <- fread("household_power_consumption.txt", 
              na.strings="?",stringsAsFactors = FALSE)

# Filters the necessary data between dates 1/2/2007 - 2/2/2007
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
png(filename="plot3.png", width=480, height=480)

#Creates plot of date/time v Sub metering 1 data
plot(strptime(my_data$Timestamp, "%d/%m/%Y %H:%M:%S"), 
     my_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Adds line graph for date/time v Sub metering 2 data in red
lines(strptime(my_data$Timestamp, "%d/%m/%Y %H:%M:%S"), 
      my_data$Sub_metering_2, type = "l", col = "red" )

#Adds line graph for date/time v Sub metering 3 data in blue
lines(strptime(my_data$Timestamp, "%d/%m/%Y %H:%M:%S"), 
      my_data$Sub_metering_3, type = "l", col = "blue" )

#Adds legend to graph
legend("topright", lty= 1, col = c("Black", "red", "blue"), 
       legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
#The plot is directly saved as 'plot3.png' in the working directory
