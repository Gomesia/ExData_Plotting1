#PLOT 2

#READ IN THE DATA
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
##Plot 2: dateTime vs gap
#initiate plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")
p2xrange <- range(df$dateTime)
p2yrange <- range(df$Global_active_power)
plot(p2xrange,p2yrange, type = "n", ylab = "Global Active Power (kilowatts)"
     , xlab = "")
#add data
lines(df$dateTime, df$Global_active_power, type = "l")
dev.off()
