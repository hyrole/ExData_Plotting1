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
data$Datetime <- as.POSIXct(datetime)

## Plotting graph
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
 
legend("topright", col=c("black", "red", "blue"), lty=1, cex = 0.75, lwd=c(1,1,1),y.intersp =0.4,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to PNG file
# height(480), width(480)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
