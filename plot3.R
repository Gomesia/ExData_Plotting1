#PLOT 3

#READING IN THE DATA
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
##Plot 3: dateTime vs submetering
#initate plot
png(filename = "plot3.png", width = 480, height = 480, units = "px")
p3xrange <- range(df$dateTime)
p3yrange <- range(df$Sub_metering_1)
plot(p3xrange, p3yrange, type = "n", ylab = "Energy sub metering", xlab = "")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col = c("black", "red", "blue"), lty = 1, lwd = 1)
#sub 1
lines(df$dateTime, df$Sub_metering_1, type = "l", col = "black")
#sub 2
lines(df$dateTime, df$Sub_metering_2, type = "l", col = "red")
#sub 3
lines(df$dateTime, df$Sub_metering_3, type = "l", col = "blue")
dev.off()