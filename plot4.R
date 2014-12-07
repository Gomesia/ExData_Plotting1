#PLOT 4 

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
##Plot 4: Multi plots
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow= c(2,2))
p4xrange <- range(df$dateTime)

#plot 1
p4_1yrange <- range(df$Global_active_power)
plot(p4xrange,p4_1yrange, type = "n", ylab = "Global Active Power"
     , xlab = "")
lines(df$dateTime, df$Global_active_power, type = "l")

#plot 2
p4_2yrange <- range(df$Voltage)
plot(p4xrange, p4_2yrange, type = "n", ylab = "Voltage", xlab = "datetime")
lines(df$dateTime, df$Voltage, type = "l")

#plot 3
p4_3yrange <- range(df$Sub_metering_1)
plot(p4xrange, p4_3yrange, type = "n", ylab = "Energy sub metering", xlab = "")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col = c("black", "red", "blue"),cex = .9, lty = 1, lwd = 1, bty = "n")
lines(df$dateTime, df$Sub_metering_1, type = "l", col = "black")
lines(df$dateTime, df$Sub_metering_2, type = "l", col = "red")
lines(df$dateTime, df$Sub_metering_3, type = "l", col = "blue")

#plot 4
p4_4yrange<- range(df$Global_reactive_power)
plot(p4xrange, p4_4yrange, type = "n", ylab ="Global_reactive_power", xlab = "datetime")
lines(df$dateTime, df$Global_reactive_power, type = "l")

dev.off()