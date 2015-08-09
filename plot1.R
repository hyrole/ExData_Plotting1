## PLOT 1

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

## Plotting histogram
hist(data$Global_active_power, main="Global Active Power", 
 xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to PNG file
# height(480), width(480)
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
