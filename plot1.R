#PLOT 1

#READING IN DATA
##read in entire table
rawData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

##load in libraries
library("dplyr")

## changing Date to date class
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")

rawData$Date <- as.Date(as.character(rawData$Date), format = "%d/%m/%Y")

##subset date for Feb 1,2 2007
df <- filter(rawData, Date == d1 | Date == d2)

##combine Date and Time into dateTime
df$Date <- as.character(df$Date)
df$Time <- as.character(df$Time)
df <- mutate(df, dateTime = paste(Date, Time, sep = " "))
df$dateTime <- strptime(df$dateTime, format = "%Y-%m-%d %H:%M:%S")
df <- select(df, dateTime, Global_active_power:Sub_metering_3)
df[,2:8]<- as.numeric(as.matrix(df[,2:8]))

#PLOTTING
##Plot 1: global active power vs frequency
png(filename = "plot1.png", width =480, height = 480, units = "px")
hist(df$Global_active_power, main = "Global Active Power", 
     xlab= "Global Active Power (kilowatts)", col= "red")
dev.off()