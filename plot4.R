## PLOT 3

## Open & Read file
# read new line ';'
# remove missing values marked as '?'
data_full <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# Formatting dates
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
# use data in Date range 2007-02-01 to 2007-02-02
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- strptime(datetime, format="%Y-%m-%d %H:%M:%S")

## Plotting graph
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(data$Datetime, data$Global_active_power, type="l", 
       ylab="Global Active Power", xlab="")
  plot(data$Datetime, data$Voltage, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(data$Datetime, data$Sub_metering_1, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(data$Datetime, data$Sub_metering_2,col='Red')
  lines(data$Datetime, data$Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, cex = 0.65, lwd=c(1,1,1), bty="n", y.intersp =0.2,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
  plot(data$Datetime, data$Global_reactive_power, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Saving to PNG file
# height(480), width(480)
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
